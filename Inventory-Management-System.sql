-- SALES_STORE
CREATE TABLE sales_stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR (255) NOT NULL,
    phone VARCHAR (25),
    email VARCHAR (255),
    street VARCHAR (255),
    city VARCHAR (255),
    state VARCHAR (10),
    zip_code VARCHAR (5)
);

-- sales_staffs

CREATE TABLE sales_staffs (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active BOOLEAN NOT NULL,
    store_id INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (store_id) 
        REFERENCES sales_stores(store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) 
        REFERENCES sales_staffs(staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- production_categories

CREATE TABLE production_categories (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);


-- production_brands

CREATE TABLE production_brands (
	brand_id SERIAL PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);


-- production_products

CREATE TABLE production_products (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) 
        REFERENCES production_Categories (category_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) 
        REFERENCES production_brands (brand_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- sales_Customers 

CREATE TABLE sales_Customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

-- sales_orders

CREATE TABLE sales_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_status SMALLINT NOT NULL,
    -- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) 
        REFERENCES sales_customers (customer_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id) 
        REFERENCES sales_stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) 
        REFERENCES sales_staffs (staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- sales_order_items

CREATE TABLE sales_order_items(
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) 
        REFERENCES sales_orders (order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) 
        REFERENCES production_products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- production_stocks

CREATE TABLE production_stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) 
        REFERENCES sales_stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) 
        REFERENCES production_products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

