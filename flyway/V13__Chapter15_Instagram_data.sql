USE instagram;

# 5 oldest users
SELECT id, username, created_at FROM users ORDER BY created_at LIMIT 5;
# Days of week rating by number of registered users (most popular day for user registration).
SELECT DAYNAME(created_at) AS Dayname, COUNT(*) AS Count FROM users GROUP BY Dayname ORDER BY Count DESC;
# Select all inactive users (without photos).
SELECT username FROM users LEFT JOIN photos p ON users.id = p.user_id WHERE p.user_id IS NULL;
# Select single user, whose photo is most liked.
SELECT image_url, username, COUNT(photo_id) as count
FROM photos
        JOIN users u ON photos.user_id = u.id
        JOIN likes l ON photos.id = l.photo_id
GROUP BY photo_id
ORDER BY count DESC
LIMIT 1;
# Count comments per user.
SELECT username, COUNT(c.id) AS 'comments per user' FROM users LEFT JOIN comments c ON users.id = c.user_id GROUP BY users.id;
# How many times average user posts.
SELECT COUNT(comments.id)/(SELECT COUNT(users.id) FROM users) AS 'Avg posts per user' FROM comments;
# The same as previous.
SELECT (SELECT COUNT(*) FROM comments) / (SELECT COUNT(*) FROM users) AS 'Avg posts per user';
# 5 most commonly used hash tags.
SELECT tags.id AS id, tag_name AS tag, COUNT(*) AS count
FROM tags
    JOIN photos_hash_tags ON tags.id = photos_hash_tags.tag_id
GROUP BY tag_id
ORDER BY count DESC
LIMIT 5;
# Users (bots), who liked every single photo.
# Note HAVING is used to match aggregated value to some value (subquery in this particular case).
# It's not possible to use aggregate functions inside WHERE clause, one must use HAVING instead.
SELECT id, username, COUNT(photo_id) AS likes FROM users JOIN likes ON users.id = likes.user_id GROUP BY user_id HAVING likes = (SELECT COUNT(*) FROM photos);

DROP TABLE users, photos, comments, likes, tags, photos_hash_tags, follows;
DROP DATABASE instagram;