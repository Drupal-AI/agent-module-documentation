<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the `entity_extra_field` config entity

## The config entity

`@ConfigEntityType id="entity_extra_field"`, config prefix `extra_field`, so config names are `entity_extra_field.extra_field.<entity_type>.<bundle>.<name>`. `admin_permission = administer entity extra field`, `translatable = TRUE`. Handlers: add/edit form `EntityExtraFieldForm`, delete `EntityExtraFieldFormDelete`, list builder `EntityExtraFieldListBuilder`. The entity id is derived: `<base_entity_type_id>.<base_bundle_type_id>.<name>`.

### Exported properties (schema `entity_extra_field.extra_field.*.*.*`)

| Property | Meaning |
|---|---|
| `id` | `<entity_type>.<bundle>.<name>` |
| `label` | admin label |
| `display_label` | bool — show the label on output |
| `name` | machine name (the pseudo-field name) |
| `description` | description text |
| `base_entity_type_id` | host entity type (e.g. `node`) |
| `base_bundle_type_id` | host bundle (e.g. `article`) |
| `field_type_id` | chosen `ExtraFieldType` plugin id (`block`/`views`/`token`/`twig`/`entity_link`/`component`) |
| `field_type_config` | that plugin's config (`entity_extra_field.plugin.<field_type_id>`) |
| `field_type_condition` | sequence of core condition plugins (`condition.plugin.<id>`) |
| `field_conditions_all_pass` | bool — AND (all) vs OR (any) for conditions |
| `display` | mapping with `type`: `view` or `form` |

## How pseudo-fields are registered & rendered (`entity_extra_field.module`)

- `hook_entity_extra_field_info()` loads every `entity_extra_field` config entity and registers a pseudo field under `[$entity_type][$bundle][$display_type][$field_name]` (display type `view` maps to `display`, `form` stays `form`), `visible => FALSE` by default so you place it on *Manage display* / *Manage form display*.
- `hook_entity_view()` → `entity_extra_field_display('view', ...)` and `hook_form_alter()` (for `ContentEntityFormInterface`) → `entity_extra_field_display('form', ...)`.
- `entity_extra_field_display()` queries config entities matching the display type + entity type + bundle (`accessCheck(FALSE)`), and for each: skips it unless the display has the component (`hasDisplayComponent`) and its conditions pass (`hasConditionsBeenMet`), then renders `EntityExtraField::build()` → the field-type plugin's `build()`. Output is wrapped with `#theme => 'entity_extra_field'`, an optional label, and cache tags `entity_extra_field` + `entity_extra_field:<type>.<entity_type>.<bundle>`; empty content is skipped.
- Theme hook `entity_extra_field` (template `entity-extra-field.html.twig`) with rich `theme_suggestions` by field name / entity type / bundle / view mode.

## Conditions

`field_type_condition` holds core Condition plugin configs. `EntityExtraField::hasConditionsBeenMet($contexts, $all_must_pass)` instantiates each condition, applies runtime contexts (including an `entity_extra_field.target_entity` EntityContext for the host entity), and evaluates. `field_conditions_all_pass` chooses AND vs OR. Condition cache contexts/tags are merged into the field's cacheability.

## Where to configure (UI)

The base module has **no admin route of its own** (`configure` is null). Enable **entity_extra_field_ui** (`drush en entity_extra_field_ui -y`, requires `field_ui`) to get, per bundle:
- Collection: `/admin/structure/<...>/manage/<bundle>/extra-fields`
- Add / edit / delete forms (routes `entity.<entity_type>.extra_fields[.add|.edit|.delete]`)
- The "Manage extra fields" entity operation.

After creating an extra field, position it on *Manage display* (`/admin/structure/types/manage/<bundle>/display`) or *Manage form display* (`.../form-display`). The UI submodule can be safely disabled in production once fields exist — the fields keep working (per README).

## Permission & report

- Permission: `administer entity extra field` (`entity_extra_field.permissions.yml`) — gates all add/edit/delete, the operation, and the report.
- Report route `entity_extra_field.reports` → `/admin/reports/extra-fields` (`ExtraFieldReportController::report`) lists all configured extra fields.

## Programmatic creation

```php
\Drupal::entityTypeManager()->getStorage('entity_extra_field')->create([
  'name' => 'related_view',
  'label' => 'Related content',
  'display_label' => FALSE,
  'base_entity_type_id' => 'node',
  'base_bundle_type_id' => 'article',
  'field_type_id' => 'views',
  'field_type_config' => [
    'view_name' => 'related_content',
    'display' => 'block_1',
    'arguments' => '[node:nid]',
    'offset' => 0,
    'view_use_title' => FALSE,
  ],
  'display' => ['type' => 'view'],
])->save();
// Then enable the component in core.entity_view_display.node.article.default.
```
