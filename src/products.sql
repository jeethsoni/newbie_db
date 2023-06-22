/*
Name - Jeet Soni
Description - A online grocery shopping database design  
Database - mysql v8.0.33
*/


-- user related information table
CREATE TABLE if not exists users(
    user_id INT NOT NULL AUTO_INCREMENT,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    street_address varchar(100) NOT NULL,
    city varchar(50) NOT NULL,
    state varchar(75) NOT NULL,
    zipcode varchar(20) NOT NULL,
    phone_number varchar(20) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    primary key (user_id)

);

-- order status table 
create table if not exists order_status(
    status_id INT NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    primary key(status_id)
);

-- shipping status table 
create table if not exists shipped_status(
    shipped_status_id INT NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    primary key(shipped_status_id)
);

-- order table  
CREATE TABLE if not exists orders(
    order_id INT NOT NULL AUTO_INCREMENT ,
    product_id INT NOT NULL,
    quantity_purchased varchar(1000) NOT NULL,
    order_date date NOT NULL,
    status_id INT NOT NULL,
    shipping_date date NOT NULL,
    shipped_status_id INT NOT NULL,
    tracking_number varchar(200) NOT NULL,
    payment_id INT NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    primary key (order_id),
    foreign key (product_id) REFERENCES product(product_id),
    foreign key (status_id) REFERENCES order_status(status_id),
    foreign key (shipped_status_id) REFERENCES shipped_status(shipped_status_id),
    foreign key (payment_id) REFERENCES payment(payment_id)
);

-- product table 
CREATE TABLE if not exists product(
    product_id INT NOT NULL AUTO_INCREMENT,
    name varchar(200) NOT NULL,
    cost varchar(50) NOT NULL,
    description varchar (1000) NOT NULL,
    product_discontinued BOOLEAN NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    primary key (product_id)
);

-- catagory table
CREATE TABLE if not exists catagory(
    catagory_id INT NOT NULL AUTO_INCREMENT,
    product_cat varchar(100) NOT NULL,
    cat_description varchar(1000) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    primary key (catagory_id)
);

-- order payment table
CREATE TABLE if not exists payment(
    payment_id INT NOT NULL,
    type_id INT NOT NULL,
    amount float NOT NULL,
    pay_date DATE NOT NULL,
    status BOOLEAN NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    foreign key (type_id) REFERENCES pay_type(type_id)
);


-- payment type like bank, check, credit, debit etc
CREATE TABLE if not exists pay_type(
    type_id INT NOT NULL,
    name varchar(50) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    primary key(type_id)
);

-- 1 user_id to N user_id(user_order) table
-- 1 order_id to N order_id(user_order) table
CREATE TABLE if not exists user_order(
    user_id int NOT NULL,
    order_id int NOT NULL,
    primary key (user_id, order_id),
    foreign key (user_id) REFERENCES users(user_id),
    foreign key (order_id) REFERENCES orders(order_id)

);

-- 1 product_id to N product_id(product_catagory) table
-- 1 catagory_id to N catagory_id(product_catagory) table
CREATE TABLE if not exists product_catagory(
    product_id int NOT NULL,
    catagory_id int NOT NULL,
    primary key (product_id, catagory_id),
    foreign key (product_id) REFERENCES product(product_id),
    foreign key (catagory_id) REFERENCES catagory(catagory_id)
);