<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & operation

## Config page

- Route `symfony_mailer_office365.config` → `/admin/config/system/mailer/office365`.
- Permission: **`administer mailer`** (from `symfony_mailer`). Also surfaced as a local task under
  the Mailer policy collection (`symfony_mailer_office365.links.task.yml`).
- Form ID `symfony_mailer_office365_config`; `ConfigFormBase` editing config object
  `symfony_mailer_office365.config`.

Fields (all stored in `symfony_mailer_office365.config`):

| Field | Key | Notes |
|---|---|---|
| Client ID (a.k.a. Application ID) | `client_id` | required, textfield |
| Client Secret (a.k.a. Secret Value) | `client_secret` | `password` field; leave blank to keep the current value; masked with `****…` placeholder when set |
| Tenant ID | `tenant_id` | required; used in the `login.microsoftonline.com/{tenant_id}/…` URLs (falls back to `common` if empty) |
| E-Mail | `mail` | required; the sending mailbox / XOAUTH2 `user=` and `login_hint` |

The page also shows the **Redirect URL** to register in Entra, a **Login via Microsoft** link when
no token is stored, and the **token expiry date** when one is.

> Saving the form **clears the stored OAuth token** (`TokenStateManager::clear()`), so a re-login is
> required afterward. The form itself warns about this.

## settings.local.php override

Client credentials can be overridden per-environment (recommended for keeping secrets out of
exported config):

```php
$config['symfony_mailer_office365.config']['client_id'] = 'client_id';
$config['symfony_mailer_office365.config']['client_secret'] = 'client_secret';
$config['symfony_mailer_office365.config']['tenant_id'] = 'tenant_id';
$config['symfony_mailer_office365.config']['mail'] = 'mail@example.org';
```

There is **no Key-module integration**; the secret otherwise lives in active/exported config.

## Attaching the transport

After credentials are set and login is complete, edit a **Symfony Mailer mailing policy** and choose
the **Office 365 - OAuth** transport (`office365_oauth`). The transport plugin's own config form only
links back to `/admin/config/system/mailer/office365`; the real credentials come from the shared
config object, not per-policy.

## Keeping the token alive

The access token is short-lived (~1 hour) and renewed with the stored refresh token.

- **Cron:** `hook_cron` calls `refresh(TRUE)` (forced) on every run. Ensure cron runs at least every
  12 hours so the refresh token does not lapse.
- **Drush:** `drush symfony_mailer_office365:refresh` (alias `drush office365:refresh`). Options:
  `--force` refresh even if not expired. Schedule it if you do not want to rely on cron.

If a refresh fails, the manager logs the error (channel `symfony_mailer_office365`) and **clears** the
token — the next send will fail until an admin logs in again.

## Troubleshooting

- Check the expiry shown on the config page; "Not functional. Login is needed" means no token.
- Check `dblog`/watchdog for channel `symfony_mailer_office365` — refresh/fetch/send errors are logged
  there (including Microsoft's `error_description`).
- A dead-on-a-date failure usually means the **Azure client secret expired** — rotate it in Entra,
  update the secret, save, and log in again.
