Rename Admin Paths replaces the `/admin` and `/user` path prefixes in Drupal routes with custom terms (e.g. `/admin` → `/backend`, `/user` → `/member`) for light backend hardening and branding.

---

The module ships a settings form at **Admin → Configuration → System → Rename Admin Paths** (`/admin/config/system/rename-admin-paths`, route `rename_admin_paths.admin`) with two independent toggles — one for the `admin` prefix and one for the `user` prefix — each paired with a text field for the replacement term. When a prefix is enabled, a route-alter event subscriber (`RenameAdminPathsEventSubscriber`, subscribed to `RoutingEvents::ALTER` at priority `-2048`) walks the whole route collection and rewrites the leading path segment of every route whose path starts with `/admin` or `/user` (matching `/admin`, `/admin/` and `/admin/*` but not `/admin*`). Settings live in the `rename_admin_paths.settings` config object with keys `admin_path`/`admin_path_value` and `user_path`/`user_path_value`; the enabled flags are integers (0/1) and the values are strings (defaults `backend` and `member`). Replacement values are validated to contain only letters, numbers, hyphens and underscores, must be non-empty, and may not reuse the reserved names `admin` or `user`. Saving the form calls `router.builder->rebuild()` so the renamed routes take effect immediately, and redirects you back to the form at its new path. Because Drupal generates admin links from route names rather than hard-coded paths, menus and most links follow automatically — but this is security-by-obscurity, not real access control, and hard-coded paths in some modules or Views-generated report links will not be rewritten.

---

- Rename `/admin` to a custom prefix like `/backend` or `/control` for obscurity.
- Rename `/user` to a custom prefix like `/member` or `/account`.
- Reduce automated bot spam that targets the well-known `/user/register` and `/user/login` paths.
- Make a Drupal site harder to fingerprint by moving its default admin URLs.
- Brand the backend URL to match a client or organization convention.
- Enable renaming for only the admin prefix while leaving `/user` untouched (or vice versa).
- Move the admin login/config surface off predictable paths as a defense-in-depth layer.
- Deploy the rename settings as configuration across dev/stage/prod via `drush config:export`.
- Look up the current renamed value with `drush cget rename_admin_paths.settings`.
- Restrict who may change the paths using the `administer path admin` permission.
- Rename paths without writing code — everything is driven from the settings form.
- Keep admin menu and toolbar links working automatically since they resolve by route name.
- Rebuild routes automatically on save so the new prefix is live without a manual cache clear via the form.
- Manually rebuild routes (`drush cr` / router rebuild) after importing renamed config in a deployment.
- Prevent accidental lockout by validation that blocks empty or reserved (`admin`/`user`) replacement values.
- Constrain replacement terms to URL-safe characters (letters, numbers, hyphens, underscores).
- Disable a rename to instantly restore the original `/admin` or `/user` prefix.
- Combine with real access controls (permissions, firewall) rather than relying on renaming alone.
- Discourage casual probing of `/admin` by visitors guessing common Drupal URLs.
- Set different replacement terms for admin and user prefixes independently.
- Recover a forgotten renamed value by reading the `rename_admin_paths.settings` config row.
- Apply the rename site-wide to every route beginning with the chosen prefix in one operation.
- Use as a lightweight companion to modules that harden the actual login/authentication flow.
- Audit the mechanism by inspecting the single event subscriber that rewrites route paths.
