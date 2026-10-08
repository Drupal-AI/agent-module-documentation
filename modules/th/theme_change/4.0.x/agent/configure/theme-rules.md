# Configure theme rules (create/edit/delete `theme_change` entities)

Each rule is a `theme_change` config entity that says "when this route/path matches, render this
theme". Manage them at `/admin/config/system/theme_change` (route
`entity.theme_change.collection`). The list builder
(`src/Controller/ThemeChangeListBuilder.php`) shows columns: Label, Type, Path, Route, Theme (theme
column resolves via the `theme_handler` service's `getName()`).

## Add / edit form — `ThemeChangeForm` (`src/Form/ThemeChangeForm.php`)

Fields (`form()`, lines 61–119):

| Field | `#type` | Notes |
|---|---|---|
| `label` | textfield | required, maxlength 255 |
| `id` | machine_name | uniqueness via `exist()` (entity query on `id`); locked once created |
| `type` | select | options `route` or `path` |
| `route` | textfield | shown only when `type == route` (`#states`) |
| `path` | textfield | shown only when `type == path` (`#states`); **supports comma-separated values and wildcards** e.g. `/user/*, /node/*` |
| `theme` | select | options = installed themes from `theme_handler->listInfo()` (installed themes only, not merely discovered) |

### Validation (`validateForm()`, lines 124–150)
- `type == route` + a route entered that does not resolve (`router.route_provider->getRoutesByNames`
  count !== 1) → error "`%route` Route Doesnot exists".
- `type == route` but only `path` filled → error "Select type as Path".
- `type == path` but only `route` filled → error "Select type as Route".
- `type == path` and the path's first char isn't `/` → "The path needs to start with a slash."
- Neither route nor path filled → "Route/Path Required".

### Save (`save()`, lines 155–165)
Calls `$entity->save()`, sets a status message, and redirects to
`entity.theme_change.collection`. No cache clear is performed by the module — see the caching note
in [../api/services.md](../api/services.md).

## Delete — `ThemeChangeDeleteForm` (`src/Form/ThemeChangeDeleteForm.php`)
Standard `EntityConfirmFormBase` confirm form (route
`entity.theme_change.delete_form`); on confirm calls `$entity->delete()` and redirects to the
collection.

## Config export shape
A saved rule exports as `theme_change.theme_change.<id>.yml` with keys `uuid`, `id`, `label`,
`type`, `path`, `route`, `theme` (schema `theme_change.theme_change.*`). Only one of `path`/`route`
carries a value; the other is empty depending on `type`. You can therefore stage rules as
configuration and deploy them with `drush config:import` rather than clicking through the UI.

## Path vs route — which to pick
- **route**: exact match against the current route **name** (e.g. `entity.node.canonical`). Precise,
  survives alias changes, but you must know the route machine name (the form rejects unknown routes).
- **path**: matched by `path.matcher` against both the raw current path and its **path alias**
  (that is why the module depends on `path_alias`), so `/node/*` and an aliased URL both work.
  Wildcards and comma-separated lists are supported.
