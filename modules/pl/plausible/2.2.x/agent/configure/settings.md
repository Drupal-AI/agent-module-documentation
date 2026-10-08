# Plausible — configuration

Settings form `plausible.admin_settings_form` at `/admin/config/services/plausible` (requires
`administer plausible configuration`). All values live in the `plausible.settings` config object
(defaults in `config/install/plausible.settings.yml`, schema in `config/schema/plausible.schema.yml`).

## `script` — the tracking snippet

| Key | Default | Meaning |
|---|---|---|
| `script.domain` | `''` | Tracked domain (legacy snippet → `data-domain`). Empty ⇒ auto-detected from the front-page host. |
| `script.api` | `''` | Optional custom event/API endpoint. New snippet ⇒ `plausible.init({endpoint})`; legacy ⇒ `data-api`. |
| `script.src` | `''` | URL of the Plausible JS (e.g. `https://plausible.io/js/plausible.js`, or a self-hosted/proxied path). |
| `script.version` | `october-2025` | `october-2025` uses the new snippet; any other value uses the legacy snippet (which requires `src`). |

### Two snippets (`plausible.module`)

- **New (`october-2025`)** — `_plausible_attach_new_snippet()`: async/defer `<script src=script.src>`
  plus an inline bootstrap `window.plausible=...; plausible.init({endpoint?})`.
- **Legacy** — `_plausible_attach_old_snippet()`: async/defer `<script>` with `data-domain`
  (falls back to the front-page host) and optional `data-api`, plus the `window.plausible` queue
  shim. Only attached when `script.src` is set.

## `visibility` — where the snippet loads

Global gate `visibility.enable` (bool, default true) — false skips all tracking. Each mode below is an
integer; a matching Drupal cache context is added only when the mode is active.

| Key | Values | Behaviour |
|---|---|---|
| `visibility.request_path_mode` | 0 / 1 / 2 | 0 = every page; 1 = every page **except** `request_path_pages`; 2 = **only** `request_path_pages`. Adds `url.path` context. |
| `visibility.request_path_pages` | string | Newline path patterns (matched by `path.matcher`, alias-aware, front page `/`). |
| `visibility.user_role_mode` | 0 / 1 / 2 | 0 = all roles; 1 = track only `user_role_roles`; 2 = track everyone **except** `user_role_roles`. Adds `user.roles` context. |
| `visibility.user_role_roles` | sequence | Role IDs for the role rule. |
| `visibility.admin_route_mode` | 0 / 1 / 2 | 0 = unchanged; 1 = **don't** track admin routes; 2 = track **only** admin routes. Adds the custom `route.is_admin` context. |

The config is always added as cache tag `config:plausible.settings`.

## `events` — error-page custom events

- `events.403` (default false) — on a 403 response, emit `plausible("403", { props: { path: ... } })`.
- `events.404` (default false) — same for 404. Useful for finding broken links / blocked pages.

## `dashboard` — embedded reports page

- `dashboard.shared_link` — a Plausible **shared dashboard link**. The reports page
  `plausible.admin_dashboard` at `/admin/reports/plausible` (requires `view plausible dashboard`)
  embeds it in an `<iframe>` (`DashboardController`), appending `embed=true&background=transparent&
  theme=...`. If the active theme is **Gin**, the iframe `theme` param follows Gin's dark-mode setting
  (`light`/`dark`/`system`). If the shared link is unset, the page shows a link back to the settings
  form.

## Permissions (`plausible.permissions.yml`)

- `administer plausible configuration` — access the settings form / change tracking config.
- `view plausible dashboard` — view the embedded dashboard reports page.

## Services

- `cache_context.route.is_admin` → `RouteIsAdminCacheContext` (wraps `@router.admin_context`) — the
  `route.is_admin` cache context used by the admin-route visibility mode.
