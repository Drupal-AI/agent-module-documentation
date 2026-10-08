# Hooks implemented

`localgov_geo` has no routes/services/forms of its own — its runtime behaviour is entirely hooks in
`localgov_geo.module` and `localgov_geo.install`. All target the `geo_entity` entity supplied by the
`geo_entity` dependency.

## Runtime hooks (`localgov_geo.module`)

| Hook | Effect |
|------|--------|
| `hook_localgov_roles_default()` | Declares default geo permissions per LocalGov role (consumed by the `localgov_roles` module — see table below). |
| `hook_menu_local_actions_alter()` | Renames the `geo_entity.add_page` local action from "Add geo" to **"Add location"**. |
| `hook_menu_local_tasks_alter()` | Renames the `entity.geo_entity.collection` tab to **"Locations"** and sets its `#weight` to `50`. |
| `hook_preprocess_breadcrumb()` | On `entity.geo_entity.add_page` / `add_form` routes, relabels breadcrumb crumbs to "Locations" / "Add location". |
| `hook_preprocess_html()` | On `entity.geo_entity.collection` / `add_page`, relabels the `<head>` title to "Locations" / "Add location". |
| `hook_preprocess_page_title()` | On the same routes, relabels the visible page title. |

The relabel hooks only fire on the matched `geo_entity` route names; they are cosmetic (Geo → Location).

### `hook_localgov_roles_default()` mapping

| LocalGov role (constant) | Permissions granted |
|--------------------------|---------------------|
| `RolesHelper::EDITOR_ROLE` | `access geo overview`, `create geo`, `delete any geo`, `edit any geo`, `access geo_entity_library entity browser pages` |
| `RolesHelper::AUTHOR_ROLE` | `create geo`, `access geo_entity_library entity browser pages` |
| `RolesHelper::CONTRIBUTOR_ROLE` | `create geo`, `access geo_entity_library entity browser pages` |

All of these permission strings are defined by `geo_entity`, not by this module.

## Install / update hooks (`localgov_geo.install`)

| Function | Effect |
|----------|--------|
| `localgov_geo_install($is_syncing)` | Returns early during config sync. Otherwise rebuilds the router (`router.builder->rebuild()`) to avoid a `filter`-module route-cache ordering issue, then grants `view geo` to BOTH the anonymous and authenticated roles (only when `user` is enabled). The source comment states location data is intended to be public so it appears in Search API results indexed against anonymous access. |
| `localgov_geo_update_last_removed()` | Returns `8810` — the cut point where pre-Drupal-10 update hooks (now living in `geo_entity`) were removed. |
| `localgov_geo_update_10001()` | Grants `create geo` + `access geo_entity_library entity browser pages` to the `localgov_editor`, `localgov_author`, `localgov_contributor` roles. |

## Integrator notes

- The module depends on `localgov_roles` / `localgov_core` conventions for the roles-default hook to
  take effect (it is a dev dependency `drupal/localgov_core: ^2.13 || ^3.0`; the roles constants come
  from `localgov_roles`). Without those, only the install-time `view geo` grant applies.
- To change who can view locations, adjust the `view geo` permission on the relevant roles after
  install (it is granted, not enforced, at install time).
