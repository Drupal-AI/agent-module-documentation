# Configure renamed admin/user paths

## Settings form

- Route: `rename_admin_paths.admin` (info.yml `configure` target)
- Path: `/admin/config/system/rename-admin-paths` (Admin → Configuration → System → Rename Admin Paths)
- Permission: `administer path admin` (`restrict access: TRUE`)
- Form: `Drupal\rename_admin_paths\Form\RenameAdminPathsSettingsForm`

The form has two fieldsets — **Rename admin path** and **Rename user path** — each with a
checkbox (enable) and a textfield (the replacement term).

## Config object — `rename_admin_paths.settings`

Config schema: `config/schema/rename_admin_paths.schema.yml` (type `config_object`).
Edit via the form or `drush cset rename_admin_paths.settings <key> <value>`; read with
`drush cget rename_admin_paths.settings`. Install defaults shown:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `admin_path` | integer | `0` | 1 = rename the `/admin` prefix, 0 = leave it |
| `admin_path_value` | string | `backend` | Term that replaces `admin` (e.g. `/backend`) |
| `user_path` | integer | `0` | 1 = rename the `/user` prefix, 0 = leave it |
| `user_path_value` | string | `member` | Term that replaces `user` (e.g. `/member`) |

Settings live in a config object, so they export/deploy with `drush config:export`.

## Validation (before save)

Replacement values are checked (`RenameAdminPathsValidator` + form `validate`):
- must be non-empty;
- must match `^[a-zA-Z0-9_-]+$` (letters, numbers, hyphens, underscores only);
- must not equal a reserved default name (`admin` or `user`).

## Mechanism — how the rename happens

`Drupal\rename_admin_paths\EventSubscriber\RenameAdminPathsEventSubscriber` subscribes to
`RoutingEvents::ALTER` at priority `-2048` (very low, so it runs after core subscribers
like `AdminRouteSubscriber`). For each enabled prefix in `ADMIN_PATHS = ['admin','user']`
it iterates the entire `RouteCollection` and, for every route whose path matches
`~^/{prefix}(?:/(.*))?$~` (so `/admin`, `/admin/`, `/admin/*` — but **not** `/admin*`),
rewrites just the first path segment via `preg_replace('~^/{from}~', '/{to}', …, 1)`.

Saving the form calls `router.builder->rebuild()`, so the renamed routes are live
immediately and the form redirects to itself at the new path. After importing renamed
config in a deployment, rebuild routes (`drush cr` / router rebuild) for it to take effect.

## Caveat

This is **security-by-obscurity / branding**, not real security. It hides default URLs and
can cut bot spam hitting `/user/register`, but it is not access control — pair it with real
permissions and authentication hardening. Hard-coded paths (some modules, and
Views-generated links in admin reports) are **not** rewritten.
