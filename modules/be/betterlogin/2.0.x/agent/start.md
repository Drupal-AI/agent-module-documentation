# Better Login — agent index

Restyles Drupal's login / register / password / reset pages into standalone WordPress-style
screens. **No config, no settings form, no routes, no permissions, no plugins**
(`configure: null`) — it works the moment it is enabled. Pure theming + a couple of hooks.

- **The four templates, the CSS library, the form/title/tab hooks, the `?user=` redirect, and how
  to override the look** → [theming/login-pages.md](theming/login-pages.md)

Key facts:
- Templates: `page--user--login`, `page--user--register`, `page--user--password`, `page--user--reset`
  (in the module's `templates/`); template vars: `site_name`, `logo`, `title`, `register_url`.
- CSS library `betterlogin/betterlogin_css`, attached via `hook_form_alter` on the auth forms.
- `register_url` (and the "Register a new account" link) appears only when the `user.register`
  route is accessible — i.e. when `user.settings:register` is not `admin_only`.
- Override by copying the templates into your theme, or edit the module CSS. No UI to configure.
