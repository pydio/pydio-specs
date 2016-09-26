-- Table ajxp_users
SELECT 'CREATE TABLE ajxp_users' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_users (
    -- Columns
    login varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    groupPath varchar(255) NULL,

    -- Primary Key
    PRIMARY KEY  (login),

    -- Indexes
    INDEX(groupPath),

    -- Foreign Keys
    FOREIGN KEY (groupPath) REFERENCES ajxp_groups(groupPath)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_user_rights
SELECT 'CREATE TABLE ajxp_user_rights' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_user_rights (
    -- Columns
	rid INTEGER AUTO_INCREMENT,
	login VARCHAR(255) NOT NULL,
	repo_uuid VARCHAR(33) NOT NULL,
	rights MEDIUMTEXT NOT NULL,

    -- Primary Key
    PRIMARY KEY (rid),

    -- Indexes
    INDEX (login),
    INDEX (repo_uuid),

    -- Foreign Keys
    FOREIGN KEY (login) REFERENCES ajxp_user(login)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (repo_uuid) REFERENCES ajxp_repo(uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_user_prefs
SELECT 'CREATE TABLE ajxp_user_prefs' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_user_prefs (
    -- Columns
	rid INTEGER AUTO_INCREMENT,
	login VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	val BLOB,

    -- Primary Key
    PRIMARY KEY (rid),

    -- Indexes
    INDEX (login),
    INDEX (name),

    -- Foreign Key
    FOREIGN KEY (login) REFERENCES ajxp_users(login)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_user_bookmarks
SELECT 'CREATE TABLE ajxp_user_bookmarks' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_user_bookmarks (
    -- Columns
	rid INTEGER AUTO_INCREMENT,
	login VARCHAR(255) NOT NULL,
	repo_uuid VARCHAR(33) NOT NULL,
	path VARCHAR(255),
	title VARCHAR(255),

    -- Primary Key
    PRIMARY KEY (rid),

    -- Indexes
    INDEX (login),
    INDEX (repo_uuid),

    -- FOREIGN KEY
    FOREIGN KEY (login) REFERENCES ajxp_user(login)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (repo_uuid) REFERENCES ajxp_repo(uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_repo
SELECT 'CREATE TABLE ajxp_repo' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_repo (
    -- Columns
	uuid VARCHAR(33),
	parent_uuid VARCHAR(33) default NULL,
	owner_user_id VARCHAR(255) default NULL,
	child_user_id VARCHAR(255) default NULL,
	path VARCHAR(255),
	display VARCHAR(255),
	accessType VARCHAR(20),
	recycle VARCHAR(255),
	bcreate BOOLEAN,
	writeable BOOLEAN,
	enabled BOOLEAN,
	isTemplate BOOLEAN,
	inferOptionsFromParent BOOLEAN,
	slug VARCHAR(255),
	groupPath VARCHAR(255),

    -- Primary Key
    PRIMARY KEY (uuid),

    -- Indexes
    INDEX (parent_uuid),
    INDEX (owner_user_id),
    INDEX (child_user_id),
    INDEX (groupPath),
    INDEX (slug),

    -- Foreign Keys
    FOREIGN KEY (parent_uuid) REFERENCES ajxp_repo (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (owner_user_id) REFERENCES ajxp_users (login)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (child_user_id) REFERENCES ajxp_users (login)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (groupPath) REFERENCES ajxp_groups (groupPath)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_repo_options
SELECT 'CREATE TABLE ajxp_repo_options' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_repo_options (
    -- Columns
	oid INTEGER AUTO_INCREMENT,
	uuid VARCHAR(33) NOT NULL,
	name VARCHAR(50) NOT NULL,
	val BLOB,

    -- Primary Key
    PRIMARY KEY (oid),

    -- Indexes
	INDEX (uuid),
    INDEX (name),

    -- Foreign Keys
    FOREIGN KEY (uuid) REFERENCES ajxp_repo (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_roles
SELECT 'CREATE TABLE ajxp_roles' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_roles (
    -- Columns
	role_id VARCHAR(255),
	serial_role TEXT(500) NOT NULL,
    last_updated INT(11) NOT NULL DEFAULT 0,

    -- Primary Key
    PRIMARY KEY (role_id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_groups
SELECT 'CREATE TABLE ajxp_groups' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_groups (
    -- Columns
    groupPath VARCHAR(255),
    groupLabel VARCHAR(255) NOT NULL,

    -- Primary Key
    PRIMARY KEY (groupPath)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_plugin_configs
SELECT 'CREATE TABLE ajxp_plugin_configs' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_plugin_configs (
    -- Columns
    id VARCHAR(50) NOT NULL,
    configs LONGBLOB NOT NULL,

    PRIMARY KEY (id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_simple_store
SELECT 'CREATE TABLE ajxp_simple_store' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_simple_store (
    -- Columns
    object_id VARCHAR(255) NOT NULL,
    store_id VARCHAR(50) NOT NULL,
    serialized_data LONGTEXT NULL,
    binary_data LONGBLOB NULL,
    related_object_id VARCHAR(255) NULL,
    insertion_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Primary Key
    PRIMARY KEY(object_id, store_id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_user_teams
SELECT 'CREATE TABLE ajxp_user_teams' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_user_teams (
    -- Columns
    team_id VARCHAR(70) NOT NULL,
    user_id varchar(255) NOT NULL,
    team_label VARCHAR(255) NOT NULL,
    owner_id varchar(255) NOT NULL,

    -- Primary Key
    PRIMARY KEY(team_id, user_id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_version
SELECT 'CREATE TABLE ajxp_version' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_version (
    -- Columns
    db_build INT NOT NULL
);

INSERT INTO ajxp_version SET db_build=0;/* SEPARATOR */

-- Table ajxp_mail_queue
SELECT 'CREATE TABLE ajxp_mail_queue' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_mail_queue (
    -- Columns
    id int(11) NOT NULL AUTO_INCREMENT,
    recipient varchar(255) NOT NULL,
    url text NOT NULL,
    date_event int(11) NOT NULL,
    notification_object longblob NOT NULL,
    html int(1) NOT NULL

    -- Primary Key
    PRIMARY KEY (id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_mail_sent
SELECT 'CREATE TABLE ajxp_mail_sent' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_mail_sent (
    -- Columns
    id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    recipient varchar(255) NOT NULL,
    url text NOT NULL,
    date_event int(11) NOT NULL,
    notification_object longblob NOT NULL,
    html int(1) NOT NULL

    -- Primary Key
    PRIMARY KEY (id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Trigger mail_queue_go_to_sent
DROP TRIGGER IF EXISTS mail_queue_go_to_sent;
CREATE TRIGGER mail_queue_go_to_sent BEFORE DELETE ON ajxp_mail_queue
    FOR EACH ROW
        INSERT INTO ajxp_mail_sent (recipient,url,date_event,notification_object,html) VALUES (old.recipient,old.url,old.date_event,old.notification_object,old.html);

-- Table ajxp_tasks
SELECT 'CREATE TABLE ajxp_tasks' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_tasks (
    -- Columns
    uid VARCHAR(255) NOT NULL,
    type INTEGER NOT NULL,
    parent_uid VARCHAR(255) DEFAULT NULL,
    flags INTEGER NOT NULL,
    label VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    ws_id VARCHAR(32) NOT NULL,
    status INTEGER NOT NULL,
    status_msg VARCHAR(500) NOT NULL,
    progress INTEGER NOT NULL,
    schedule INTEGER NOT NULL,
    schedule_value VARCHAR(255) DEFAULT NULL,
    action VARCHAR(255) NOT NULL,
    parameters VARCHAR(500) NOT NULL,
    nodes VARCHAR(500) NOT NULL,
    creation_date INTEGER NOT NULL DEFAULT 0,
    status_update INTEGER NOT NULL DEFAULT 0,

    -- Primary Key
    PRIMARY KEY (uid),

    -- Index
    INDEX (parent_uid),
    INDEX (user_id),
    INDEX (ws_id),
    INDEX (status),
    INDEX (type),
    INDEX (schedule),
    INDEX (nodes),

    -- Foreign Keys
    FOREIGN KEY (uid) REFERENCES ajxp_tasks (uid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (user_id) REFERENCES ajxp_users (login)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (ws_id) REFERENCES ajxp_repo (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT

);

-- Table ajxp_feed
SELECT 'CREATE TABLE ajxp_feed' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_feed (
    -- Columns
    id int(11) NOT NULL AUTO_INCREMENT,
    edate int(11) NOT NULL,
    etype varchar(12) NOT NULL,
    htype varchar(32) NOT NULL,
    index_path mediumtext NULL,
    user_id varchar(255) NOT NULL,
    repository_id varchar(33) NOT NULL,
    user_group varchar(500),
    repository_scope varchar(50),
    repository_owner varchar(255),
    content longblob NOT NULL,

    -- Primary Key
    PRIMARY KEY (id),

    -- Indexes
    INDEX (edate,etype,htype,user_id,repository_id),
    INDEX (index_path(40)),
    INDEX (user_id),
    INDEX (repository_id),
    INDEX (user_group),

    -- Foreign Keys
    FOREIGN KEY (user_id) REFERENCES ajxp_users (login)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (repository_id) REFERENCES ajxp_repo (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    FOREIGN KEY (user_group) REFERENCES ajxp_groups (groupPath)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_log
SELECT 'CREATE TABLE ajxp_log' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_log (
    -- Columns
    id INT AUTO_INCREMENT,
	logdate DATETIME,
	remote_ip VARCHAR(45),
	severity ENUM('DEBUG', 'INFO', 'NOTICE', 'WARNING', 'ERROR'),
	user VARCHAR(255),
    source VARCHAR(255),
	message TEXT,
	params TEXT,
    repository_id VARCHAR(32),
    device VARCHAR(255),
    dirname VARCHAR(255),
    basename VARCHAR(255),

    -- Primary Key
    PRIMARY KEY (id),

    -- Indexes
    INDEX source (source),
    INDEX repository_id (repository_id),
    INDEX logdate (logdate),
    INDEX severity (severity),
    INDEX dirname (dirname),
    INDEX basename (basename),

    -- Foreign Key
    FOREIGN KEY (repository_id) REFERENCES ajxp_repo (uuid)
        ON UPDATE CASCADE ON DELETE RESTRICT

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_changes
SELECT 'CREATE TABLE ajxp_changes' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_changes (
    -- Columns
    seq int(20) NOT NULL AUTO_INCREMENT,
    repository_identifier TEXT NOT NULL,
    node_id bigint(20) NOT NULL,
    type enum('create','delete','path','content') NOT NULL,
    source text NOT NULL,
    target text NOT NULL,

    -- Primary Key
    PRIMARY KEY (seq),

    -- Indexes
    INDEX node_id (node_id, type)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Table ajxp_index
SELECT 'CREATE TABLE ajxp_index' AS ' ';
CREATE TABLE IF NOT EXISTS ajxp_index (
    -- Columns
    node_id int(20) NOT NULL AUTO_INCREMENT,
    node_path text NOT NULL,
    bytesize bigint(20) NOT NULL,
    md5 varchar(32) NOT NULL,
    mtime int(11) NOT NULL,
    repository_identifier text NOT NULL,

    -- Primary Key
    PRIMARY KEY (node_id)

    -- Indexes
    INDEX (md5),
    INDEX (repository_identifier),

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TRIGGER IF EXISTS LOG_DELETE;
CREATE TRIGGER LOG_DELETE AFTER DELETE ON ajxp_index
    FOR EACH ROW INSERT INTO ajxp_changes (repository_identifier, node_id,source,target,type)
        VALUES (old.repository_identifier, old.node_id, old.node_path, 'NULL', 'delete');

DROP TRIGGER IF EXISTS LOG_INSERT;
CREATE TRIGGER LOG_INSERT AFTER INSERT ON ajxp_index
    FOR EACH ROW INSERT INTO ajxp_changes (repository_identifier, node_id,source,target,type)
        VALUES (new.repository_identifier, new.node_id, 'NULL', new.node_path, 'create');

DROP TRIGGER IF EXISTS LOG_UPDATE;
CREATE TRIGGER LOG_UPDATE AFTER UPDATE ON ajxp_index
    FOR EACH ROW INSERT INTO ajxp_changes (repository_identifier, node_id,source,target,type)
        VALUES (new.repository_identifier, new.node_id, old.node_path, new.node_path, CASE old.node_path COLLATE utf8_bin = new.node_path COLLATE utf8_bin WHEN true THEN 'content' ELSE 'path' END);
