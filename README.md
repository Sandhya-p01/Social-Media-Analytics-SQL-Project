# 📱 Social Media Analytics Using SQL

## 📌 Project Overview

Social media platforms generate massive amounts of user activity data every day, including user registrations, posts, views, likes, comments, and shares. Analyzing this data helps businesses understand user behavior, improve engagement strategies, identify trending content, and optimize platform growth.

This project focuses on building a **Social Media Analytics Database using MySQL** and performing SQL-based analysis to extract meaningful business insights.

The project analyzes:
- User growth
- Content performance
- Creator performance
- Engagement metrics
- Trending posts
- Platform activity

The analysis demonstrates real-world SQL skills used by **Data Analysts, Product Analysts, Growth Analysts, and Business Intelligence teams**.

---

# 🎯 Business Objectives

The main objectives of this project are:

✅ Analyze user growth trends  
✅ Measure content engagement  
✅ Identify active users  
✅ Find trending and viral posts  
✅ Analyze creator performance  
✅ Track platform activity  
✅ Calculate engagement metrics  
✅ Generate business insights for decision-making  

---

# 🗂️ Database Schema

The database consists of three relational tables:

            USERS
              |
              |
              |
            POSTS
              |
              |
              |
         ENGAGEMENT


---

# 📊 Database Tables

## 1. Users Table

Stores user profile information.

| Column | Description |
|--------|-------------|
| user_id | Unique identifier for users |
| user_name | Name of the user |
| city | User location |
| join_date | Date user joined the platform |

---

## 2. Posts Table

Stores information about content uploaded by users.

| Column | Description |
|--------|-------------|
| post_id | Unique identifier for posts |
| user_id | User who created the post |
| post_date | Date of publishing |
| content_type | Type of content |
| views | Number of views received |

Content Types:
- Image
- Video
- Reel

---

## 3. Engagement Table

Stores audience interaction metrics.

| Column | Description |
|--------|-------------|
| engagement_id | Unique engagement record |
| post_id | Associated post |
| likes | Number of likes |
| comments | Number of comments |
| shares | Number of shares |

---

# 🛠️ Tools & Technologies

## Database
- MySQL

## Development Tool
- MySQL Workbench

## Version Control
- GitHub

## Skills Demonstrated
- SQL
- Data Analysis
- Business Intelligence
- Database Design

---

# 🧠 SQL Concepts Used

## Basic SQL

- CREATE DATABASE
- CREATE TABLE
- INSERT
- SELECT
- WHERE
- ORDER BY

## Data Analysis

- Aggregate Functions
  - COUNT()
  - SUM()
  - AVG()

- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN

## Advanced SQL

- CASE WHEN
- Common Table Expressions (CTEs)
- Subqueries
- Window Functions
- Ranking Functions
- Date Functions

---

# 📈 Key Business KPIs Analyzed

## 👥 User Analytics

- Total Users
- User Growth
- Monthly New Users
- City-wise User Distribution


## 📝 Content Analytics

- Total Posts
- Posts by Content Type
- Total Views
- Average Views Per Post
- Most Viewed Posts


## ❤️ Engagement Analytics

- Total Likes
- Total Comments
- Total Shares
- Engagement Rate
- Average Engagement Per Post


## ⭐ Creator Analytics

- Top Creators
- Creator Performance Ranking
- Highest Viewed Creators
- Most Engaging Creators


## 🚀 Platform Analytics

- Overall Platform Activity
- Viral Content Identification
- Content Performance Comparison
- Growth Analysis

---

# 🔍 Analysis Performed

## 1. User Growth Analysis

Analyzed user registrations to understand platform growth trends.

Key metrics:
- Number of registered users
- Monthly user additions
- User distribution by city


---

## 2. Content Performance Analysis

Compared different content formats to understand which type performs better.

Analyzed:

- Views
- Likes
- Comments
- Shares
- Engagement Rate


---

## 3. Creator Performance Analysis

Identified high-performing creators based on:

- Total views
- Total posts
- Engagement received


---

## 4. Trending Content Analysis

Analyzed posts to identify:

- Most viewed posts
- Most liked posts
- Most shared posts
- Viral content



# 📊 Sample SQL Analysis Queries

## 1. Total Users Analysis

**Business Question:**  
How many users are registered on the platform?

```sql
-- Calculate total number of users

SELECT 
    COUNT(*) AS total_users
FROM users;
```

---

## 2. Top Creators by Total Views

**Business Question:**  
Which creators generate the highest number of views?

```sql
-- Find creators with maximum views

SELECT
    u.user_name,
    SUM(p.views) AS total_views
FROM users u
JOIN posts p
ON u.user_id = p.user_id
GROUP BY u.user_name
ORDER BY total_views DESC;
```

---

## 3. Content Performance Analysis

**Business Question:**  
Which content type performs better based on views and engagement?

```sql
-- Analyze performance of different content types

SELECT
    p.content_type,
    SUM(p.views) AS total_views,
    SUM(e.likes) AS total_likes,
    SUM(e.comments) AS total_comments,
    SUM(e.shares) AS total_shares
FROM posts p
JOIN engagement e
ON p.post_id = e.post_id
GROUP BY p.content_type;
```

---

## 4. Engagement Rate Calculation

**Business Question:**  
How engaging is each post compared to its views?

```sql
-- Calculate engagement rate for each post

SELECT
    p.post_id,
    p.views,
    (e.likes + e.comments + e.shares) AS total_engagement,
    ROUND(
        ((e.likes + e.comments + e.shares) / p.views) * 100,
        2
    ) AS engagement_rate
FROM posts p
JOIN engagement e
ON p.post_id = e.post_id;
```

---

## 5. Most Viral Posts

**Business Question:**  
Which posts are trending based on views?

```sql
-- Identify highest viewed posts

SELECT
    post_id,
    content_type,
    views
FROM posts
ORDER BY views DESC
LIMIT 5;
```

---

## 6. Creator Performance Ranking

**Business Question:**  
How do creators rank based on total views?

```sql
-- Rank creators based on views using window functions

SELECT
    u.user_name,
    SUM(p.views) AS total_views,
    RANK() OVER(
        ORDER BY SUM(p.views) DESC
    ) AS creator_rank
FROM users u
JOIN posts p
ON u.user_id = p.user_id
GROUP BY u.user_name;
```

---

## 7. Monthly User Growth

**Business Question:**  
How is the user base growing over time?

```sql
-- Analyze monthly user registrations

SELECT
    MONTH(join_date) AS month,
    COUNT(*) AS new_users
FROM users
GROUP BY MONTH(join_date)
ORDER BY month;
```

# 📸 Project Screenshots

## Total Users Analysis

![Total Users](screenshots/Total_Users.png)

---

## Top Creators by Views

![Top Creators by Views](screenshots/Top_Creators_by_Views.png)

---

## Top 3 Creators Analysis

![Top 3 Creators](screenshots/Top_3_Creators.png)

---

## Content Type Performance

![Content Type Performance](screenshots/Content_Type_Performance.png)

---

## Engagement Rate Analysis

![Engagement Rate](screenshots/Engagement_Rate.png)

---

## Rank Posts by Views

![Rank Posts by Views](screenshots/Rank_Posts_by_Views.png)
