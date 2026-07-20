-- Total Users
SELECT COUNT(*) AS total_users
FROM users;

-- Total Posts
SELECT COUNT(*) AS total_posts
FROM posts;

-- Total Views
SELECT SUM(views) AS total_views
FROM posts;

-- Total Likes, Comments, Shares
SELECT
SUM(likes) AS total_likes,
SUM(comments) AS total_comments,
SUM(shares) AS total_shares
FROM engagement;

-- Average Views Per Post
SELECT AVG(views) AS avg_views
FROM posts;

-- Posts by Content Type
SELECT
content_type,
COUNT(*) AS total_posts
FROM posts
GROUP BY content_type;

-- Most Viewed Post
SELECT *
FROM posts
ORDER BY views DESC
LIMIT 1;

-- Top Creator by Views
SELECT
u.user_name,
SUM(p.views) AS total_views
FROM users u
JOIN posts p
ON u.user_id=p.user_id
GROUP BY u.user_name
ORDER BY total_views DESC;

-- City-wise User Count
SELECT
city,
COUNT(*) AS users
FROM users
GROUP BY city;

-- Monthly User Growth
SELECT
MONTH(join_date) AS month,
COUNT(*) AS new_users
FROM users
GROUP BY MONTH(join_date);

-- Posting Trend
SELECT
MONTH(post_date) AS month,
COUNT(*) AS posts
FROM posts
GROUP BY MONTH(post_date);

-- Total Engagement Per Post
SELECT
post_id,
likes+comments+shares AS total_engagement
FROM engagement;

-- Engagement Rate
SELECT
p.post_id,
ROUND(
((likes+comments+shares)/views)*100,
2
) AS engagement_rate
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id;

-- Most Liked Post
SELECT
p.post_id,
likes
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
ORDER BY likes DESC
LIMIT 1;

-- Most Shared Post
SELECT
p.post_id,
shares
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
ORDER BY shares DESC
LIMIT 1;

-- Average Engagement by Content Type
SELECT
content_type,
AVG(likes+comments+shares) AS avg_engagement
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
GROUP BY content_type;

-- User-wise Total Posts
SELECT
u.user_name,
COUNT(post_id) AS posts
FROM users u
LEFT JOIN posts p
ON u.user_id=p.user_id
GROUP BY u.user_name;

-- Top 3 Creators
SELECT
u.user_name,
SUM(views) AS views
FROM users u
JOIN posts p
ON u.user_id=p.user_id
GROUP BY u.user_name
ORDER BY views DESC
LIMIT 3;

-- Creator Performance
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

-- Rank Posts by Views
SELECT
post_id,
views,
RANK() OVER(ORDER BY views DESC) AS ranking
FROM posts;

-- Dense Rank
SELECT
post_id,
views,
DENSE_RANK() OVER(ORDER BY views DESC) rank_no
FROM posts;

-- Running Total of Views
SELECT
post_id,
views,
SUM(views) OVER(ORDER BY post_date) running_total
FROM posts;

-- CTE Example
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

-- Creators Above Average Views
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

-- CASE Statement
SELECT
post_id,
views,
CASE
WHEN views>8000 THEN 'Viral'
WHEN views>5000 THEN 'Popular'
ELSE 'Normal'
END AS category
FROM posts;

-- Top Engagement Score
SELECT
p.post_id,
likes+comments+shares engagement
FROM posts p
JOIN engagement e
ON p.post_id=e.post_id
ORDER BY engagement DESC;

-- Average Likes Per Creator
SELECT
u.user_name,
AVG(likes) avg_likes
FROM users u
JOIN posts p
ON u.user_id=p.user_id
JOIN engagement e
ON p.post_id=e.post_id
GROUP BY u.user_name;

-- View Contribution %
SELECT
post_id,
views,
ROUND(
views*100/
(SELECT SUM(views) FROM posts),
2
) contribution
FROM posts;

-- Content Type Performance
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

-- Executive Dashboard Query
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
