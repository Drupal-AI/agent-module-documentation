# Configure & use Views Send

## Global settings

Form `/admin/config/system/views_send` (route `views_send.configure`, `SettingsForm`,
permission `administer views_send`). Config object **`views_send.settings`**:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `throttle` | int | 20 | messages sent per cron run (spool mode) |
| `retry` | int | 5 | retries before a spooled message is discarded |
| `spool_expire` | int | 0 | days to retain successfully sent spool rows (0 = delete immediately) |
| `debug` | bool | false | log every outgoing message to the system log |

## Build a sending View

1. Create a View with a **page or block** display over an entity that has email addresses.
2. Add a **field containing the recipient email** (and optionally a recipient-name field for the
   "To" display name).
3. Add the field **"Global: Send email"** (`views_send_bulk_form`) — it renders the row
   checkboxes and the "Send email" button. (Its `enable_excluded_fields` option, default on,
   lets excluded columns still be usable as row tokens.)
4. Optionally expose filters so operators can narrow the recipient list in the UI.
5. Save; load the display, (filter,) select rows, choose **Send email**.

## The message form

Collected per send (see `ViewsSend` / `views_send.module`): From name + From email
(`views_send_from_mail`, validated as a real email), Subject, Body, priority
(`views_send_priority`), receipt request, **Additional headers** (`views_send_headers`, one
`Key: Value` per line), and **carbon copy** to the sender (`views_send_carbon_copy`, default on).
Row values are available as tokens to personalize subject/body per recipient.

## Send vs. spool, and cron

- **Direct**: messages are sent right away via the Batch API.
- **Spool**: rows are inserted into the `views_send_spool` table. `views_send_cron()` calls
  `views_send_send_from_spool()` (sends up to `throttle` per run, honoring `retry`) then
  `views_send_clear_spool()` (removes sent rows older than `spool_expire`).

## Optional integrations

- **Mime Mail** — enables HTML body and attachments (attachments also require the
  `attachments with views_send` permission).
- **Token** — enables site/global context tokens in subject/body; per-row tokens work without
  it.
- **Rules** — `views_send.rules.events.yml` exposes send/spool events (see api/events.md).
