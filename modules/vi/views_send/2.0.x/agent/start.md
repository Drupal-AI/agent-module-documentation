# Views Send — agent index

Mass-mail the rows of a View. Add the "Global: Send email" field (`views_send_bulk_form`) to a
View that has an email column, select rows, fill the message form, and send — directly (Batch
API) or spooled and delivered on cron.

- **Build a sending View, the message form, global settings, spool/cron behavior** →
  [configure/settings.md](configure/settings.md)
- **Permissions (send, attachments, admin)** → [permissions/permissions.md](permissions/permissions.md)
- **Events/services for Rules and custom code** → [api/events.md](api/events.md)

Key facts:
- Field plugin `views_send_bulk_form` (`Plugin/views/field/ViewsSend`, extends core `BulkForm`).
  Requires an email column in the View; optional recipient-name column.
- Send modes: immediate (Batch API) or queue to `views_send_spool`, flushed by
  `views_send_cron()` `throttle` rows/run.
- Config `views_send.settings` at `/admin/config/system/views_send` (route
  `views_send.configure`, perm `administer views_send`): `throttle`, `retry`, `spool_expire`,
  `debug`.
- Permissions: `administer views_send`, `mass mailing with views_send`,
  `attachments with views_send`.
- Optional: Mime Mail (HTML/attachments), Token (context tokens; row tokens work without it),
  Rules (`views_send.rules.events.yml`).
