ALTER TABLE comments ADD INDEX post_id_idx (post_id, created_at DESC);
ALTER TABLE posts ADD INDEX post_order_idx (created_at DESC);
ALTER TABLE comments ADD INDEX user_id_indx (user_id);
ALTER TABLE posts ADD INDEX post_user_order_idx (user_id, created_at DESC);
