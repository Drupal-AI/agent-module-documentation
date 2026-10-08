# Permissions

| Permission | Gates |
|---|---|
| `administer views_send` | The global settings form (`/admin/config/system/views_send`): throttle, retry, spool_expire, debug. |
| `mass mailing with views_send` | Actually selecting rows and **sending** email from a View. This is the "can send bulk mail" permission. |
| `attachments with views_send` | Attaching files to messages (requires Mime Mail for attachments to take effect). |

None are marked `restrict access`, but **`mass mailing with views_send` is effectively a
trusted, high-impact permission** — it lets the holder send arbitrary bulk email to any
addresses a View can surface. Grant it only to trusted roles.
