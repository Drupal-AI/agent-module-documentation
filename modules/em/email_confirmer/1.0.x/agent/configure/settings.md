# Email confirmer — settings

Route `email_confirmer.settings` → `/admin/config/system/email-confirmer`
(permission `administer site configuration`). Config object `email_confirmer.settings`
(schema `config/schema/email_confirmer.schema.yml`, defaults in
`config/install/email_confirmer.settings.yml`).

| Key | Default | Meaning |
|---|---|---|
| `hash_expiration` | `86400` (24h) | Seconds a confirmation link/hash stays valid ("response time limit"). |
| `confirmation_lifetime` | `604800` (7d) | Max lifetime of a confirmation entity before cron deletes it; set 0 to keep forever. |
| `resendrequest_delay` | `900` (15m) | Minimum delay before a request email can be resent (else queued). |
| `restrict_same_ip` | `false` | If true, only the IP that requested the confirmation may respond. |
| `confirmation_request.subject` | see install | Tokenized subject of the request email. |
| `confirmation_request.body` | see install | Tokenized body; use `[email-confirmer:confirmation-url]`. |
| `confirmation_response.skip_confirmation_form` | `false` | If true, hitting the link auto-confirms (no form shown). |
| `confirmation_response.questions.{pending,expired,cancelled,confirmed}` | see install | Text shown on the response form per status. |
| `confirmation_response.url.{confirm,cancel,error}` | `<front>` | Fallback redirect targets (a confirmation's own `setResponseUrl()` wins). |

Settings form: `src/Form/EmailConfirmerSettingsForm.php` (exposes hours/minutes selects that it
converts to seconds).

## Cron cleanup
Confirmations older than `confirmation_lifetime` are removed on cron (`email_confirmer.module` /
`.install`). An optional `ultimate_cron` job ships at
`config/optional/ultimate_cron.job.email_confirmer_cron.yml`.

Drush:
```
drush cget email_confirmer.settings
drush cset email_confirmer.settings restrict_same_ip true
```
