# Configuration

The module has exactly two settings, on one small form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Redirect After Registration**, or navigate
   directly to `/admin/config/redirect_after_registration/config`.

## The settings

- **Redirect** — the internal path to send the user to after they register. This is a
  core path field (max 64 characters), stored exactly as you type it. The shipped
  default is `/user/login`. Enter something like `/welcome` or `/onboarding` to send
  new users there instead.
  - **Leave it empty to disable the feature** — with no path, no redirect fires and
    Drupal's normal post-registration behaviour takes over.
  - Only **on-site paths** are honoured. The module builds the URL with the
    `internal:` scheme, so external URLs won't work — this is deliberate, and keeps it
    from being an open-redirect vector.
- **Also redirect when an admin creates a user** (`redirect_admin_user_create`) —
  off by default. When **off**, only anonymous self-registration is redirected;
  accounts an administrator creates at **People → Add user**
  (`/admin/people/create`) follow the normal admin flow. Turn it **on** to redirect
  those admin-created accounts too.

Click **Save configuration** to apply.

## Setting values without the UI

```bash
ddev drush config:set redirect_after_registration.settings redirect '/welcome' -y
ddev drush config:set redirect_after_registration.settings redirect_admin_user_create 1 -y
```

You can also override the target per environment in `settings.php`:

```php
$config['redirect_after_registration.settings']['redirect'] = '/onboarding';
```
