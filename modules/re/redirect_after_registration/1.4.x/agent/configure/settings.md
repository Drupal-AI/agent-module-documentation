# Configure Redirect After Registration

Config UI: **`/admin/config/redirect_after_registration/config`** (route
`redirect_after_registration.redirect_after_registration_config_form`, permission
`administer site configuration`, listed under *Configuration → System*).

## Config object `redirect_after_registration.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `redirect` | string | `/user/login` | Internal path to send the user to after registration. Leave empty to disable. Rendered by a core `#type = 'path'` element (max 64 chars, `#convert_path = CONVERT_NONE`, so it is stored verbatim). |
| `redirect_admin_user_create` | bool | `false` | If TRUE, also redirect when an admin creates an account at `/admin/people/create`. If FALSE, only anonymous self-registration is redirected. |

Note: `config/install` ships `redirect: "/user/login"` and `redirect_admin_user_create: false`.
Older sites may have migrated from a `destination` key (see `redirect_after_registration.install`
updates `90501`/`90502`).

## How the redirect fires

`redirect_after_registration.module`:

- `hook_form_alter` on `user_register_form` appends `_redirect_after_registration_user_register_submit`
  to `$form['actions']['submit']['#submit']`.
- The submit handler redirects only when `redirect` is non-empty **and**
  (`redirect_admin_user_create` is TRUE **or** the current user is anonymous):
  ```php
  $url = Url::fromUri('internal:' . $config->get('redirect'));
  $form_state->setRedirectUrl($url);
  ```
- The `internal:` scheme means the target must be an on-site path — external URLs are not honored,
  and only a `administer site configuration` admin can set it.

## Set it with Drush

```bash
ddev drush config:set redirect_after_registration.settings redirect '/welcome' -y
ddev drush config:set redirect_after_registration.settings redirect_admin_user_create 1 -y
```

Or per-environment override in `settings.php`:

```php
$config['redirect_after_registration.settings']['redirect'] = '/onboarding';
```
