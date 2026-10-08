<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes, and permissions

## Install / enable

Core-only module. `drush en bitly_shortener -y`. `bitly_shortener.info.yml` declares
`core_version_requirement: ^9 || ^10 || ^11` and `configure: bitly_shortener:bitly_shortener_settings`.
No install hooks (`.install` absent). Config schema is provided.

## Settings form

`src/Form/BitlyShortenerSettingsForm.php` extends `ConfigFormBase`, form id
`bitly_shortener_settings_form`, editable config `['bitly_shortener.settings']`.

Route (`bitly_shortener.routing.yml`):

```yaml
bitly_shortener:bitly_shortener_settings:
  path: '/admin/config/bitly-shortener/api'
  defaults: { _title: 'Bitly Shortener API', _form: '\Drupal\bitly_shortener\Form\BitlyShortenerSettingsForm' }
  requirements: { _permission: 'administer site configuration' }
```

Menu link `bitly_shortener.settings_form` (`bitly_shortener.links.menu.yml`) sits under
`system.admin_config_ui` (Configuration → Development/UI). The module defines **no permissions** of
its own — access to the form is the core `administer site configuration` permission.

Form fields (all inside a `details` element):

- `bitly_shortener_enable` — checkbox.
- `bitly_shortener_api` — textfield; required & visible only when enable is checked.
- `bitly_shortener_token` — textfield (plain, labelled *Access Token*, with a link to
  `https://app.bitly.com/settings/api/`); required & visible only when enable is checked.

`validateForm()` rejects the token unless it matches `/^[a-zA-Z0-9]{40}+$/` (40 alphanumeric
chars) with *"Invalid bitly access token."*. `submitForm()` writes all three values to
`bitly_shortener.settings`.

Side effect: on **every** `buildForm()`, if `bitly_shortener_enable` is truthy the form calls
`$this->bitlyShortener->shortener('https://www.drupal.org/')` and shows the result as a
*"Bitly Shortener Status: …"* message — i.e. loading the settings page makes a live Bitly call.

## Config object `bitly_shortener.settings`

Install defaults (`config/install/bitly_shortener.settings.yml`):

```yaml
bitly_shortener_enable: 0
bitly_shortener_api: 'https://api-ssl.bitly.com/v4/bitlinks'
bitly_shortener_token: ''
```

Schema (`config/schema/bitly_shortener.schema.yml`): `bitly_shortener_enable` → integer,
`bitly_shortener_api` → string, `bitly_shortener_token` → string.

To set the token per-environment without committing it, override in `settings.php`:

```php
$config['bitly_shortener.settings']['bitly_shortener_token'] = getenv('BITLY_TOKEN');
$config['bitly_shortener.settings']['bitly_shortener_enable'] = 1;
```

## Help

`hook_help()` (in `bitly_shortener.module`) documents the service call and the Twig usage on
`help.page.bitly_shortener`.
