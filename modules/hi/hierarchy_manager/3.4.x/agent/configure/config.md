# Configure Hierarchy Manager

Two-step setup: (1) create a **display profile**, (2) enable a **setup plugin** and bind it
to that profile and to specific bundles/menus.

## 1. Display profile — `hm_display_profile` config entity

- List/add UI: `/admin/structure/hm_display_profile` (route
  `entity.hm_display_profile.collection`, perm `administer site configuration`).
- Config entity `hierarchy_manager.hm_display_profile.<id>` fields (schema
  `config/schema/hierarchy_manager.schema.yml`):
  - `id`, `label`
  - `plugin` — a display plugin id, e.g. `hm_display_jstree`
  - `config` — a JSON string of options passed to the display plugin. For jsTree this is a
    jsTree config object; `HmDisplayJstree` reads `theme.name` (default `default`).
  - `confirm` — bool; when true the user must confirm before a drag change is saved.

## 2. Main config form — `hierarchy_manager.hm_config_form`

- Path `/admin/config/user-interface/hierarchy_manager/config` (perm `administer site
  configuration`).
- Stored in config object `hierarchy_manager.hmconfig`:
  - `allowed_setup_plugins` — map of enabled setup plugin ids (`hm_setup_taxonomy`, `hm_setup_menu`).
  - `setup_plugin_settings.<plugin_id>` — per-plugin: `display_profile` (a profile id) and
    `bundle` (map of enabled bundles — vocabulary ids for taxonomy, menu ids for menu).

Once a setup plugin is enabled and bound, its target form is taken over by the tree:
taxonomy term overview (`/admin/structure/taxonomy/manage/<vid>/overview`) and the menu edit
form. Form takeover is done by `HmRouteSubscriber` + `PluginTypeManager`.

## JSON endpoints (front-end contract)

Defined in `hierarchy_manager.routing.yml`:

- `hierarchy_manager.taxonomy.tree.json` — `GET /admin/hierarchy_manager/taxonomy/json/{vid}`
- `hierarchy_manager.taxonomy.tree.update` — `/admin/hierarchy_manager/taxonomy/update/{vid}`
- `hierarchy_manager.menu.tree.json` / `.update` — `/admin/hierarchy_manager/menu/{json,update}/{mid}`

Access:
- Taxonomy routes use `_custom_access` (`HmTaxonomyController::access`): allowed if
  `administer taxonomy` **or** `edit terms in <vid>`. Every request also requires a valid CSRF
  `token` (`?token=`, validated against the `{vid}`), and each term is additionally filtered by
  its own `update` access before being returned or saved.
- Menu routes require the core `administer menu` permission.

## Library / self-hosting

`hierarchy_manager.libraries.yml` declares jsTree 3.3.15 and jsoneditor 9.9.2 with a cdnjs
`cdn:` fallback. Place a local copy under `/libraries/jquery.jstree/3.3.15/` (and
`/libraries/jsoneditor/9.9.2/`) to serve them locally instead of from the CDN.
