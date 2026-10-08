# Configure Brevo Mailer

## Settings form

Route `brevo_mailer.admin_settings_form` → `/admin/config/services/brevo/mailer/settings`, permission
**`administer brevo`**. Form `BrevoMailerAdminSettingsForm`. On build it runs
`validateDrupalMailerLibrary()` + `validateDrupalMailerConfiguration()` which warn if neither Mail System nor
Symfony Mailer is installed, if Symfony Mailer's `symfony/brevo-mailer` / `symfony/http-client` deps are
missing, or if Brevo is not the active plugin/transport.

A second route `brevo_mailer.test_email_form` (`/…/mailer/settings/test`, same permission) sends a test
email.

## Config object `brevo_mailer.settings`

Schema `brevo_mailer.schema.yml`; defaults in `config/install`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `debug_mode` | bool | `false` | Log every send/queue (`logger.channel.brevo_mailer`). |
| `test_mode` | bool | `false` | Brevo **sandbox**: adds header `X-Sib-Sandbox: drop` — message accepted but not delivered. |
| `format_filter` | string | `plain_text` | Text-format machine name to run **non-HTML** bodies through (`check_markup`); `''` = none. Recommended: `filter_autop`. |
| `use_theme` | bool | `false` | Wrap the body via a theme hook (default `brevo`, or `$message['params']['theme']`). |
| `use_queue` | bool | `false` | (Shown only with Mail System) queue messages and send on cron instead of immediately. |

## Wiring it up (choose one delivery path)

### Mail System
Install `drupal/mailsystem`, then set Brevo as the default (or module/key-specific) mail plugin at
`admin/config/system/mailsystem`:
- `brevo_mail` — send immediately.
- `brevo_queue_mail` — always queue (per-key queueing without the global `use_queue`).

### Symfony Mailer
Install `drupal/symfony_mailer` (+ `symfony/brevo-mailer`, `symfony/http-client`). On install the module
**auto-creates** a `brevo` `MailerTransport` with DSN `brevo+api://<api_key>@default` and sets it as default
(`brevo_mailer_modules_installed`). The DSN is kept in sync with the Brevo API key by
`BrevoMailerSubscriber` (subscribes to `ConfigEvents::SAVE` on `brevo.settings`), and the DSN field is
disabled in the transport edit form (`brevo_mailer_form_mailer_transport_edit_form_alter`) — change the key
on the Brevo settings page instead.

## Config migration note

`brevo_update_8001` moved `debug_mode` / `test_mode` / `format_filter` / `use_queue` / `use_theme` from the
old `brevo.settings` into `brevo_mailer.settings` and installs this submodule automatically on update.
