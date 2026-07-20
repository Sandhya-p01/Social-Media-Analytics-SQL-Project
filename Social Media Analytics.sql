CREATE DATABASE social_media_db;
USE social_media_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    post_date DATE,
    content_type VARCHAR(30),
    views INT,
    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

CREATE TABLE engagement (
    engagement_id INT PRIMARY KEY,
    post_id INT,
    likes INT,
    comments INT,
    shares INT,
    FOREIGN KEY (post_id)
        REFERENCES posts(post_id)
);

INSERT INTO users VALUES
(1,'Rahul','Mumbai','2024-01-10'),
(2,'Priya','Delhi','2024-02-15'),
(3,'Amit','Pune','2024-03-08'),
(4,'Sneha','Bangalore','2024-04-05'),
(5,'Rohan','Hyderabad','2024-05-12');

INSERT INTO posts VALUES
(101,1,'2025-01-05','Image',1200),
(102,2,'2025-01-06','Video',5400),
(103,3,'2025-01-06','Reel',8900),
(104,4,'2025-01-07','Image',2500),
(105,5,'2025-01-08','Video',6100);

INSERT INTO engagement VALUES
(1,101,180,22,15),
(2,102,520,84,60),
(3,103,950,145,110),
(4,104,240,35,20),
(5,105,610,92,70);

-- Total Users
SELECT COUNT(*) AS total_users
FROM users;

SELECT COUNT(*) AS total_posts
FROM posts;

SELECT SUM(views) AS total_views
FROM posts;

SELECT
SUM(likes) AS total_likes,
SUM(comments) AS total_comments,
SUM(shares) AS total_shares
FROM engagement;

SELECT AVG(views) AS avg_views
FROM posts;

SELECT
content_type,
COUNT(*) AS total_posts
FROM posts
GROUP BY content_type;

SELECT *
FROM posts
ORDER BY views DESC
LIMIT 1;

SELECT
u.user_name,
SUM(p.views) AS total_views
FROM users u
JOIN posts p
ON u.user_id=p.user_id
GROUP BY u.user_name
ORDER BY total_views DESC;

SELECT
city,
COUNT(*) AS users
FROM users
GROUP BY city;

SELECT
MONTH(join_date) AS month,
COUNT(*) AS new_users
FROM users
GROUP BY MONTH(join_date);

SELECT
MONTH(post_date) AS month,
COUNT(*) AS posts
FROM posts
GROUP BY MONTH(post_date);

SELECT
post_id,
likes+comments+shares AS total_engagement
FROM engagement;

SELECT
p.post_id,
ROUND(
((likes+comments+shares)/views)*100,
2
) AS engagement_rate
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id;

SELECT
p.post_id,
likes
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
ORDER BY likes DESC
LIMIT 1;

SELECT
p.post_id,
shares
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
ORDER BY shares DESC
LIMIT 1;

SELECT
content_type,
AVG(likes+comments+shares) AS avg_engagement
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
GROUP BY content_type;

SELECT
u.user_name,
COUNT(post_id) AS posts
FROM users u
LEFT JOIN posts p
ON u.user_id=p.user_id
GROUP BY u.user_name;

SELECT
u.user_name,
SUM(views) AS views
FROM users u
JOIN posts p
ON u.user_id=p.user_id
GROUP BY u.user_name
ORDER BY views DESC
LIMIT 3;

SELECT
    u.user_name,
    COUNT(p.post_id) AS posts,
    SUM(p.views) AS total_views,
    SUM(e.likes) AS total_likes
FROM users u
JOIN posts p
    ON u.user_id = p.user_id
JOIN engagement e
    ON p.post_id = e.post_id
GROUP BY u.user_name;

SELECT
post_id,
views,
RANK() OVER(ORDER BY views DESC) AS ranking
FROM posts;

SELECT
post_id,
views,
DENSE_RANK() OVER(ORDER BY views DESC) rank_no
FROM posts;

SELECT
post_id,
views,
SUM(views) OVER(ORDER BY post_date) running_total
FROM posts;

WITH creator_views AS
(
SELECT
user_id,
SUM(views) total_views
FROM posts
GROUP BY user_id
)

SELECT
*
FROM creator_views;

SELECT
user_name,
SUM(views) total_views
FROM users u
JOIN posts p
ON u.user_id=p.user_id
GROUP BY user_name
HAVING SUM(views)>
(
SELECT AVG(views)
FROM posts
);

SELECT
post_id,
views,
CASE
WHEN views>8000 THEN 'Viral'
WHEN views>5000 THEN 'Popular'
ELSE 'Normal'
END AS category
FROM posts;

SELECT
p.post_id,
likes+comments+shares engagement
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
ORDER BY engagement DESC;

SELECT
u.user_name,
AVG(likes) avg_likes
FROM users u
JOIN posts p
ON u.user_id=p.user_id
JOIN engagement e
ON p.post_id=e.post_id
GROUP BY u.user_name;

SELECT
post_id,
views,
ROUND(
views*100/
(SELECT SUM(views) FROM posts),
2
) contribution
FROM posts;

SELECT
content_type,
SUM(views) total_views,
SUM(likes) total_likes,
SUM(comments) total_comments,
SUM(shares) total_shares
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
GROUP BY content_type;

SELECT
COUNT(DISTINCT u.user_id) AS users,
COUNT(DISTINCT p.post_id) AS posts,
SUM(views) AS total_views,
SUM(likes) AS total_likes,
SUM(comments) AS total_comments,
SUM(shares) AS total_shares,
ROUND(AVG(views),2) AS avg_views
FROM users u
JOIN posts p
ON u.user_id=p.user_id
JOIN engagement e
ON p.post_id=e.post_id;






