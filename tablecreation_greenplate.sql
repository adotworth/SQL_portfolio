CREATE DATABASE restaurant;

\c restaurant;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT NOW()
);



CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date TIMESTAMP NOT NULL DEFAULT NOW(),
    total_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER,
    item_id INTEGER,
    quantity INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    item_id INTEGER,
    quantity INTEGER NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

CREATE TABLE recipes (
    recipe_id SERIAL PRIMARY KEY,
    item_id INTEGER,
    ingredient_id INTEGER,
    quantity DECIMAL(10, 2) NOT NULL,
    unit VARCHAR(20) NOT NULL
);

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);




ALTER TABLE orders
    ADD CONSTRAINT fk_customer
        FOREIGN KEY(customer_id)
            REFERENCES customers(customer_id)
            ON DELETE CASCADE
;


ALTER TABLE order_items
    ADD CONSTRAINT fk_order
        FOREIGN KEY(order_id)
            REFERENCES orders(order_id)
            ON DELETE CASCADE
;


ALTER TABLE order_items
    ADD CONSTRAINT fk_item
        FOREIGN KEY(item_id)
            REFERENCES items(item_id)
            ON DELETE CASCADE
;


ALTER TABLE inventory
    ADD CONSTRAINT fk_item
        FOREIGN KEY(item_id)
            REFERENCES items(item_id)
            ON DELETE CASCADE
;


ALTER TABLE recipes
    ADD CONSTRAINT fk_item
        FOREIGN KEY(item_id)
            REFERENCES items(item_id)
            ON DELETE CASCADE
;


ALTER TABLE recipes
    ADD CONSTRAINT fk_inventory
        FOREIGN KEY(ingredient_id)
            REFERENCES inventory(inventory_id)
            ON DELETE CASCADE
;