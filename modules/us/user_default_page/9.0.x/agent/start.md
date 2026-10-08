# User Default Page — agent index

Redirects users after login/logout to a role- and/or user-targeted destination with an optional
message. One config entity type, no permissions of its own (admin UI gated by core `administer site
configuration`). Depends on core `user`. `configure` route: `user_default_page.action`
(`/admin/config/people/user_default_page`).

- **The `user_default_page_config_entity`, the login/logout redirect selection logic, path handling, and integration hooks** → [configure/config-entity.md](configure/config-entity.md)

Key facts:
- Redirect target comes from the admin-configured entity (`login_redirect` / `logout_redirect`), NOT from a request parameter, and is validated via `path.validator:getUrlIfValid()` before redirecting (no open-redirect from user input).
- Selection: per-UID match wins; otherwise highest-`weight` role match. Skipped for `user.reset.login` (and autologout routes on logout).
- Alter hook `user_default_page_login_ignore_whitelist` extends the login-ignore route list.
- `?upd=<entity_id>` on the landing page shows the stored login/logout message (`hook_page_attachments`).
