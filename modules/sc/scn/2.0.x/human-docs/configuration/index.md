# Configuration

All of SCN's behavior is controlled from one form.

## Open the settings form

1. Log in as a user with the **Administer SCN configuration** permission (an
   administrator has it by default).
2. Go to **Configuration → System → Simple Comment Notify**, or navigate directly
   to `/admin/config/system/scn`.

Tick the options you want and click **Save configuration**. Notifications start
firing on the next new comment.

## Who gets notified

These options decide the recipients of the **email** notifications. You can turn
on any combination.

- **Notify the site admin (user 1)** (`scn_admin`) — emails the main
  administrator account, the user with ID 1.
- **Notify the node author** (`scn_node_author`) — emails the author of the
  content the comment was posted on. Good for "someone commented on your
  article" alerts.
- **Notify users by role** (`scn_roles`) — a set of checkboxes, one per role.
  Every **active** user who holds a selected role is emailed. Use this to alert,
  say, everyone in a "Moderator" role.
- **Custom mail list** (`scn_maillist`) — a free‑text field for extra addresses
  that are not site users. Enter them **comma‑separated**
  (`alice@example.com, bob@example.com`). Each address is validated before
  sending, so an invalid one is simply skipped.

## Extra links in the notification

Both are optional and make moderation quicker:

- **Add comment‑approval overview link** (`scn_add_admin_overview_link`) —
  appends a link to the comment approval/overview page
  (`/admin/content/comment/approval`) to the message body.
- **Add comment edit link** (`scn_add_admin_comment_link`) — appends a link to
  the comment's edit page (with a destination back to the approval page) so a
  moderator can jump straight in.

Every notification already includes a permalink to the new comment itself.

## Telegram delivery

SCN can post each new‑comment alert to Telegram in addition to (or instead of)
email.

- **Enable Telegram** (`scn_telegram`) — the master switch for Telegram
  delivery. Leave the fields below blank if this is off.
- **Bot token** (`scn_telegram_bottoken`) — the token for your Telegram bot,
  obtained from Telegram's *BotFather*. This authorizes SCN to send messages as
  that bot.
- **Chat IDs** (`scn_telegram_chatids`) — the chats or channels to post to,
  entered **comma‑separated**. Each ID receives its own message, so you can
  broadcast to several chats at once.

## SOCKS5 proxy (optional)

Only needed if your server cannot reach `api.telegram.org` directly (for example
where Telegram is network‑blocked). SCN can tunnel the Telegram request through a
SOCKS5 proxy.

- **Use proxy** (`scn_telegram_proxy`) — turns proxying on for Telegram
  delivery.
- **Proxy server** (`scn_telegram_proxy_server`) — the proxy host and port, for
  example `127.0.0.1:1234`.
- **Proxy login** (`scn_telegram_proxy_login`) — the proxy username, if your
  proxy requires authentication.
- **Proxy password** (`scn_telegram_proxy_password`) — the matching password.

## A note on the sender and on secrets

Notification emails use your site's configured email address and name (set at
**Configuration → System → Basic site settings**) as the "from" and subject.

The Telegram bot token, chat IDs, and proxy credentials are stored in this
module's configuration. If you export configuration to code and don't want these
secrets committed, override them in `settings.php` instead, for example:

```php
$config['scn.settings']['scn_telegram_bottoken'] = getenv('SCN_TELEGRAM_BOTTOKEN');
```

This module ships without a config schema, so tools like the Configuration
Inspector cannot validate these keys — this is expected and does not affect the
module working.
