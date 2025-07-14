
import sqlite3
import pytest

from config import DB_PATH
conn = sqlite3.connect(DB_PATH)

@pytest.fixture(scope="module")
def db_connection():
    yield conn
    conn.close()

def test_order_has_valid_user(db_connection):
    cursor = db_connection.cursor()
    cursor.execute("""
        SELECT o.id FROM orders o
        LEFT JOIN users u ON o.user_id = u.id
        WHERE u.id IS NULL;
    """)
    invalid = cursor.fetchall()
    assert len(invalid) == 0, f"Orders with invalid user_id: {invalid}"

def test_no_negative_prices(db_connection):
    cursor = db_connection.cursor()
    cursor.execute("SELECT id FROM products WHERE price <= 0;")
    bad = cursor.fetchall()
    assert len(bad) == 0, f"Products with invalid price: {bad}"

def test_no_zero_or_negative_quantity(db_connection):
    cursor = db_connection.cursor()
    cursor.execute("SELECT id FROM orders WHERE quantity <= 0;")
    bad = cursor.fetchall()
    assert len(bad) == 0, f"Orders with invalid quantity: {bad}"

import datetime

def test_no_future_orders(db_connection):
    today = datetime.date.today().isoformat()
    cursor = db_connection.cursor()
    cursor.execute("SELECT id FROM orders WHERE order_date > ?", (today,))
    future = cursor.fetchall()
    assert len(future) == 0, f"Orders with future dates: {future}"

