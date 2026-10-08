<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Matomo Reports — connection settings

Settings form `MatomoReportsSettings` (route `matomo_reports.matomo_reports_settings` →
`/admin/config/system/matomo-reports`, permission **`administer matomo reports`**). All values
persist in the **`matomo_reports.matomoreportssettings`** config object (no config schema is
shipped, so `drush cset` needs `--input-format` for booleans, or use the config API).

## Config keys

```yaml
# matomo_reports.matomoreportssettings
matomo_server_url: 'https://analytics.example.com/matomo/'   # base dir, trailing slash added on save
matomo_reports_token_auth: ''         # global token_auth; blank = each user sets their own
matomo_reports_allowed_sites: ''      # e.g. '1,4,12'; blank = all sites the token can view
matomo_server_url_ignore_ssl: false   # true = skip SSL verify (dev/self-signed only)
```

- **`matomo_server_url`** — the Matomo base directory. On form save the module pings
  `<url>/piwik.php` to validate reachability and appends a trailing `/`. If left blank,
  `MatomoData::getUrl()` falls back to the `matomo` module's `matomo.settings` (`url_https`
  then `url_http`) when that module is installed.
- **`matomo_reports_token_auth`** — a **global** Matomo `token_auth`. If set, every user with
  `access matomo reports` sees reports through it. Set to the literal `anonymous` for a public
  Matomo site. Leave blank to force **per-user** tokens (see below).
- **`matomo_reports_allowed_sites`** — comma-separated Matomo site IDs the reports UI is
  restricted to. Blank = all sites the token has view access to.
- **`matomo_server_url_ignore_ssl`** — when true, Guzzle calls disable
  `CURLOPT_SSL_VERIFYHOST`/`VERIFYPEER` (testing only).

### Scriptable

```php
\Drupal::configFactory()->getEditable('matomo_reports.matomoreportssettings')
  ->set('matomo_server_url', 'https://analytics.example.com/matomo/')
  ->set('matomo_reports_token_auth', 'anonymous')
  ->set('matomo_reports_allowed_sites', '1,4')
  ->set('matomo_server_url_ignore_ssl', FALSE)
  ->save();
```

Read back: `drush cget matomo_reports.matomoreportssettings`.

> Note: the form's `submitForm()` also writes a few legacy/no-op keys
> (`matomo_report_server`, `token_auth`, `matomo_reports_sites`) that nothing reads — the four
> keys above are the effective ones.

## Per-user token_auth

When `matomo_reports_token_auth` is **empty**, `matomo_reports_form_user_form_alter()` adds a
"Matomo authentication string" field to each user's edit form (for users with `access matomo
reports`). It is stored with the **`user.data`** service:

```php
\Drupal::service('user.data')->get('matomo_reports', $uid, 'matomo_reports_token_auth');
\Drupal::service('user.data')->set('matomo_reports', $uid, 'matomo_reports_token_auth', $token);
```

`MatomoData::getToken()` returns the global token if present, otherwise the current user's
per-user token.

## Permissions (`matomo_reports.permissions.yml`)

- **`access matomo reports`** — view the reports UI and the block.
- **`administer matomo reports`** — access this settings form.
