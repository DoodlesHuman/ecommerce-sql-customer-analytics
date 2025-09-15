CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	join_date DATE NOT NULL,
	city VARCHAR(50),
	postal_code VARCHAR(10)
);

CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	category VARCHAR(50),
	price DECIMAL(10, 2) NOT NULL,
	sustainability_rating INT
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id INT NOT NULL,
	order_date DATE NOT NULL,
	total_amount DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE marketing(
	campaign_id INT PRIMARY KEY,
	campaign_name VARCHAR(100) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL
	
)