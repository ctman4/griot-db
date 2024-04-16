-- Create database
CREATE DATABASE griot;

-- Connect to the database
\c griot;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    family_id INT -- Add family_id column
);

-- Create Family Table
CREATE TABLE families (
    family_id SERIAL PRIMARY KEY,
    family_name VARCHAR(100) NOT NULL,
    admin_user_id INT NOT NULL
);

-- Add Foreign Key Constraints
ALTER TABLE users
ADD CONSTRAINT fk_family_id
FOREIGN KEY (family_id) REFERENCES families(family_id) ON DELETE SET NULL;

ALTER TABLE families
ADD CONSTRAINT fk_admin_user_id
FOREIGN KEY (admin_user_id) REFERENCES users(user_id);

-- Create Timeline Posts Table
CREATE TABLE timeline_posts (
    post_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    post_content TEXT NOT NULL,
    post_type VARCHAR(20) NOT NULL,
    post_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    family_id INT, -- Add family_id column
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (family_id) REFERENCES families(family_id) ON DELETE SET NULL
);

-- Create Family Users Table
CREATE TABLE family_users (
    family_id INT,
    user_id INT,
    PRIMARY KEY (family_id, user_id),
    FOREIGN KEY (family_id) REFERENCES families(family_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE invitations (
    invitation_id SERIAL PRIMARY KEY,
    sender_user_id INT NOT NULL,
    recipient_user_id INT NOT NULL,
    family_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (sender_user_id) REFERENCES users(user_id),
    FOREIGN KEY (recipient_user_id) REFERENCES users(user_id),
    FOREIGN KEY (family_id) REFERENCES families(family_id)
);
