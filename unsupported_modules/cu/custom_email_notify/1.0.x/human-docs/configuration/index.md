# Configuration

All of Media/Document Notifier's behaviour is set on one settings form.

## Open the settings form

1. Log in as a user who holds the **`administer media document notifier`**
   permission. This permission is marked *restrict access* because it controls who
   receives outbound mail and what it says — grant it only to trusted administrators.
2. Go to **Configuration → Media/Document Notifier settings**, or navigate directly
   to `/admin/config/custom-email-notify/settings`.

## The fields

- **Allowed file types** — a comma‑separated list of bare file extensions that
  trigger a notification, for example `pdf,docx`. Each entry must be a plain
  alphanumeric token (no dots, no spaces). When a file whose extension is on this
  list is uploaded, the notification fires. **Clearing this list turns notifications
  off** — nothing matches, so nothing is sent.
- **Email recipients** — a comma‑separated list of email addresses that receive the
  notification. Each address is validated when you save. If no recipients are set, the
  module logs a warning and sends nothing.
- **Email subject** — the subject line of the notification. It is required, and it may
  not contain carriage‑return or line‑feed characters — this is a deliberate guard
  against email‑header injection, so the form will reject a subject with line breaks.
- **Email message** — the body of the notification. You can include two placeholders,
  which are replaced when the mail is sent:
  - `[file_url]` — the absolute URL of the uploaded file.
  - `[current-username]` — the account name of the user who uploaded the file.

## Save

Click **Save configuration**. From then on, uploading a file whose extension matches
your allow‑list sends the notification — with the subject and body you defined, and
the placeholders filled in — to every address in the recipients list, through the
site's configured mail system.

## Good to know

- **Delivery depends on your mail setup.** The module hands the message to Drupal's
  mail manager; if the default transport doesn't deliver reliably, install and
  configure an SMTP module.
- **Keep the permission tight.** Because this form decides who gets mailed and what
  the message contains, treat `administer media document notifier` as a sensitive,
  admin‑only permission.
