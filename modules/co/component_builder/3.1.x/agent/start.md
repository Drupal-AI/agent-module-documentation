<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Builder — agent index

info.yml name: **Component Builder** (`component_builder`), description "Provides a component builder module."
A **page-building / structured-content** tool: editors compose pages from a library of reusable **components**,
each saved as ordinary Drupal content entities (Fields/Views/Search API/multilingual all keep working).
Version **3.1.0**, core `^10 || ^11`. Depends on `entity` and `inline_entity_form`.
Configure route: `component_builder.settings` (`/admin/structure/component-builder/settings`).

## Model in one paragraph

A **component type** is a plugin (`@ComponentBuilder` annotation, manager `plugin.manager.component_builder`,
base `ComponentBuilderBase`, ~59 built-in plugins in `src/Plugin/ComponentBuilder/`). Activating a type on the
settings form imports config (a `component_types` taxonomy term + field storage/config + a `component_item`
bundle) from the plugin's shipped `components/component_<id>/component_<id>.yml`. Content is then two content
entity types: **`component_wrapper`** (references a component type, holds header/footer/image + child
references, assembled with Inline Entity Form) and **`component_item`** (the leaf field data, bundled by the
`component_item_type` config entity). A host content type gets a `component_wrapper` entity-reference field
(added via the "Add component field" form), and each wrapper renders through a **module-provided Twig
template** (`hook_theme` registers one theme hook per component; templates live in
`components/component_<id>/templates/` or the base `templates/` dir — they are shipped files, not user input).

## Subdocs

- **Entity types, base fields, permissions, unpublished access** → [entities.md](entities.md)
- **The `@ComponentBuilder` plugin type, built-in components, adding a custom one, config import** → [components.md](components.md)
- **`component_builder_toolbar` submodule (experimental drag-and-drop builder), its routes/forms** → [toolbar.md](toolbar.md)

## Key facts

- **Entity types**: `component_wrapper` (base_table `component_wrapper`, revisionable, translatable),
  `component_item` (bundled by `component_item_type`, revisionable, translatable). Both use the `entity`
  module's `EntityAccessControlHandler` + `EntityPermissionProvider`, `permission_granularity = "bundle"`,
  `admin_permission` `administer component_wrapper` / `administer component_item`.
- **Own permission**: `view any unpublished component_item` (`component_builder.permissions.yml`). All other
  access is the per-bundle create/update/delete/view permissions synthesized by the `entity` module.
- **Settings form** (`ComponentItemSettingsForm`, route `component_builder.settings`, perm
  `administer Component Item entity`): checkboxes to activate component types; on first save it batch-imports
  the selected types and grants `view component_wrapper` + `view component_item` to the anonymous and
  authenticated roles (so components render on public pages).
- **Add component field** (`ComponentFieldConfigForm`, route `component_builder.config_field`, perm
  `administer site configuration`): attaches a `component_wrapper` reference field to a host bundle.
- **Config**: `component_builder.settings` (`components:` — activated set). Config schema provided.
- **Rendering** (`component_builder.module`): `template_preprocess_component_wrapper` /
  `_component_item`, dynamic `hook_theme`, `hook_theme_suggestions`, `hook_library_info_alter`.
  `field_header` / `field_footer` (string_long base fields) render via `#markup`. A wrapper with
  `display_in_region` set is injected into a theme region on `entity.node.canonical` (see
  `component_builder_preprocess_page` / `hook_entity_view`).
- **Services**: `plugin.manager.component_builder`, `component_builder.helper` (finds host fields
  referencing components), `component_builder.import_config_component`, `component_builder.breadcrumb`.
- **Submodule**: `component_builder_toolbar` (lifecycle experimental) — see [toolbar.md](toolbar.md).
- **Bundled library**: Select2 (`libraries/select2/`, MIT) used in builder forms.

## Who authors components

Component content is authored as **entity field data** through the per-bundle
create/update permissions on `component_wrapper` / `component_item` (or `administer component_wrapper` /
`administer component_item`); the toolbar's inline builder is reached on a host entity's canonical URL and is
gated by that host entity's **`.update`** access. Component **templates** are Twig files shipped by
`component_builder` (or by a provider module that defines its own component plugin) — there is no user-authored
Twig. Site builders wire component types and fields with `administer site configuration`.
