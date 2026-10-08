<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wingsuit companion (`wingsuit_companion`) — agent index

Drupal side of the **Wingsuit** front-end/design-system toolkit. The main module registers a
**read-only `ws-assets://` stream wrapper** (`LocalReadOnlyStream`, scheme `ws-assets`) that resolves
to the front-end build's `dist` directory; submodules bridge that build into UI Patterns, Layout
Builder, link attributes and Page Manager. Version **8.x-2.2**. Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Package **Wingsuit**.

Configure at **`/admin/wingsuit-companion/form/config`** (route
`wingsuit_companion.wingsuit_companion_config_form`).
Permission: **`administer wingsuit configuration`** (`restrict access: true`).
No Drush commands. No new plugin *types* (it provides UI Patterns *plugins* via a submodule).

## Main module surface

- `WingsuitStreamWrapper` (`src/StreamWrapper/`) — `ws-assets://` read-only local stream; directory
  path = the `dist_path` config value. Service `stream_wrapper.wingsuit`.
- `ConfigForm` (`src/Form/`) — the single settings form: `dist_path`, `only_own_layout`,
  `auto_fill_link_url` (the last is added by `wingsuit_link`).
- Config object `wingsuit_companion.config` (schema provided). Install hook seeds `dist_path`.
- No routes other than the admin form; no cron, no entities.

## Config keys (`wingsuit_companion.config`)

- `dist_path` — filesystem path to the built `dist/app-drupal` directory. Default from
  `config/install` is `"/../../dist/app-drupal"`; `hook_install` sets
  `themes/custom/wingsuit/dist/app-drupal` only if empty; `wingsuit_companion_update_8001`
  canonicalizes it to an absolute path relative to the `wingsuit` theme.
- `only_own_layout` (bool) — when TRUE, `wingsuit_ui_patterns` hides every layout not provided by
  `wingsuit_companion`.
- `auto_fill_link_url` (bool) — when TRUE, `wingsuit_link` fills a button pattern's `url` setting
  from the link field.

## Submodules (each needs its own contrib deps present first)

- **`wingsuit_ui_patterns`** — the core integration. Pattern plugin `id = "yaml"`
  (`LibraryPattern`) with `LibraryDeriver` scanning `dist_path` for `*.wingsuit.yml` /
  `*.wingsuit.yaml` and deriving UI Patterns; Twig extension `ws_itok()` + `uuid()`; filters
  patterns by `visibility` (must include `drupal`); honors `only_own_layout`. Deps:
  `ui_patterns (>=1.1)`, `ui_patterns_layouts`, `ui_patterns_settings (>=2.0)`,
  `ui_patterns_extends`, `components`. See `twig/patterns-and-twig.md`.
- **`wingsuit_lb`** — Layout Builder browser reskin + section-library "Add to library" button.
  Deps: `layout_builder_browser (>=1.7)`, `field_group`, `gin_lb (>=1.0.0-rc7)`, `section_library`.
  See `submodules/wingsuit_lb.md`.
- **`wingsuit_link`** — maps a `button` pattern's variant/settings onto core link widgets. Deps:
  `link_attributes`, `ui_patterns_settings`. See `submodules/wingsuit_link.md`.
- **`wingsuit_page_manager`** — theme negotiator (priority 41) forcing frontend theme on Page
  Manager layout-builder steps + `gin_lb` toolbar tweaks. Dep: `drupal:text`. See
  `submodules/wingsuit_page_manager.md`.

## Doc map

- `config/configuration.md` — stream wrapper, config form, config keys, install/update behavior.
- `twig/patterns-and-twig.md` — the `*.wingsuit.yml` deriver, pattern plugin, Twig functions.
- `submodules/wingsuit_lb.md`, `submodules/wingsuit_link.md`,
  `submodules/wingsuit_page_manager.md` — per-submodule detail.

## Adoption note

Adoption is a **workflow decision, not just a module install**: it presumes a front-end project
with its own build producing a `dist` directory. Without that build the stream wrapper resolves to
nothing and the deriver finds no `*.wingsuit.yml` files. On a bare install only the main module is
enabled — the submodules require their contrib dependencies present first.
