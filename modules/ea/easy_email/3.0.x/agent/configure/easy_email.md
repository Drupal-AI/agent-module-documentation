# Configure Easy Email — templates & settings

## Requirement
Needs a real HTML mailer module enabled: **Symfony Mailer Lite** or **Symfony Mailer**
(only one). Without it, HTML emails won't be delivered properly.

## Email templates — `easy_email_type` config entity
Managed at **Admin → Structure → Email templates** (`/admin/structure/email-templates/templates`,
route `entity.easy_email_type.collection` — this is the module's `configure` route).

| Route | Path | Purpose |
|---|---|---|
| `entity.easy_email_type.collection` | `/admin/structure/email-templates/templates` | List templates |
| `entity.easy_email_type.add_form` | `.../templates/add` | Create a template |
| `entity.easy_email_type.edit_form` | `.../templates/{id}/edit` | Edit |
| `entity.easy_email_type.preview` | `.../templates/{id}/preview` | Preview (fill token values → render) |
| `easy_email.settings` | `/admin/structure/email-templates/settings` | Global settings |
| `entity.easy_email.collection` | `/admin/reports/email` | Email log (sent emails) |

A template (config, prefix `easy_email.easy_email_type.*`) is the bundle for `easy_email`
content entities. Exported keys:

- `id`, `label`, `key` — machine id, label, and a **unique key** used for de-duplication.
- `recipient`, `cc`, `bcc` — sequences of To/CC/BCC values (token-aware, e.g. `[easy_email:...]`).
- `fromName`, `fromAddress`, `replyToAddress` — sender identity.
- `subject`, `inboxPreview` — subject line and optional hidden inbox-preview snippet.
- `bodyHtml` (text_format), `bodyPlain`, `generateBodyPlain` (bool — derive plain text from HTML).
- `attachment` (sequence — token or relative path), `saveAttachment`, `attachmentScheme`,
  `attachmentDirectory` — dynamic attachments and where saved copies live.
- `saveEmail`, `allowSavingEmail` — whether sent emails are logged.
- `purgeEmails`, `purgeInterval`, `purgePeriod` — per-template log purging.

**All fields support token replacement** (module depends on `token`). Templates are **fieldable**
— add fields (e.g. an entity reference to an order/user) via Field UI on the template, then use
tokens derived from them. Config-deployable with `drush config:export`.

## Global settings — `easy_email.settings`
Edit at `/admin/structure/email-templates/settings` or `drush cset easy_email.settings <key>`.
Defaults (`config/install/easy_email.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `purge_on_cron` | `true` | Purge old logged emails on cron |
| `purge_cron_limit` | `50` | Max emails purged per cron run |
| `allowed_attachment_paths` | `['public://*']` | Path patterns attachments may be read from |
| `email_collection_access` | `true` | Gate access to the email log collection |
| `allowed_attachment_extensions` | `[]` | Whitelist (empty = all except blocked) |
| `blocked_attachment_extensions` | `[exe, bat, php, js, sh, …]` | Blocked file extensions |
| `allowed_attachment_mime_types` | `[]` | MIME whitelist |
| `blocked_attachment_mime_types` | `[application/x-php, text/javascript, …]` | Blocked MIME types |
| `max_attachment_size` | `10.0` | Max attachment size (MB) |

Also `easy_email.theme_settings` route (`.../theme`) for the email render theme.

## Drush — log purge
`drush.services.yml` registers `PurgeCommands` (backed by `easy_email.purger`) to purge old
logged emails; cron also purges when `purge_on_cron` is true.
