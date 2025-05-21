-- ----------------------------
-- Tables
-- ----------------------------

-- Create restaurants table
CREATE TABLE IF NOT EXISTS restaurants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    phone_number VARCHAR(50),
    email_address VARCHAR(255) UNIQUE,
    operating_hours TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Trigger Functions
-- ----------------------------

-- Function to automatically update the updated_at field
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ----------------------------
-- Triggers
-- ----------------------------

-- Trigger for the restaurants table to update updated_at
CREATE TRIGGER set_timestamp_restaurants
BEFORE UPDATE ON restaurants
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();
