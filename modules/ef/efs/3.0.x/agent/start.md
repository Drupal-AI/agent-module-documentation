<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# Extra Field Suite (efs) — agent index

A **plugin type for extra (pseudo-)fields** that look and behave like real fields on entity
**view and form displays** but store no data. Site builders place them from the Field UI; developers
add new ones as plugins. Package `Fields`. License GPL-3.0-or-later. Core `^10 || ^11`. Version
**3.0.x** (installed = dev branch). No composer requirements, **no declared module dependencies** in
`efs.info.yml` — but **Field UI is required in practice** (the base plugin extends
`field_ui`'s `EntityDisplayFormBase` and `RouteSubscriber` decorates Field UI routes); `views` and
`token` are needed only by the stock View / Tokenizer plugins. **Conflicts with `drupal/extra_field`**
(`composer.json` `conflict`) — do not enable both.

## What it provides

- A plugin type **`extra_field_formatter`** — annotation `@ExtraFieldFormatter`
  (`src/Annotation/ExtraFieldFormatter.php`), interface
  `ExtraFieldFormatterPluginInterface`, base class `ExtraFieldFormatterPluginBase`, manager service
  **`plugin.manager.efs.formatters`** (`ExtraFieldFormatterPluginManager`), discovery dir
  `src/Plugin/efs/Formatter/`, alter hook `hook_extra_field_formatter_info_alter`.
- A config entity **`extra_field`** (`src/Entity/ExtraField.php`) that stores one placement
  (entity type + bundle + context + mode + field name + plugin + weight + settings).
- Six stock plugins: `entity_label`, `field_mirror`, `entityreference_field`, `view`,
  `tokenizer_wysiwyg`, `entity_form_display`.
- Display integration via `hook_entity_extra_field_info()`, `hook_entity_view_alter()`,
  `hook_form_alter()` and Field-UI form alters (`efs.module` + `includes/field_ui.inc`).
- Services: route subscriber `efs.subscriber`, param converter `efs.param_converter`, form builder
  `efs.entity.form_builder`. A Layout Builder override block `ExtraFieldBlock`.

## Solution docs

- **The plugin type — annotation, interface, base class, manager, and how to write a plugin** →
  [api/plugin-type.md](api/plugin-type.md)
- **The `extra_field` config entity, config schema, Field UI integration, hooks, routes** →
  [config/extra-fields.md](config/extra-fields.md)
- **The six stock plugins and their settings** →
  [plugins/stock.md](plugins/stock.md)

## Install / operate

- `drush en efs` (also enable `field_ui`; enable `views`/`token` for those stock plugins).
  `efs_install()` sets module weight to **999** so `efs_entity_view_alter()` runs last.
- No settings form / no permissions of its own. The `extra_field` entity's `admin_permission` is
  `administer site configuration`, but its collection/CRUD routes are hard-disabled
  (`ExtraFieldHtmlRouteProvider` sets `_access = FALSE` on all but `delete_form`); extra fields are
  created/edited/deleted from the **Manage display / Manage form display** screens instead, gated by
  core's `administer <entity_type> display` / `administer <entity_type> form display` permissions.
