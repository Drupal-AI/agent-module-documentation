# htmlmail — agent start

Replaces Drupal's mail system with an HTML mailer so system emails are themed with Twig.
Provides the `@Mail` plugin `htmlmail`; depends on **Mail System** (mailsystem). Installed
release is **4.0.0-beta2 (beta, pre-stable)**.

Setup: `drush en htmlmail -y`. On install it registers `htmlmail` in `system.mail` and sets
mailsystem `defaults.sender`/`defaults.formatter` to `htmlmail`. Use the Mail System page
(`/admin/config/system/mailsystem`) to route specific modules through HTML Mail.

Config UI: **Admin → Configuration → System → HTML Mail** (`/admin/config/system/htmlmail`,
route `htmlmail.settings`); test form at `/admin/config/system/htmlmail/test` (`htmlmail.test`).
Both require the `administer site configuration` permission.

- Settings keys, config object, admin routes, post-filter/MIME options → [configure/settings.md](configure/settings.md)
- Email Twig templates, theme hook, suggestions, variables → [theming/templates.md](theming/templates.md)
- Mail plugin, helper API, per-user plaintext, preprocess hook → [api/api.md](api/api.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
