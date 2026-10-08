<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Layout (field_layout) — agent index

Adds a **layout selector** to entity **view displays** and **form displays** so configurable
fields are arranged into the **regions of a Layout Discovery layout plugin** (one/two/three
column, or any discovered layout) instead of a flat list. Package `Fields`. Depends only on core
**`layout_discovery`**. Core requirement **`>11.3`**. License GPL-2.0-or-later. Version 2.0.0.
Contrib continuation of the removed experimental core module. **No routes, no permissions, no
services, no Drush.**

- **What is stored, config schema, install/uninstall behavior, Layout Builder interop** →
  [config/layout-settings.md](config/layout-settings.md)
- **Entity display classes, the display trait API, `FieldLayoutBuilder`, the form trait, hooks** →
  [api/display-and-builder.md](api/display-and-builder.md)

## What it actually is

- Swaps the entity classes for `entity_view_display` and `entity_form_display` (via
  `hook_entity_type_alter`) to `FieldLayoutEntityViewDisplay` / `FieldLayoutEntityFormDisplay`
  (`src/Entity/`), both implementing `EntityDisplayWithLayoutInterface`
  (`src/Display/`) through the shared `FieldLayoutEntityDisplayTrait`.
- When **Field UI** is installed, it also swaps the display edit forms to
  `FieldLayoutEntityViewDisplayEditForm` / `FieldLayoutEntityFormDisplayEditForm`
  (`src/Form/`, both `@internal`), which use `FieldLayoutEntityDisplayFormTrait` to add the
  **"Layout settings"** fieldset (layout `<select>` + the layout plugin's own config form) and to
  make the field **Region** column reflect the selected layout's regions.
- The layout ID + settings are stored as **third-party settings** on the display config entity
  under the `field_layout` provider (`id`, `settings`); no separate config object, **no settings
  route** (`configure` is null).

## Mechanism (from source)

- Rendering is done by `FieldLayoutBuilder` (`src/FieldLayoutBuilder.php`, a class-resolved
  service-less helper). `hook_entity_view_alter` → `buildView()` groups fields into region
  arrays and replaces them with `$build['_field_layout'] = $layout->build($regions)`.
  `hook_form_alter` → `buildForm()` assigns each field a `#group` pointing at its region so form
  structure and `hook_form_alter` are preserved.
- `getFields()` only touches components whose display is **configurable** and that are present in
  the build; extra fields and non-configurable displays are left alone.
- `hook_modules_installed`: if `layout_builder` is enabled, existing field-layout displays are
  converted into Layout Builder sections (`LayoutBuilderEntityViewDisplay` +
  `Section`). Hooks live in `src/Hook/FieldLayoutHooks.php` (attribute `#[Hook]` based).

## Config / schema

- `provides_config_schema: true` — `config/schema/field_layout.schema.yml` defines
  `field_layout.third_party_settings` (`id` string, `settings` = `layout_plugin.settings.[id]`)
  attached to `core.entity_view_display.*` and `core.entity_form_display.*` third-party settings.
- No `config/install/*`. `field_layout.services.yml` only sets the parameter
  `field_layout.skip_procedural_hook_scan: true` (all hooks are OOP).

## Install / uninstall

- `field_layout_install()` calls `ensureLayout()` on every view/form display (defaults to
  `layout_onecol`) and invalidates the `rendered` cache.
- `field_layout_uninstall()` resets every display to `layout_onecol` to approximate no-layout,
  then invalidates the `rendered` cache.
