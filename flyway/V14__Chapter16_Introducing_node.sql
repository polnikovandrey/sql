# This user with legacy auth is needed for nodejs mysql lib to authenticate mysql >8.0 server. Modern authentication was not supported.
CREATE USER 'legacy_auth_user' IDENTIFIED WITH mysql_native_password BY 'legacy_auth_path';
CREATE DATABASE join_us;
GRANT ALL PRIVILEGES ON join_us.* TO 'legacy_auth_user'@'%';