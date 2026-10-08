<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder (display_builder) — agent index

A design-system-native, drag-and-drop **display builder** for Drupal 11.4+ by the UI Suite team.
The base `display_builder` module is the engine (plugin types, entities, HTMX API, live preview);
the submodules add the actual builder screens. Package **User interface**. PHP **>=8.3**.
Composer `drupal/ui_patterns:^2.0.21`; info.yml enable-deps `ui_patterns:ui_patterns_field`,
`ui_patterns:ui_patterns_library`. License GPL-2.0-or-later. Version dir `1.x` (installed
`1.0.0-beta7`).

## What it is (from source)

- **Two plugin types** it defines:
  - `display_buildable` — manager `plugin.manager.display_buildable` (`DisplayBuildablePluginManager`),
    attribute `#[DisplayBuildable]` (`src/Attribute/DisplayBuildable.php`), interface
    `DisplayBuildableInterface`, base `DisplayBuildablePluginBase`, discovered under
    `Plugin/display_builder/Buildable/`. One plugin per *kind* of display; each declares an
    `instance_prefix` and a static `checkAccess()`. Submodules provide `entity_view`,
    `entity_view_override`, `page_layout` and `view_display` buildables.
  - `db_island` — manager `plugin.manager.db_island` (`IslandPluginManager`), attribute
    `#[Island]` (`src/Attribute/Island.php`), interface `IslandInterface`, base
    `IslandPluginBase`, discovered under `Plugin/display_builder/Island/`. Islands are the
    builder's UI pieces (panels, toolbars, buttons); ~30 ship in `src/Plugin/display_builder/Island/`.
- **Entities:**
  - `display_builder_instance` (content entity, `src/Entity/Instance.php`, storage
    `InstanceStorage`, access `InstanceAccessControlHandler`) — the revisionable draft holding a
    `buildable` plugin field, an unlimited `sources` (UI Patterns 2 source) field, a `hash` and a
    `published` timestamp. Base fields are (re)installed by `display_builder.install`
    (`display_builder_update_11101`–`11104` migrate from the old State-API storage).
  - `display_builder_profile` (config entity, `src/Entity/Profile.php`, prefix `profile`) — which
    islands are enabled/weighted for a builder screen. Admin permission
    `administer display builder profile`. Per-profile dynamic permission
    "Use the *label* Display Builder profile" (`ProfilePermissions`).
  - `pattern_preset` (config entity, `src/Entity/PatternPreset.php`) — a saved, reusable component
    sub-tree.
- **Config:** schema in `config/schema/display_builder.schema.yml` (profile, islands, pattern
  preset, `ui_patterns_slot_source.third_party_setting.styles`). Optional config ships a `default`
  profile and a `display_builder_html` text format.
- **HTMX API** (`display_builder.routing.yml`, controllers in `src/Controller/`) — all mutation
  routes gated by `_entity_access: display_builder_instance.update`; read/preview routes by
  `.view` or `_role: authenticated`. Live preview renders in an isolated iframe. SSE route drives
  collaboration.
- **Sources:** UI Patterns 2 source plugins under `src/Plugin/UiPatterns/Source/`
  (`ComponentSource`, `BlockSource`, `LayoutSource`, `TextareaWidget`); services
  `component_library_definitions`, `block_library_sources`, `slot_sources_proxy`,
  `summary_collector`. Bundled Shoelace + builder-chrome SDC components live under `components/`.
- No Drush commands. `provides_permissions` (dynamic per-profile). No standalone settings route
  (profiles are managed through `display_builder_ui`).

## Submodules (each documented in its own tree under `modules/…/1.x/`)

- **display_builder_ui** → [modules/display_builder_ui](../../modules/display_builder_ui/1.x/agent/start.md) —
  admin CRUD for profiles, presets and the instance list.
- **display_builder_entity_view** → [modules/display_builder_entity_view](../../modules/display_builder_entity_view/1.x/agent/start.md) —
  build entity view displays + per-entity overrides; Layout Builder migration.
- **display_builder_page_layout** → [modules/display_builder_page_layout](../../modules/display_builder_page_layout/1.x/agent/start.md) —
  `page_layout` config entity + a page display variant.
- **display_builder_views** → [modules/display_builder_views](../../modules/display_builder_views/1.x/agent/start.md) —
  a Views display extender + builder screen for Views output.

## Solution docs

- Architecture, plugin types, entities and data flow → [concepts/architecture.md](concepts/architecture.md)
- The HTMX API routes, controllers and access model → [api/routes.md](api/routes.md)
- Profiles, islands, presets and config → [config/profile.md](config/profile.md)
