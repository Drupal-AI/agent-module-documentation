# Postmark — permissions

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer postmark` | `TRUE` | The Postmark settings form (`/admin/config/mail/postmark`): API token, Sender Signature, debug options, and sending test email. |

`restrict access: TRUE` marks it as security-sensitive (grant only to trusted admins) because it
exposes/edits the Postmark Server API token and can trigger outbound mail. Selecting the mail
plugin itself is done through Mail System's own admin form (`administer mailsystem`).
