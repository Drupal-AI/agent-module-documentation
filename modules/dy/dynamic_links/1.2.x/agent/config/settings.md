<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring dynamic links

## Install
`drush en dynamic_links -y`. No dependencies beyond Drupal core `^10.3 || ^11`. Grant the `administer dynamic_link` permission to trusted roles.

## The `dynamic_link` config entity
Defined in `src/Entity/DynamicLink.php` (`@ConfigEntityType id = "dynamic_link"`, `config_prefix = "link"`, so config objects are `dynamic_links.link.<id>`). Schema: `config/schema/dynamic_links.schema.yml` (`dynamic_links.link.*`). Exported keys (`config_export`):

- `id` (string) — machine name; also the entity `label` key. Used to build the route name `dynamic_link.<id>` and the event-per-link name.
- `path` (string) — the URL where this dynamic link is served, e.g. `/tasks`. This becomes a real route path.
- `use_subrequest` (bool, default FALSE) — FALSE = HTTP redirect; TRUE = render the target in place (see routes.md).
- `redirects` (sequence of strings, nullable) — ordered internal target paths. Populated in "paths" storage mode.
- `routes` (sequence, nullable) — ordered targets stored as `{name, parameters, options}`. Populated in "routes" storage mode.

`redirects` and `routes` are mutually exclusive: whichever mode is active is set, the other is set to NULL (see `DynamicLinkForm::validateForm()`). Entity `status()` (enabled/disabled) controls whether a route is registered.

## Admin UI and routes
Routes for the entity come from core's `AdminHtmlRouteProvider` (declared in the entity annotation `handlers.route_provider`) plus menu/action links:
- `entity.dynamic_link.collection` → `/admin/structure/dynamic-link` — listing (`DynamicLinkListBuilder`, columns: Status, ID, URL, As routes, Use subrequest). This is the module's `configure` route (info.yml).
- `entity.dynamic_link.add_form` → `/admin/structure/dynamic-link/add`.
- `entity.dynamic_link.edit_form` → `/admin/structure/dynamic-link/{dynamic_link}`.
- `entity.dynamic_link.delete_form` → `/admin/structure/dynamic-link/{dynamic_link}/delete` (core `EntityDeleteForm`).

All are gated by `admin_permission = "administer dynamic_link"` (the only permission the module defines, in `dynamic_links.permissions.yml`). Menu link under Structure and an "Add dynamic link" action link come from `dynamic_links.links.menu.yml` / `.links.action.yml`.

## The edit form (`src/Form/DynamicLinkForm.php`)
Fields:
- **Enabled** (`status`) — disabled links register no route.
- **Link ID** (`id`) — machine name; uniqueness via `DynamicLink::load`.
- **Link path** (`path`) — validated by `validatePath()`: normalized to a leading `/`; if it resolves to an existing route other than this link's own `dynamic_link.<id>`, it errors ("already routed by"); invalid input errors.
- **Redirect paths** (`raw_redirects`) — a textarea, one internal path per line; validated by `validateRawRedirects()`: each line must be a *routed* internal path (`Url::fromUserInput()` + `isRouted()`), must not point back at this link, else a form error. External URLs are rejected (they are not routed internal input).
- **Use subrequest** (`use_subrequest`).
- **Storage mode → Store redirect paths as routes** (`as_routes`) — when checked, `validateForm()` converts each entered path into `{name, parameters, options}` via `Url::fromUserInput()` (dropping route default params) and stores them in `routes` (with `redirects` = NULL); otherwise the raw paths are stored in `redirects` (with `routes` = NULL). When editing a routes-mode link the current `routes` array is shown as YAML.
- **Cacheability** (read-only) — shows the resolved destination and cache contexts/tags/max-age for the current user, computed from `getFirstAvailable()`.

On `save()`, a status message is shown, the user is redirected to the collection, and `router.builder` is rebuilt so the new/changed link's dynamic route is (de)registered immediately.

## Choosing paths vs routes mode
Use **paths** (`redirects`) for simple internal paths. Use **routes** (`routes`) when you want the target bound to a route name + parameters so it survives alias changes and carries explicit parameters/options. The runtime picks the mode based on which field is non-NULL (`getRoutes()` takes precedence over `getRedirects()` in `getFirstAvailable()`).
