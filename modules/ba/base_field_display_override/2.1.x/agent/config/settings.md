<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring base field display overrides

## Install / enable
`drush en base_field_display_override -y`. No dependencies beyond Drupal core; nothing to configure
at install. An empty `config/install/base_field_display_override.overrides.yml` ships (0 bytes), so
the `base_field_display_override.overrides` config object starts with no `display` key.

## The admin form
- **Route:** `base_field_display_override.base_field_display_override_form`
  (`*.routing.yml`), path `/admin/structure/base-field-display-override/manage`.
- **Requirement:** `_permission: 'access administration pages'`; `options._admin_route: TRUE`.
- **Class:** `Form\BaseFieldDisplayOverrideForm extends ConfigFormBase`; `getFormId()` =
  `base_field_display_override_form`; `getEditableConfigNames()` = `['base_field_display_override.overrides']`.
- Menu link "Manage base field display overrides" under *Structure* (`system.admin_structure`),
  weight 99 (`*.links.menu.yml`). Same route is the module's `configure` link (`*.info.yml`).

### buildForm()
Calls `BaseFieldDisplayOverrideManager::getOverridableContentTypes()` for the entity-type list, and
for each type renders a `details` group containing a `fieldset` (`#type => fieldset`, title
"Visibility in entity view displays"). For every base field returned by
`EntityFieldManager::getBaseFieldDefinitions($entityTypeId)` it adds a `radios` element keyed
`display+<entityTypeId>+<fieldMachineName>` with three options:

| Option value | Constant | Meaning |
|---|---|---|
| `hidden`  | `CONFIG_VALUE__DISPLAY__HIDDEN`      | force `setDisplayConfigurable('view', FALSE)` |
| `none`    | `CONFIG_VALUE__DISPLAY__NO_OVERRIDE` | leave the entity type's own declaration |
| `visible` | `CONFIG_VALUE__DISPLAY__VISIBLE`     | force `setDisplayConfigurable('view', TRUE)` |

Default is the stored value from `config->get('display')[$entityTypeId][$fieldKey]`, else `none`.
Radio/label markup is built from static translatable strings and `t()` placeholders
(`@baseFieldName`, `@machineName`, `@description`), which core auto-escapes.

### submitForm()
Iterates `$form_state->getValues()`, splits each key on `+`; only processes keys that split into
exactly 3 parts with `valueType === 'display'` and an entity type present in
`getOverridableContentTypes()` (invalid keys/entity types are skipped). Then:
1. `$config->delete()` — hard-resets the whole `base_field_display_override.overrides` object.
2. `$config->set('display', $valuesToSetInConfig['display'])` and `$config->save()`.
3. `EntityFieldManager::clearCachedFieldDefinitions()` — forces base-field definitions to rebuild
   so the override takes effect on the next request without a full cache clear.

Because submit rebuilds config from scratch, removing/renaming a field simply drops out of config.

## Config object shape
`base_field_display_override.overrides` (constant `CONFIG__OVERRIDES` on the interface):

```yaml
display:
  node:
    created: visible
    changed: hidden
    uid: none
  media:
    created: visible
```

No `config/schema/` is shipped, so this config is schema-less (no typed-config validation).

## Apply mechanism — hook_entity_base_field_info_alter()
In `base_field_display_override.module`. For the entity type being built it reads
`config('base_field_display_override.overrides')->get('display')[$entity_type->id()]`; returns early
if there is no entry. For each `<fieldKey> => <state>` it skips fields not present in `$fields`
(handles removed fields), then:
- `visible` → `$fields[$fieldKey]->setDisplayConfigurable('view', TRUE)`
- `hidden`  → `$fields[$fieldKey]->setDisplayConfigurable('view', FALSE)`
- `none`/anything else → no change.

This only alters `view`-display configurability. It does not touch form display, default display
options, or field access — a field made "visible" still appears in Field UI only, and its actual
rendering remains subject to the field's normal access checks.

## Service API — BaseFieldDisplayOverrideManager
Service id `base_field_display_override.manager`, class
`Service\BaseFieldDisplayOverrideManager` (implements `BaseFieldDisplayOverrideManagerInterface`),
constructed with `@entity_field.manager` and `@entity_type.manager`.

- `getOverridableContentTypes(): EntityTypeInterface[]` — every entity type whose definition has a
  `field_ui_base_route` and `hasViewBuilderClass()` (i.e. Field-UI-manageable content entity types),
  keyed by entity type id.
- `getEntityTypeOriginalFieldDefinitions(ContentEntityTypeInterface $entityType)` — returns the
  *original* (unprocessed) base field definitions by calling the entity class's static
  `baseFieldDefinitions()` (directly for a `FieldableEntityInterface`, else via
  `getOriginalClass()` if that class has the method); returns `NULL` when unavailable. Provided by
  the interface but not called by the shipped form/hook — available for programmatic use.

## Operating notes
- After saving, overrides apply immediately (field-definition cache is cleared in submit). If you
  edit `base_field_display_override.overrides` via config import/CLI, run `drush cr` (or clear field
  definitions) so `hook_entity_base_field_info_alter()` re-runs.
- To make a base field actually show up on an entity view, mark it `visible` here, then go to the
  entity type's *Manage display* and place/format the field as usual.
