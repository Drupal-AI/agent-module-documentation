<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWX settings (`awx.settings` config object + admin form)

## Route & access

- Route **`awx.settings`** → `/admin/config/services/awx`, form
  `Drupal\awx\Form\AwxSettingsForm` (`src/Form/AwxSettingsForm.php`), title *"AWX / Ansible Tower"*
  (`awx.routing.yml`). Requirement: `_permission: 'administer site configuration'` — the module
  defines no permission of its own.
- Menu link `awx.settings` under *Configuration → Web services* (`system.admin_config_services`)
  in `awx.links.menu.yml`.

## Config object `awx.settings`

Install defaults (`config/install/awx.settings.yml`), typed by `config/schema/awx.schema.yml`
(`type: config_object`, label *"AWX settings"*):

| Key                | Type    | Default | Meaning                                                        |
|--------------------|---------|---------|----------------------------------------------------------------|
| `url`              | string  | `''`    | AWX base URL, e.g. `https://awx.example.com`. Trailing `/` is stripped on save. |
| `auth_token`       | string  | `''`    | Bearer token sent as `Authorization: Bearer <token>`.          |
| `verify_tls`       | boolean | `true`  | Passed to Guzzle `verify`; validates the server TLS cert on HTTPS. |
| `connect_timeout`  | integer | `5`     | Guzzle `connect_timeout` (seconds); form enforces `min 1`.     |
| `response_timeout` | integer | `10`    | Guzzle `timeout` (seconds); form enforces `min 1`.             |

The form is a `ConfigFormBase` editing only `awx.settings` (`getEditableConfigNames()`).

## Form field notes (`buildForm()` / `submitForm()`)

- **`url`** — `#type => url`, required. Saved as `rtrim($value, '/')`.
- **`auth_token`** — `#type => password`. The existing token is **never rendered back** into the
  field. If a token is already configured the field is optional and its description says *"Leave
  blank to keep the existing value"*; `submitForm()` only calls `->set('auth_token', …)` when a
  non-empty value was entered, so leaving it blank preserves the current DB value or a
  `settings.php` override. Both descriptions steer operators to set the token via a config override
  in `settings.php` rather than storing it in the database.
- **`verify_tls`** — `#type => checkbox`, cast to bool on save (default checked/on).
- **`connect_timeout` / `response_timeout`** — `#type => number`, required, `#min => 1`, cast to
  int on save.

## Set the token via `settings.php` (recommended by the form)

Keep the token out of the DB / exported config by overriding it at runtime:

```php
// settings.php
$config['awx.settings']['url'] = 'https://awx.example.com';
$config['awx.settings']['auth_token'] = getenv('AWX_API_TOKEN');
```

A config override wins over the stored value, so the form's `auth_token` field can be left blank.

## How the client consumes it

`AwxClient::__construct()` loads `configFactory->get('awx.settings')` once. Every request reads
`url`, `auth_token`, `verify_tls`, `connect_timeout`, and `response_timeout` from it (see
[../api/client.md](../api/client.md)). Because the config is read at service construction, change a
value and rebuild/clear caches (or re-request) for a long-lived worker to pick it up.
