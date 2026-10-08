# Notification flow, user manager & queues (API)

All send logic lives in `forum_notifications_subscription.module`. Machine names below are exact.

## Trigger hooks

- **`hook_entity_insert`** — fires on any entity; acts only when it is a `node` of bundle `forum`
  with a `taxonomy_forums` value pointing at a `forums` term. It fetches every subscriber of that
  forum (`getNotificationFrequencyByEntityAndType($forumTermId, 'taxonomy_term')`), then for each
  subscriber renders a subject/body and dispatches (see below). Finally it auto-subscribes the topic's
  author to the new topic via `createNotificationFrequencyForUser($node, $post_owner)`.
- **`hook_ENTITY_TYPE_insert` for `comment`** (`_comment_insert`) — when a comment is added to a
  `forum` node: if the topic has no subscribers yet it auto-subscribes the topic author, then fans out
  to every topic subscriber (`getNotificationFrequencyByEntityAndType($nodeId, 'node')`).
- **`hook_ENTITY_TYPE_delete` for `node`** (`_node_delete`) — for `forum` nodes, registers a
  shutdown function `_forum_notifications_subscription_delete_child_subscriptions()` →
  `deleteNotificationFrequencyByEntityAll($nid)` (removes all subscriptions to that topic).
- **`hook_entity_presave`** — when a `user` is saved **inactive** (blocked), calls
  `deleteNotificationFrequenciesByUser($uid)` to purge that user's subscriptions.

### Per-subscriber dispatch (inside the two insert hooks)

For each subscriber row the code skips the poster themselves, users with no email, and blocked users.
It sets the config-override language to the subscriber's `getPreferredLangcode()` (so translated
templates render in the recipient's language), then branches on `frequency->getFrequency()`:

- `Single Emails` → renders `post_subject`/`post_message` (topic) or
  `comment_subject`/`comment_message` (comment) with the token service. If config `cron` is TRUE it
  queues via `forum_notifications_subscription_email_queue()`; otherwise it sends inline via
  `forum_notifications_subscription_emailer('single_email_queue', …)`.
- `Daily Digest Emails` → renders `dd_subject`, `dd_header_message`, and `post_dd_message` /
  `comment_dd_message`, then calls `forum_notifications_subscription_dd_email_queue()` to append a
  line to that user's daily-digest queue item. `$data['date']` is formatted `l j F Y` for `fr`, else
  `l, F j, Y`.

Templates are rendered with `forum_notifications_subscription.token`
(`Token::replacePlain`) using the `fns_topic` / `fns_comment` / `fns_dd` tokens — see
[tokens.md](tokens.md).

## User-profile subscription manager

`hook_form_user_form_alter` injects two fieldsets into the account edit form (`user_form`):
`forum_subscriptions` (a `forum_table`) and `topic_subscriptions` (a `topic_table`). Rows come from
`getUserNotificationEntities('Forum', $uid)` and `getUserNotificationEntities('Forum topic', $uid)`;
each row exposes a frequency `select` (`Daily Digest Emails` / `Single Emails`). The added submit
handler `forum_notifications_subscription_user_form_submit()` walks the submitted tables, loads each
row by id (`getNotificationById()`) and, when the value changed, `setFrequency()` + `save()`. This is
the primary way users change (but not remove) their frequencies. It runs under core's user-form access
(a user editing their own account, or an admin with `administer users`).

## Email queue helpers & `hook_mail`

- `forum_notifications_subscription_email_queue($to, $subject, $message, $langcode)` — pushes an item
  to core queue `single_email_queue`.
- `forum_notifications_subscription_dd_email_queue($to, $subject, $header, $message, $user_id, $langcode, $type)`
  — for the digest. Calls `forum_notifications_subscription_user_dd_notif_exist()` first: that helper
  runs a raw `SELECT item_id, data FROM {queue} WHERE name = 'daily_digest_email_queue'`, unserializes
  each item, and if the user already has a queued digest it appends the message to
  `message_<type>` (`message_forum` / `message_topic`) and re-serializes — so a user gets **one**
  digest item per day that accumulates the day's lines. Otherwise it creates a new item stamped with
  the user's timezone `created` time.
- `forum_notifications_subscription_emailer($key, $to, $subject, $message, $langcode)` — inline send
  via `plugin.manager.mail`.
- `hook_mail` — for any key, sets `from` = `system.site:mail`, `subject` = `$params['title']`, and
  appends `$params['message']` to the body.

## Queue workers (cron)

- `SingleEmailQueue` — plugin id `single_email_queue`, `cron = {"time" = 90}`. `processItem()` mails
  the stored `to/title/message/langcode` via `plugin.manager.mail`.
- `DailyDigestEmailQueue` — plugin id `daily_digest_email_queue`, `cron = {"time" = 100}`.
  `processItem()` only sends once it is a **new calendar day in the recipient's timezone**
  (`userMidnight()`); until then it re-queues via `DelayedRequeueException`. It builds the body from
  `header` + a `New post notifications` block (`message_forum`) + a `New comment notifications` block
  (`message_topic`); `buildNotificationTypeBlock()` joins the accumulated lines with `<br/>` bullet
  markup.
