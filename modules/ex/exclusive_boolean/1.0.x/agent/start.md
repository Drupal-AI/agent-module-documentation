<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclusive Boolean (exclusive_boolean) — agent index

Adds an **"exclusive" option** to **boolean fields on node bundles**: when the field is checked on one
node and saved, it is automatically **unchecked on every other node of the same content type**, so at most
one node ever holds the flag (single "featured"/"default"/"primary"). Package `Custom`. Depends on core
**`field`** and **`node`**. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. Version **1.0.3** (dir `1.0.x`).

- **Enabling it on a field, the third-party setting, and the on-form notice** →
  [fields/configuration.md](fields/configuration.md)
- **The save-time enforcement mechanism, hooks and service** →
  [api/enforcement.md](api/enforcement.md)

## What it actually is

- **No** routes, permissions, plugins, entities, Drush commands, config objects or config schema. It ships
  one service and one OO hook class only.
- Service **`exclusive_boolean.hooks`** → `Drupal\exclusive_boolean\Hook\ExclusiveBooleanHooks`
  (`exclusive_boolean.services.yml`, `autowire: true`, constructor takes `entity_type.manager`).
- Hooks are declared with `#[Hook(...)]` attributes on that class; `exclusive_boolean.module` keeps thin
  `#[LegacyHook]` procedural wrappers that delegate to the service (Drupal 11 hook style).
- The opt-in flag is a **third-party setting** on the `field.field.*` (FieldConfig) entity, namespace
  `exclusive_boolean`, key `exclusive` (bool, default FALSE). No config schema file ships for it.

## Scope limits (from source)

- Only **node** entities and only **boolean** field types are ever processed. Fields on paragraphs, users,
  media, blocks or any non-node entity, and non-boolean fields, are ignored everywhere.
- Enforcement is **per content type (bundle) + per field**: it only clears the same field on other nodes of
  the **same** bundle.
- The config option UI appears only on boolean node fields' **field config edit form**
  (`field_config_edit_form`).

## Hooks provided (all on `ExclusiveBooleanHooks`)

- `hook_entity_presave` → `entityPresave()` — the enforcement (auto-uncheck others).
- `hook_field_widget_single_element_form_alter` / `hook_field_widget_form_alter` →
  `addWidgetDescription()` — inline notice under the checkbox on node forms.
- `hook_form_alter` + `hook_form_field_config_edit_form_alter` → `addExclusiveOption()` — the "Make this
  field exclusive" checkbox in the field's Third-party settings.
- Entity builder `exclusive_boolean_field_config_entity_builder` → `fieldConfigEntityBuilder()` — persists
  the setting.
