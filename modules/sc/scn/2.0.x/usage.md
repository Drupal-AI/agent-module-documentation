Simple Comment Notify (SCN) emails or sends a Telegram message to chosen recipients whenever a new comment is created, so admins/moderators learn about comments without polling the moderation queue.

---

SCN implements `hook_entity_insert()` for the `comment` entity: on every new comment it builds a notification
body (the comment permalink, optionally plus links to the comment-approval overview and the comment edit
page) and dispatches it to whichever recipients are enabled in `scn.settings`. Recipient options are: the
uid=1 admin, the commented node's author, all active users holding selected roles, and an arbitrary
comma-separated "custom mail list" of addresses. Email goes through Drupal's mail manager (`hook_mail` key
`new_comment`, from/subject taken from `system.site`). Telegram delivery uses cURL against
`api.telegram.org/bot<token>/sendMessage` with a configured bot token and comma-separated chat IDs, and can
optionally route through a SOCKS5 proxy (server, login, password). The single settings form
(`/admin/config/system/scn`, route `scn.settings`, gated by the module's own `administer scn configuration`
permission) toggles all of the above. Depends only on core Comment. Note the module has no `config/schema`,
so its settings are schema-less; the "custom mail list" is not validated per-address before the mail
manager checks each recipient.

---

- Email the site admin (uid 1) whenever any new comment is posted.
- Notify the author of the node that received the comment.
- Notify every active user who holds a chosen role (e.g. "moderator").
- Send notifications to arbitrary external addresses via a comma-separated custom mail list.
- Push new-comment alerts to a Telegram chat or channel via a bot.
- Broadcast to multiple Telegram chat IDs at once (comma-separated).
- Route Telegram delivery through a SOCKS5 proxy where the API is blocked.
- Include a direct link to the comment-approval/overview page in each notification.
- Include a direct link to the comment edit page (with a destination back to approval).
- Speed up comment moderation by alerting moderators in real time.
- Combine email and Telegram delivery simultaneously.
- Restrict who can change notification settings via the `administer scn configuration` permission.
- Notify a mailing list of stakeholders about community activity on a node.
- Alert a content owner when readers comment on their article.
- Keep a low-traffic site's admin informed without enabling full comment moderation workflows.
- Use the site's configured mail address/name as the notification sender and subject.
- Send different teams (roles) notifications depending on which roles are selected.
- Get mobile push-style alerts through Telegram instead of email.
- Add a lightweight comment alerting layer on top of core Comment without extra dependencies.
