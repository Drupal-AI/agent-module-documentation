<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

`src/Form/DropWatchSettingsForm.php` — a `ConfigFormBase`, form id **`dropwatch_settings`**,
route `dropwatch.settings` at **`/admin/config/system/dropwatch/settings`**
(permission `administer dropwatch`). Editable config: **`dropwatch.settings`**. Injects
`dropwatch.service` (used only to decide whether to show the PHP-logs checkbox).

## Config keys written by `submitForm()`

Stored in `dropwatch.settings`:

- `site_url` (string) — must match the site URL registered in the DropWatch app; sent as the payload
  identifier.
- `core`, `php`, `web_server`, `database`, `contrib_modules`, `contrib_themes`, `php_logs` — booleans
  toggling each payload section (see [../api/service.md](../api/service.md)).

There is **no `config/install` default** and **no `config/schema`** shipped with the module, so keys
are unset until the form is first saved.

Caveat: `submitForm()` unconditionally writes `$values['php_logs']`, but the `php_logs` checkbox is
only added to the form when `checkIfDblogIsEnabled()` is true — so on a site without `dblog` the
submitted values lack that key.

## The API token (important — not a form field)

The form does **not** collect or store the API token. It renders static markup instructing the
operator to add the token to `settings.php`:

```php
$settings['dropwatch_api_token'] = '<YOUR_DROPWATCH_SITE_API_TOKEN>';
```

At request time `DropWatchApiClient::sendUpdate()` reads it via
`Settings::get('dropwatch_api_token', '')`. The module ships **no** Key-entity integration and does
**not** call `getenv()`; the token lives wherever `settings.php` assigns it (an operator may of course
populate that line from an environment variable themselves).

## Other UI

Static fieldsets render a declaration ("No sensitive information about this site is ever sent…"),
a cron-frequency note suggesting Ultimate Cron for more granular scheduling, and the token
instructions. The tracking checkboxes carry descriptions of what each category sends.
