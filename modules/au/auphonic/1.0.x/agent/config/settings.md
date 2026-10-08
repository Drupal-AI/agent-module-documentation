<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auphonic settings (connect the account)

## Install & enable

```bash
composer require drupal/auphonic
drush en auphonic -y
```

Requires `drupal/ai` (`^1.0.0-alpha8`) and `drupal/key` (`^1.18`). The `key` module is used both by the
config form (a `key_select` element) and by the API client, so it must be enabled. Note: `key` is required
by `composer.json` but is **not** listed in `auphonic.info.yml` `dependencies` — enable it explicitly if it
is not already on. An Auphonic account is required (free tier ~2h/month); video normalization needs FFmpeg
on the server.

## The form

`Drupal\auphonic\Form\AuphonicConfigForm` (`getFormId()` = `auphonic_settings`).

- Route: **`auphonic.settings`** → path `/admin/config/auphonic/settings`, permission
  **`administer site configuration`** (`auphonic.routing.yml`).
- Menu: link `auphonic.settings_menu` under parent `ai.admin_providers`
  (`auphonic.links.menu.yml`), title "Auphonic Config".
- Editable config: **`provider_auphonic.settings`** (`AuphonicConfigForm::CONFIG_NAME`).

Fields:

| Field | `#type` | Config key | Notes |
|---|---|---|---|
| Auphonic Username | `textfield` | `username` | Plain string. From your Auphonic account settings page. |
| Auphonic Password | `key_select` | `password` | Stores the **Key entity id**, not the secret itself. |

`submitForm()` simply saves both `username` and `password` into the config object.

## Config object & schema

`config/install/provider_auphonic.settings.yml` ships empty defaults:

```yaml
username: ""
password: ""
```

`config/schema/provider_auphonic.schema.yml` (`provider_auphonic.settings` mapping):

```yaml
username:
  type: string
  required: true
password:
  type: string   # holds a Key id ("Password Key")
  required: true
```

## How the password becomes a secret

The stored `password` is a **Key id**. At runtime `AuphonicApi::__construct()` reads it and resolves the
real value with the Key repository:

```php
$password = $configFactory->get(...)->get('password');
if ($password) {
  $this->password = $keyRepository->getKey($password)->getKeyValue();
}
```

So the actual Auphonic password lives in whatever Key provider you configured (env var, file, config, …),
and the module config only references it by id. Use an env-backed Key to keep the secret out of exported
config.

## Drush example

```bash
# Point the provider at an existing Key entity id 'auphonic_password'
drush cset provider_auphonic.settings username 'your-auphonic-user' -y
drush cset provider_auphonic.settings password 'auphonic_password' -y
drush cr
```

If `username` or `password` is empty, every API call throws `\Exception('No username or password set.')`
(guard in `AuphonicApi::makeRequest()`), and `AuphonicProvider::isUsable()` returns FALSE when `password`
is empty.
