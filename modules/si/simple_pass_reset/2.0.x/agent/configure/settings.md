# Configure Simple Password Reset

## The one setting — `simple_pass_reset.settings:login_redirection`

Where the user is sent after they reset their password and are logged in.

- Config object: `simple_pass_reset.settings`, key **`login_redirection`** (string).
- Install default: **`/user`** (the user's own profile page).
- Schema: `config/schema/simple_pass_reset.settings.yml`.

## Admin UI

- Route: `simple_pass_reset.admin_settings` → `/admin/config/people/accounts/simple_pass_reset`.
- Form: `Drupal\simple_pass_reset\Form\SettingsForm` (form field id `redirect_path`, saved to
  `login_redirection`).
- Permission: **`administer simple pass reset`**.

Validation rules in the form:
- The value must be an internal path starting with `/`, **or** the literal `<front>`.
- `<front>` is converted to `/` on save.
- The path is checked with `path.validator` (`isValid()`), so it must resolve.

## Change it via drush

```bash
# Redirect to a dashboard after reset:
drush config:set simple_pass_reset.settings login_redirection '/admin/content' -y
# Redirect to the front page (what entering <front> in the form stores):
drush config:set simple_pass_reset.settings login_redirection '/' -y
# Read current value:
drush config:get simple_pass_reset.settings login_redirection
```

If `login_redirection` is empty, the submit handler falls back to the `user.page` route
(the user profile).

## Permission

`administer simple pass reset` (`simple_pass_reset.permissions.yml`) — gates the settings
form only. It does not affect who can use the reset link (that is core's flow, re-checked by
this module's access checker).
