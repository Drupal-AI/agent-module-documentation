<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure allowed paths

## Config object

`jwt_path_auth.config` (config_object, schema `jwt_path_auth.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `allowed_path_prefixes` | sequence of string | `['/system/files/']` | Request-path prefixes on which a `?jwt=` token is accepted. |

Only requests whose path **starts with** one of these prefixes will even attempt query-string
JWT authentication; everything else ignores the `jwt` query parameter. Each prefix must begin
with `/` (validated by the form).

## UI

Route `jwt_path_auth.config_form` at `/admin/config/system/jwt/path-auth`
(permission `administer jwt`). A single textarea *"Path Prefixes"* — one prefix per line.
Saving replaces the whole list.

## Read / set via drush

```bash
drush cget jwt_path_auth.config allowed_path_prefixes
```

```php
// Add a prefix to the existing list.
$config = \Drupal::configFactory()->getEditable('jwt_path_auth.config');
$prefixes = $config->get('allowed_path_prefixes') ?: [];
$prefixes[] = '/my/protected/';
$config->set('allowed_path_prefixes', array_values(array_unique($prefixes)))->save();
```

Baseline after enabling the module is exactly `['/system/files/']` (from `config/install`).
