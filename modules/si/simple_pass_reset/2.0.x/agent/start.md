# Simple Password Reset — agent index

Skips Drupal's intermediate one-time-login page: the reset link lands the user directly on a
"Choose a new password" form and logs them in on submit. One setting controls the post-reset
redirect.

- **The `login_redirection` setting, route, permission, drush** →
  [configure/settings.md](configure/settings.md)
- **How the reset flow is rewritten (route override, access check, form alter)** →
  [api/mechanism.md](api/mechanism.md)

Key facts: config object `simple_pass_reset.settings` → `login_redirection` (string, default
`/user`); config UI `simple_pass_reset.admin_settings` at
`/admin/config/people/accounts/simple_pass_reset`; permission `administer simple pass reset`.
The module overrides the core `user.reset` route. `<front>` in the form is stored as `/`.
