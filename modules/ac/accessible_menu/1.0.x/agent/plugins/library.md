<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `accessible_menu_library` plugin type

Accessible Menu defines its own plugin type so that each front-end menu library (the base
library, the Bootstrap 5 variant, or your own) is a discoverable plugin describing where its
assets live and which menu types / JS constructors it exposes.

## Pieces (all in `src/`)

- **Annotation** `Annotation/AccessibleMenuLibrary` (`@Annotation`) — properties: `id`, `title`,
  `description`, `base_path`, `dist_dir`, `cdns` (array of `{label, url}` keyed by provider),
  `file_name`, `menu_types`.
- **Interface** `AccessibleMenuLibraryInterface` — `label()`, `basePath()`, `distDir()`, `cdns()`,
  `fileName()`, `menuTypes()`.
- **Base class** `AccessibleMenuLibraryPluginBase extends PluginBase` — returns those values from
  the plugin definition. Concrete plugins usually add nothing but the annotation.
- **Manager** `AccessibleMenuLibraryPluginManager` (final, extends `DefaultPluginManager`), service
  `plugin.manager.accessible_menu_library` (parent `default_plugin_manager`). Discovers plugins in
  `Plugin/AccessibleMenuLibrary`, alter hook `accessible_menu_library_info`, cache key
  `accessible_menu_library_plugins`. Adds `createInstances(array $ids = [], $configuration = [])`
  (interface `AccessibleMenuLibraryPluginManagerInterface`) — instantiates all definitions when
  `$ids` is empty; used by `SettingsForm` to render one fieldset per library.

## Shipped plugin

`Plugin/AccessibleMenuLibrary/AccessibleMenu.php` — id `accessible_menu`,
`base_path = "libraries/accessible-menu"`, `dist_dir = "dist"`,
`file_name = "accessible-menu.iife.js"`, CDNs `jsdeliver` (`//cdn.jsdelivr.net/npm/accessible-menu`)
and `unpkg` (`//unpkg.com/accessible-menu`), and four `menu_types`:

| Type key | Constructor (JS global) | file_name |
|---|---|---|
| `disclosure_menu` | `DisclosureMenu` | `disclosure-menu.iife.js` |
| `menubar` | `Menubar` | `menubar.iife.js` |
| `top_link_disclosure_menu` | `TopLinkDisclosureMenu` | `top-link-disclosure-menu.iife.js` |
| `treeview` | `Treeview` | `treeview.iife.js` |

The `constructor` value is the global the runtime JS (`window[constructor]`) instantiates; the
`file_name` values are turned into paths (CDN or local) by `SettingsForm::submitForm()` and stored
in the `accessible_menu.library.<id>` config's `menu_types` map.

## Adding your own library

1. Create a module with a class in `src/Plugin/AccessibleMenuLibrary/` extending
   `AccessibleMenuLibraryPluginBase`, carrying an `@AccessibleMenuLibrary(...)` annotation with a
   unique `id`, its `base_path`/`dist_dir`/`file_name`, `cdns`, and a `menu_types` map (each with
   `label`, `constructor` matching a JS global your library exposes, and `file_name`).
2. Ship an install config `config/install/accessible_menu.library.<id>.yml` (see the base module's
   for shape) so the library exists before the settings form is visited.
3. Provide the JS build (CDN package or `/libraries/<base_path>` copy) whose IIFE defines the
   `constructor` globals. Optionally add Twig templates + `hook_theme` for the type, as the
   Bootstrap 5 submodule does.

The Bootstrap 5 submodule (`accessible_menu_bootstrap_5`) is the reference example of a second
plugin.
