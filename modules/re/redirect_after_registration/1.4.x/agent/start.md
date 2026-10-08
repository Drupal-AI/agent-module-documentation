# Redirect After Registration — agent index

Appends a submit handler to the core `user_register_form` that redirects the user to a
configured internal path after registration. No permissions of its own, no plugins, no
services, no Drush. One config object; one submit handler in `.module`.

- **The single setting, where it lives, the config route, and how the redirect fires** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `redirect_after_registration.settings` — keys `redirect` (string path, default
  `/user/login`) and `redirect_admin_user_create` (bool, default `false`).
- Config UI: `/admin/config/redirect_after_registration/config`
  (route `redirect_after_registration.redirect_after_registration_config_form`), permission
  `administer site configuration`.
- Redirect built with `Url::fromUri('internal:' . $redirect)` → on-site paths only (not an open
  redirect). Fires when the registrant is anonymous, OR when `redirect_admin_user_create` is TRUE.
- Empty `redirect` = feature disabled.
