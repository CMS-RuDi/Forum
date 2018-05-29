INSERT INTO `#__translations_fields` (`target`, `fields`) VALUES
('forum_forums', '---\ntitle: str\ndescription: str\npagetitle: str\nmeta_keys: str\nmeta_desc: str\n'),
('forum_forum_cats', '---\ntitle: str\npagetitle: str\nmeta_keys: str\nmeta_desc: str\n');

INSERT INTO `#__actions` (`component`, `name`, `title`, `message`, `is_tracked`, `is_visible`) VALUES
('forum', 'add_fpost', 'Adding forum post', 'added new %s| in forum thread %s', 1, 1),
('forum', 'add_thread', 'Adding forum topics', 'create forum thread %s| on forum %s', 1, 1);

INSERT INTO `#__components` (`title`, `link`, `config`, `internal`, `author`, `published`, `version`, `system`) VALUES
('Forum', 'forum', '---\nis_on: 1\nkarma: 1\nis_rss: 1\npp_thread: 15\npp_forum: 15\nshowimg: 1\nimg_on: 1\nimg_max: 5\nfast_on: 1\nfast_bb: 1\nfa_on: 1\ngroup_access: \nfa_max: 25\nfa_ext: txt doc zip rar arj png gif jpg jpeg bmp\nfa_size: 1024\n', 0, 'InstantCMS team', 1, '1.10.4', 1),

INSERT INTO `#__modules` (`position`, `name`, `title`, `is_external`, `content`, `ordering`, `showtitle`, `published`, `user`, `config`, `original`, `css_prefix`, `access_list`, `cache`, `cachetime`, `cacheint`, `template`, `is_strict_bind`, `version`) VALUES
('topmenu', 'Forum news', 'Forum news', 1, 'mod_forum', 31, 1, 1, 0, '---\nshownum: 2\nshowtype: web2\nshowforum: 0\nshowlink: 0\nshowtext: 0\nmenuid: 18\n', 1, '', '', 0, 1, 'HOUR', 'module.tpl', 0, '1.0');

INSERT INTO `#__plugins` (`id`, `plugin`, `title`, `description`, `author`, `version`, `plugin_type`, `published`, `config`) VALUES
(17, 'p_auto_forum', 'Autoforum', 'Creates a thread in the forum for the discussion of article', 'InstantCMS Team', '1.10.4', '', 1, '---\nAF_DELETE_THREAD: 1\nAF_LINK_TREAD: 1\nAF_ADDTREADFORUM_ID: 1\nAF_NOCREATETREAD: 0\n');

INSERT INTO `#__rating_targets` (`target`, `component`, `is_user_affect`, `user_weight`, `target_table`, `target_title`) VALUES
('forum_post', 'forum', 1, 2, 'cms_forum_posts', 'Post in the topic forum');

INSERT INTO `#__user_groups_access` (`access_type`, `access_name`, `hide_for_guest`) VALUES
('forum/moderate', 'Forum moderation', 1),
('forum/add_post', 'Reply forum topics', 1),
('forum/add_thread', 'Create new forum topics', 1);


DROP TABLE IF EXISTS `#__forums`;
CREATE TABLE `#__forums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` varchar(300) NOT NULL,
  `access_list` tinytext NOT NULL,
  `moder_list` tinytext DEFAULT NULL,
  `ordering` int(11) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` int(11) NOT NULL,
  `NSLeft` int(11) NOT NULL,
  `NSRight` int(11) NOT NULL,
  `NSDiffer` varchar(15) NOT NULL,
  `NSIgnore` int(11) NOT NULL,
  `NSLevel` int(11) NOT NULL,
  `icon` varchar(200) NOT NULL,
  `topic_cost` float NOT NULL DEFAULT '0',
  `thread_count` int(11) NOT NULL DEFAULT '0',
  `post_count` int(11) NOT NULL DEFAULT '0',
  `last_msg` text NOT NULL,
  `pagetitle` varchar(200) NOT NULL DEFAULT '',
  `meta_keys` varchar(250) NOT NULL DEFAULT '',
  `meta_desc` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `parent_id` (`parent_id`),
  KEY `NSLeft` (`NSLeft`,`NSRight`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `#__forums` (`id`, `category_id`, `title`, `description`, `access_list`, `ordering`, `published`, `parent_id`, `NSLeft`, `NSRight`, `NSDiffer`, `NSIgnore`, `NSLevel`, `icon`, `topic_cost`) VALUES
(1000, 0, '-- root forum --', '', '', 1, 0, 0, 1, 2, '', 0, 0, '', 0);

DROP TABLE IF EXISTS `#__forum_cats`;
CREATE TABLE `#__forum_cats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `ordering` int(11) NOT NULL,
  `seolink` varchar(200) NOT NULL,
  `pagetitle` varchar(200) NOT NULL DEFAULT '',
  `meta_keys` varchar(250) NOT NULL DEFAULT '',
  `meta_desc` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `seolink` (`seolink`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `#__forum_files`;
CREATE TABLE `#__forum_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `filename` varchar(200) NOT NULL,
  `filesize` int(11) NOT NULL,
  `hits` int(11) NOT NULL,
  `pubdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `#__forum_polls`;
CREATE TABLE `#__forum_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `answers` text NOT NULL,
  `options` varchar(250) NOT NULL,
  `enddate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_id` (`thread_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `#__forum_posts`;
CREATE TABLE `#__forum_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pinned` tinyint(1) NOT NULL DEFAULT '0',
  `pubdate` datetime NOT NULL,
  `editdate` datetime NOT NULL,
  `edittimes` int(11) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `attach_count` int(11) NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `content_html` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_id` (`thread_id`,`pubdate`),
  KEY `user_id` (`user_id`),
  FULLTEXT KEY `content_html` (`content_html`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `#__forum_threads`;
CREATE TABLE `#__forum_threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` varchar(250) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `pubdate` datetime NOT NULL,
  `hits` int(11) NOT NULL,
  `closed` tinyint(1) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `rel_to` varchar(15) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `post_count` int(11) NOT NULL DEFAULT '0',
  `last_msg` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `forum_id` (`forum_id`),
  KEY `rel_id` (`rel_id`),
  FULLTEXT KEY `title` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `#__forum_votes`;
CREATE TABLE `#__forum_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) NOT NULL,
  `answer` varchar(300) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pubdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `poll_id` (`poll_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;