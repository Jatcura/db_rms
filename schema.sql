-- ----------------------------
-- Tables
-- ----------------------------

-- Create restauracountriesnts table
CREATE TABLE IF NOT EXISTS countries (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL UNIQUE,
    code CHAR(2) UNIQUE
);

-- Create cities table
CREATE TABLE IF NOT EXISTS cities (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    country_id INTEGER NOT NULL,
    CONSTRAINT fk_country
        FOREIGN KEY(country_id)
        REFERENCES countries(id)
        ON DELETE RESTRICT,
    UNIQUE (name, country_id)
);

-- Create persons table
CREATE TABLE IF NOT EXISTS persons (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    personal_phone_number VARCHAR(50),
    personal_email_address VARCHAR(255) UNIQUE,
    date_of_birth DATE
);

-- Create staff_roles table
CREATE TABLE IF NOT EXISTS staff_roles (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create employments table
CREATE TABLE IF NOT EXISTS employments (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    person_id INTEGER NOT NULL,
    restaurant_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    hire_date DATE NOT NULL,
    termination_date DATE,
    CONSTRAINT fk_employment_person
        FOREIGN KEY(person_id)
        REFERENCES persons(id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_employment_restaurant
        FOREIGN KEY(restaurant_id)
        REFERENCES restaurants(id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_employment_role
        FOREIGN KEY(role_id)
        REFERENCES staff_roles(id)
        ON DELETE RESTRICT
);

-- Create restaurants table
CREATE TABLE IF NOT EXISTS restaurants (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city_id INTEGER NOT NULL,
    phone_number VARCHAR(50),
    email_address VARCHAR(255) UNIQUE,
    operating_hours VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(10,6)с
    CONSTRAINT fk_city
        FOREIGN KEY(city_id)
        REFERENCES cities(id)
        ON DELETE RESTRICT
);

-- Create menu_categories table
CREATE TABLE IF NOT EXISTS menu_categories (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create menu_items table
CREATE TABLE IF NOT EXISTS menu_items (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    category_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    is_vegetarian BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_menu_item_category
        FOREIGN KEY(category_id)
        REFERENCES menu_categories(id)
        ON DELETE RESTRICT
);

-- Create restaurant_menu_items table
CREATE TABLE IF NOT EXISTS restaurant_menu_items (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    restaurant_id INTEGER NOT NULL,
    menu_item_id INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,      
    is_available BOOLEAN DEFAULT TRUE,  

    CONSTRAINT fk_restaurant_menu_restaurant
        FOREIGN KEY(restaurant_id)
        REFERENCES restaurants(id)
        ON DELETE CASCADE, 
    CONSTRAINT fk_restaurant_menu_item
        FOREIGN KEY(menu_item_id)
        REFERENCES menu_items(id)
        ON DELETE CASCADE, 
    UNIQUE (restaurant_id, menu_item_id)
);