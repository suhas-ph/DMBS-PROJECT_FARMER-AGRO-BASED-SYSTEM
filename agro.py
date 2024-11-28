import streamlit as st
import pandas as pd
import mysql.connector
from datetime import datetime
import bcrypt
import random

# Database connection
def get_database_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Suhas@1390",
        database="agro_system"
    )

# Initialize database with triggers 
def init_database():
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    
    
    # Trigger 2: Auto-update order total amount
    trigger_order_total = """
    CREATE TRIGGER calculate_order_total
    AFTER INSERT ON order_items
    FOR EACH ROW
    BEGIN
        UPDATE orders 
        SET total_amount = (
            SELECT SUM(item_total)
            FROM order_items
            WHERE order_id = NEW.order_id
        )
        WHERE order_id = NEW.order_id;
    END;
    """

    
    try:
       
        cursor.execute(trigger_order_total)
        conn.commit()
    except:
        pass
    finally:
        cursor.close()
        conn.close()

# Sidebar navigation
def sidebar_navigation():
    st.sidebar.title("Navigation")
    user_type = st.sidebar.selectbox("Select User Type", ["Buyer", "Farmer"])
    
    if user_type == "Buyer":
        action = st.sidebar.selectbox(
            "Choose Action",
            ["Login", "Register", "Browse Products", "My Orders", "Write Review"]
        )
    else:
        action = st.sidebar.selectbox(
            "Choose Action",
            ["Login", "Register", "Manage Products", "View Sales"]
        )
    
    return user_type, action

# Authentication functions using bcrypt for password hashing
def hash_password(password):
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def check_password(stored_hash, password):
    return bcrypt.checkpw(password.encode(), stored_hash.encode())

def login_user(email, password, user_type):
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    table = "buyers" if user_type == "Buyer" else "farmers"
    cursor.execute(
        f"SELECT * FROM {table} WHERE email = %s",
        (email,)
    )
    user = cursor.fetchone()
    
    cursor.close()
    conn.close()
    
    if user and check_password(user['password'], password):
        return user
    else:
        return None

def register_user(name, email, phone, password, user_type):
    conn = get_database_connection()
    cursor = conn.cursor()
    
    table = "buyers" if user_type == "Buyer" else "farmers"
    try:
        hashed_password = hash_password(password)
        cursor.execute(
            f"INSERT INTO {table} (name, email, phone_no, password) VALUES (%s, %s, %s, %s)",
            (name, email, phone, hashed_password)
        )
        conn.commit()
        return True
    except Exception as e:
        print(e)
        return False
    finally:
        cursor.close()
        conn.close()

# Product management
def add_product(farmer_id, name, description, price, quantity):
    conn = get_database_connection()
    cursor = conn.cursor()
    
    try:
        cursor.execute(
            "INSERT INTO products (farmer_id, product_name, product_description, unit_price, quantity) VALUES (%s, %s, %s, %s, %s)",
            (farmer_id, name, description, price, quantity)
        )
        conn.commit()
        return True
    except:
        return False
    finally:
        cursor.close()
        conn.close()

def update_stock(farmer_id, product_id, new_quantity):
    conn = get_database_connection()
    cursor = conn.cursor()
    
    try:
        cursor.callproc("update_stock_quantity", [product_id, new_quantity])
        conn.commit()
        return True
    except Exception as e:
        print(e)
        return False
    finally:
        cursor.close()
        conn.close()


def get_products():
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    cursor.execute("""SELECT p.*, f.name as farmer_name 
        FROM products p 
        JOIN farmers f ON p.farmer_id = f.farmer_id
    """)
    products = cursor.fetchall()
    
    cursor.close()
    conn.close()
    return products

# Order management
def create_order(buyer_id, product_id, quantity):
    conn = get_database_connection()
    cursor = conn.cursor()
    
    try:
        # Create the order
        cursor.execute(
            "INSERT INTO orders (buyer_id, order_date) VALUES (%s, %s)",
            (buyer_id, datetime.now())
        )
        order_id = cursor.lastrowid
        
        # Get product price
        cursor.execute("SELECT unit_price FROM products WHERE product_id = %s", (product_id,))
        unit_price = cursor.fetchone()[0]
        
        # Create the order item
        cursor.execute(
            """INSERT INTO order_items 
            (order_id, product_id, quantity, price_at_time, item_total) 
            VALUES (%s, %s, %s, %s, %s)""",
            (order_id, product_id, quantity, unit_price, quantity * unit_price)
        )
        
        # Update the product quantity via procedure
        cursor.callproc("update_stock_quantity", [product_id, quantity])
        
        conn.commit()
        return order_id
    except mysql.connector.Error as e:
        st.error(f"Error: {e}")
        conn.rollback()
        return None
    finally:
        cursor.close()
        conn.close()

# Fetching products with complex join and filtering
def get_products():
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
    SELECT p.*, 
           f.name AS farmer_name, 
           CASE 
               WHEN p.quantity > 50 THEN 'High Stock'
               WHEN p.quantity BETWEEN 10 AND 50 THEN 'Medium Stock'
               ELSE 'Low Stock'
           END AS stock_status,
           (SELECT AVG(rating) FROM reviews WHERE reviews.product_id = p.product_id) AS avg_rating
    FROM products p 
    JOIN farmers f ON p.farmer_id = f.farmer_id
    WHERE p.quantity > 0
    ORDER BY avg_rating DESC, p.unit_price ASC;
    """
    
    cursor.execute(query)
    products = cursor.fetchall()
    

    cursor.close()
    conn.close()
    return products


# Fetching orders with aggregated totals and product details
def get_orders(buyer_id):
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
   SELECT o.order_id, 
       o.order_date,
       oi.quantity,
       SUM(oi.item_total) AS total_order_amount,
       COUNT(DISTINCT oi.product_id) AS total_products,
       GROUP_CONCAT(p.product_name SEPARATOR ', ') AS product_name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.buyer_id = %s
GROUP BY o.order_id, o.order_date, oi.quantity
ORDER BY o.order_date DESC;

    """
    
    cursor.execute(query, (buyer_id,))
    orders = cursor.fetchall()
    
    cursor.close()
    conn.close()
    return orders

# Fetching sales data for a farmer with aggregate totals and date range filtering
def get_sales_data(farmer_id, start_date=None, end_date=None):
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
    SELECT o.order_id,
           p.product_name,
           SUM(oi.quantity) AS total_quantity_sold,
           SUM(oi.item_total) AS total_sales,
           o.order_date
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.farmer_id = %s
          AND o.order_date BETWEEN %s AND %s
    GROUP BY o.order_id, p.product_id
    ORDER BY total_sales DESC, total_quantity_sold DESC;
    """
    
    if not start_date:
        start_date = "1900-01-01"
    if not end_date:
        end_date = "2100-12-31"
    
    cursor.execute(query, (farmer_id, start_date, end_date))
    sales_data = cursor.fetchall()
   
    
    cursor.close()
    conn.close()
    return sales_data
def get_top_products():
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
    SELECT p.product_name, 
           p.unit_price, 
           AVG(r.rating) AS avg_rating, 
           f.name AS farmer_name
    FROM products p
    LEFT JOIN reviews r ON p.product_id = r.product_id
    LEFT JOIN farmers f ON p.farmer_id = f.farmer_id
    WHERE p.quantity > 0
    GROUP BY p.product_id
    HAVING avg_rating IS NOT NULL
    ORDER BY avg_rating DESC
    LIMIT 10;
    """
    
    cursor.execute(query)
    top_products = cursor.fetchall()
    
    cursor.close()
    conn.close()
    return top_products


# Example function to fetch farmer performance
def get_farmer_performance(farmer_id):
    conn = get_database_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
    SELECT f.name AS farmer_name, 
           COUNT(DISTINCT p.product_id) AS total_products,
           (SELECT COUNT(*) 
            FROM orders o 
            JOIN order_items oi ON o.order_id = oi.order_id
            WHERE oi.product_id IN (
                SELECT product_id 
                FROM products 
                WHERE farmer_id = f.farmer_id
            )) AS total_orders,
           COALESCE(SUM(oi.item_total), 0) AS total_earnings,
           (SELECT AVG(r.rating)
            FROM reviews r
            WHERE r.product_id IN (
                SELECT product_id 
                FROM products 
                WHERE farmer_id = f.farmer_id
            )) AS avg_rating
    FROM farmers f
    LEFT JOIN products p ON f.farmer_id = p.farmer_id
    LEFT JOIN order_items oi ON oi.product_id = p.product_id
    WHERE f.farmer_id = %s
    GROUP BY f.farmer_id;
    """
    
    cursor.execute(query, (farmer_id,))
    performance = cursor.fetchone()
    
    cursor.close()
    conn.close()
    return performance

# Review management function
def add_review(buyer_id, product_id, rating, review_text):
    conn = get_database_connection()
    cursor = conn.cursor()
    
    try:
        cursor.execute(
            """INSERT INTO reviews 
            (buyer_id, product_id, rating, review_text, review_date) 
            VALUES (%s, %s, %s, %s, %s)""",
            (buyer_id, product_id, rating, review_text, datetime.now())
        )
        conn.commit()
        return True
    except:
        return False
    finally:
        cursor.close()
        conn.close()

# Main app function
def main():
    st.title("Farmer-Buyer Agro Based System")
    
    # Initialize database and triggers
    init_database()
    
    # Check if user is logged in
    if "user" not in st.session_state:
        # If not logged in, show login/register options
        user_type, action = sidebar_navigation()
        
        if action == "Login":
            st.subheader("Login")
            email = st.text_input("Email")
            password = st.text_input("Password", type="password")
            
            if st.button("Login"):
                user = login_user(email, password, user_type)
                if user:
                    st.session_state["user"] = user
                    st.session_state["user_type"] = user_type
                    st.success(f"Welcome back, {user['name']}!")
                else:
                    st.error("Invalid credentials")
        
        elif action == "Register":
            st.subheader("Register")
            name = st.text_input("Name")
            email = st.text_input("Email")
            phone = st.text_input("Phone")
            password = st.text_input("Password", type="password")
            
            if st.button("Register"):
                if register_user(name, email, phone, password, user_type):
                    st.success("Registration successful! Please log in.")
                else:
                    st.error("Registration failed")
    
    else:
        # Display user actions after login
        user_type = st.session_state["user_type"]
        user = st.session_state["user"]
        
        if user_type == "Buyer":
            action = st.sidebar.selectbox(
                "Choose Action", ["Browse Products", "My Orders", "Write Review", "Top Products"]
            )
            
            if action == "Browse Products":
                products = get_products()
                for product in products:
                    st.subheader(product["product_name"])
                    st.write(f"Description: {product['product_description']}")
                    st.write(f"Price: ₹{product['unit_price']}")
                    st.write(f"Stock: {product['quantity']}")
                    
                    if product["quantity"] > 0:
                        quantity = st.number_input(
                            f"Quantity for {product['product_name']}",
                            min_value=1, max_value=product["quantity"], step=1
                        )
                        if st.button(f"Add {product['product_name']} to Cart"):
                            order_id = create_order(user["buyer_id"], product["product_id"], quantity)
                            st.success(f"Order created! Order ID: {order_id}")
                    else:
                        st.warning(f"{product['product_name']} is out of stock!")
            
            elif action == "My Orders":
                orders = get_orders(user["buyer_id"])
                if orders:
                    for order in orders:
                        st.subheader(f"Order ID: {order['order_id']}")
                        st.write(f"Date: {order['order_date']}")
                        st.write(f"Product: {order['product_name']}")
                        st.write(f"Quantity: {order['quantity']}")
                        st.write(f"Total: ₹{order['total_order_amount']}")
                else:
                    st.write("You have no orders.")
            
            elif action == "Write Review":
                products = get_products()
                product_mapping = {p["product_name"]: p for p in products}
                selected_product_name = st.selectbox(
                    "Select Product to Review", list(product_mapping.keys())
                )
                rating = st.slider("Rating", 1, 5)
                review_text = st.text_area("Review Text")
                
                if st.button("Submit Review"):
                    selected_product = product_mapping[selected_product_name]
                    add_review(user["buyer_id"], selected_product["product_id"], rating, review_text)
                    st.success("Review submitted!")
            
            elif action == "Top Products":
                top_products = get_top_products()
                st.subheader("Top Rated Products")
                if top_products:
                    for product in top_products:
                        st.write(f"**{product['product_name']}** by {product['farmer_name']}")
                        st.write(f"Rating: {product['avg_rating']} - Price: ₹{product['unit_price']}")
                        st.write(f"Rank: {product['rank']}")
                else:
                    st.write("No top-rated products found.")
        
        elif user_type == "Farmer":
            action = st.sidebar.selectbox(
                "Choose Action", ["Manage Products", "View Sales", "Farmer Performance", "Top Products"]
            )
            
            if action == "Manage Products":
                st.subheader("Add New Product")
                name = st.text_input("Product Name")
                description = st.text_area("Product Description")
                price = st.number_input("Price per Unit", min_value=0.0, step=0.01)
                quantity = st.number_input("Quantity", min_value=0, step=1)
                
                if st.button("Add Product"):
                    add_product(user["farmer_id"], name, description, price, quantity)
                    st.success("Product added!")
            
            elif action == "View Sales":
                sales_data = get_sales_data(user["farmer_id"])
                if sales_data:
                    for sale in sales_data:
                        st.subheader(f"Order ID: {sale['order_id']}")
                        st.write(f"Product: {sale['product_name']}")
                        st.write(f"Quantity: {sale['total_quantity_sold']}")
                        st.write(f"Total: ₹{sale['total_sales']}")
                        st.write(f"Date: {sale['order_date']}")
                else:
                    st.write("No sales yet.")
            
            elif action == "Farmer Performance":
                performance = get_farmer_performance(user["farmer_id"])
                if performance:
                    st.write(f"Farmer: {performance['farmer_name']}")
                    st.write(f"Total Products Sold: {performance['total_products']}")
                    st.write(f"Total Orders: {performance['total_orders']}")
                    st.write(f"Total Earnings: ₹{performance['total_earnings']}")
                    st.write(f"Average Rating: {performance['avg_rating']}")
                else:
                    st.write("No performance data found.")
            
            elif action == "Top Products":
                top_products = get_top_products()
                st.subheader("Top Rated Products")
                if top_products:
                    for product in top_products:
                        st.write(f"**{product['product_name']}** by {product['farmer_name']}")
                        st.write(f"Rating: {product['avg_rating']} - Price: ₹{product['unit_price']}")
                else:
                    st.write("No top-rated products found.")

if __name__ == "__main__":
    main()