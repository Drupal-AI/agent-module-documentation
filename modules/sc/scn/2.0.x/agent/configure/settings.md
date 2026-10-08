# SCN — configuration

Config object `scn.settings`, edited at `/admin/config/system/scn` (route `scn.settings`, form
`SCNSettingsForm`, permission `administer scn configuration`). No config schema ships, so keys are stored
untyped.

## Settings keys

| Key | Type | Purpose |
|---|---|---|
| `scn_admin` | bool | Email the uid=1 user. |
| `scn_node_author` | bool | Email the commented node's author. |
| `scn_roles` | array | Roles whose active members get emailed (checkboxes; option labels are `Html::escape`d). |
| `scn_maillist` | string | Comma-separated extra addresses (non-registered recipients). |
| `scn_telegram` | bool | Enable Telegram delivery. |
| `scn_telegram_bottoken` | string | Telegram bot token. |
| `scn_telegram_chatids` | string | Comma-separated chat IDs. |
| `scn_telegram_proxy` | bool | Route Telegram through a SOCKS5 proxy. |
| `scn_telegram_proxy_server` | string | Proxy host:port (e.g. `127.0.0.1:1234`). |
| `scn_telegram_proxy_login` | string | Proxy username. |
| `scn_telegram_proxy_password` | string | Proxy password. |
| `scn_add_admin_overview_link` | bool | Append a link to `/admin/content/comment/approval` in the body. |
| `scn_add_admin_comment_link` | bool | Append a link to the comment edit page (destination = approval). |

## How notifications fire (`scn_entity_insert`, in `scn.module`)

On insert of a `comment` entity:
1. Body starts from `$comment->permalink()` (absolute). If the two admin-link toggles are on, appends the
   approval-overview and comment-edit URLs.
2. Subject = comment subject; mail from/subject name come from `system.site` (`scn_mail`, key `new_comment`).
3. Recipients, each guarded by its toggle: uid 1 (`scn_admin`); users in `scn_roles` (active users queried
   with `accessCheck(false)`); each address in `scn_maillist`; node author (`scn_node_author`).
   `_scn_send_mail()` validates each address with `email.validator` before sending.
4. If `scn_telegram`: for each chat ID, `_scn_send_telegram()` issues a cURL POST to
   `https://api.telegram.org/bot<token>/sendMessage?...&text=<urlencoded>`, optionally via SOCKS5 proxy
   (`CURLPROXY_SOCKS5_HOSTNAME`, with `login:password` if a login is set).

## Notes
- The bot token, chat IDs, and proxy credentials are stored in `scn.settings` config (admin-entered). To keep
  them out of exported config, override in `settings.php` via `$config['scn.settings'][...]`.
- No config schema means Configuration Inspector/typed-config validation is unavailable for these keys.
