<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bcc — configuration

## Where

- UI: `/admin/config/system/bcc-settings` (route `bcc.settings`, title "Blind Carbon Copy
  Settings"). Menu link `system.bcc_settings` under *Configuration › System*, weight 20.
- Permission required: `administer bcc settings` (defined `restrict access: true`).
- Form class: `Drupal\bcc\Form\BccSettingsForm` (`ConfigFormBase`, `@internal`).

## Config object `bcc.settings`

| Key        | Type    | Default | Meaning |
|------------|---------|---------|---------|
| `enable`   | boolean | `false` | Master switch. When TRUE, `bcc_mail_alter()` adds the Bcc header to every outgoing message. |
| `bcc_mail` | email   | `''`    | The single address that receives a blind copy of all site mail. On the form it is required and shown only when `enable` is checked (`#states`), max length 180. |

Schema: `config/schema/bcc.schema.yml` (`bcc.settings` as a `config_object`; `bcc_mail`
typed `email`). Install default: `config/install/bcc.settings.yml` (`enable: false`,
`bcc_mail: ''`) — the module ships **off** and must be explicitly enabled.

## Drush / programmatic

No Drush commands, no service, no API. Read or set via core config:

```bash
drush cget bcc.settings
drush cset bcc.settings enable 1 -y
drush cset bcc.settings bcc_mail archive@example.com -y
```

## Behaviour notes

- Single global address only — there is no per-mail-key targeting and no way to exclude
  specific mail keys (e.g. password reset, one-time login are all copied).
- The Bcc value is appended space-joined onto any pre-existing `Bcc` header on the message.
- The address is trusted admin config validated as an email; it is not built from tokens or
  user-supplied data, so there is no header-injection surface here.
