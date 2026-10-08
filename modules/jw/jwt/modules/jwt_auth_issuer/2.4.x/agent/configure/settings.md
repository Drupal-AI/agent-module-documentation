<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure JWT Auth Issuer

The module has exactly one setting and **no settings route of its own** — its `configure`
link points at the base module's form.

## Config object

`jwt_auth_issuer.config` (config_object, schema `jwt_auth_issuer.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `jwt_in_login_response` | boolean | `true` (from `config/install`) | When true, `JwtLoginSubscriber` adds a `jwt` token to the JSON body of the core user-login (`user.login.http`) response. |

## Where you set it in the UI

There is no `/admin/config/.../jwt-issuer` page. Instead `jwt_auth_issuer_form_jwt_config_form_alter()`
adds a **"JWT Auth issuer settings"** details section with an *"Include a JWT token in the user
login response"* checkbox onto the base module's config form at `/admin/config/system/jwt`
(route `jwt.jwt_config_form`). Saving that form writes `jwt_in_login_response`.

## Read / set via drush

```bash
drush cget jwt_auth_issuer.config jwt_in_login_response
```

```php
\Drupal::configFactory()->getEditable('jwt_auth_issuer.config')
  ->set('jwt_in_login_response', FALSE)->save();
```

The shipped `config/install/jwt_auth_issuer.config.yml` sets it to `true`; the update hook
`jwt_auth_issuer_update_20001()` seeds it (to FALSE) on sites upgraded from before the setting
existed.
