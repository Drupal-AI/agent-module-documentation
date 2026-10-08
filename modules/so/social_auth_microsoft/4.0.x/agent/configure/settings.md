<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Social Auth Microsoft

## Settings page

- Path: `/admin/config/social-api/social-auth/microsoft`
- Route: `social_auth.network.settings_form` (from base `social_auth`), route param `network = microsoft`.
- Access: permission `administer social api authentication` (defined by `social_api`).
- The form is the shared `Drupal\social_auth\Form\SocialAuthSettingsForm` (form id `social_auth_admin_form`); it is not a form owned by this module. `social_auth_microsoft.links.task.yml` exposes it as the "Microsoft" tab under the Social Auth integrations list (`/admin/config/social-api/social-auth`).
- `info.yml` declares `configure: social_auth_microsoft.settings_form`, but there is no route with that name in the module or its dependencies — use the generic route above.

## Config object: `social_auth_microsoft.settings`

Schema `config/schema/social_auth_microsoft.schema.yml`, type `config_object`. Written by the settings form's `submitForm()`.

| Key | Form field | Type | Meaning |
|-----|-----------|------|---------|
| `client_id` | Client ID (required) | string | Azure/Microsoft "Application (client) ID". |
| `client_secret` | Client secret (required) | string | The client secret **Value** from the app registration. |
| `scopes` | Advanced ▸ Scopes for API call | string | Extra OAuth scopes, **comma-separated**, appended to the defaults `wl.basic`, `wl.emails`. |
| `endpoints` | Advanced ▸ API calls to be made | string | Extra Graph calls run on first login to collect data; one per line as `path|name` (e.g. `/me/photo|photo`). Stored on the user's Social Auth record as additional data. |

The read-only "Authorized redirect URL" field on the form is the callback URL you paste into the
Microsoft app registration; it is `/user/login/microsoft/callback` (absolute). It is not stored in
config — it is derived from the network plugin's callback route.

Behavior settings shared by every Social Auth provider live in a **separate** config object,
`social_auth.settings` (also editable on this same form): `post_login`, `user_allowed`
(`register` | `login`), `redirect_user_form`, `disable_admin_login`, `disabled_roles`. These govern
whether new accounts may be created, where users land after login, whether user 1 / certain roles
may use social login, etc.

## Set via Drush / PHP

```bash
drush config:set social_auth_microsoft.settings client_id '<APP_CLIENT_ID>' -y
drush config:set social_auth_microsoft.settings client_secret '<APP_SECRET_VALUE>' -y
# Optional extra scopes (comma-separated) and endpoints (one "path|name" per line):
drush config:set social_auth_microsoft.settings scopes 'wl.contacts_emails' -y
```

```php
\Drupal::configFactory()->getEditable('social_auth_microsoft.settings')
  ->set('client_id', '<APP_CLIENT_ID>')
  ->set('client_secret', '<APP_SECRET_VALUE>')
  ->set('scopes', '')
  ->set('endpoints', '')
  ->save();
```

The credential values are read back through `Drupal\social_auth\Settings\SettingsBase::getClientId()`
/ `getClientSecret()` when the module builds the OAuth client. As with any Drupal config, both keys
can be kept out of exported/staged config by overriding them in `settings.php`
(`$config['social_auth_microsoft.settings']['client_secret'] = getenv('MS_CLIENT_SECRET');`).

## Placing the login button

Put the core **Social Auth Login** block (`social_auth_login`) somewhere via Structure ▸ Block Layout —
it shows the Microsoft logo automatically. Or link/theme anything pointing at `/user/login/microsoft`.
