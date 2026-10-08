<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Switch mechanism & plugins

## How the view mode is switched

The switch happens in `EntityViewModeAlterHook` (attribute hook `#[Hook('entity_view_mode_alter')]`):

```php
if ($entity instanceof FieldableEntityInterface) {
  if ($switch_to = $this->viewModeSwitch->getViewModeToSwitchTo($entity, $view_mode)) {
    $view_mode = $switch_to;   // by-reference: changes the mode used to render
  }
}
```

So on every entity render, the `view_mode_switch` service inspects the entity's switch field(s):
if the entity is being displayed in a view mode listed in that field's storage
`origin_view_modes`, and the entity has a chosen value (within `allowed_view_modes`), the active
`$view_mode` is replaced by the chosen one before the entity is built. The stored per-entity
value is a view-mode machine name held in the field.

## Services (all injectable)

| Service id | Interface | Role |
|---|---|---|
| `view_mode_switch` | `ViewModeSwitchInterface` | `getViewModeToSwitchTo($entity, $view_mode)` — the core decision. |
| `view_mode_switch.entity_field_manager` | `Entity\EntityFieldManagerInterface` | Finds the switch fields on an entity/bundle. |
| `view_mode_switch.view_mode_helper` | `ViewModeHelperInterface` | View-mode option/validation helpers. |
| `view_mode_switch.entity_view_mode_delete_form_helper` | `EntityViewModeDeleteFormHelperInterface` | Cleans up references when a view mode is deleted. |

## Other hooks (attribute-based, in `src/Hook/`)

- `EntityViewModePredeleteHook` — reacts when a view mode is deleted (keeps field settings sane).
- `FormEntityViewModeConfirmFormAlterHook` — warns/adjusts the view-mode delete confirm form.
- `FieldTypeCategoryInfoAlterHook` — places the field type in the field UI category.
- `RuntimeRequirementsHook` — adds a status-report (`/admin/reports/status`) check for switch
  fields referencing missing view modes.

## Plugins it ships (implements core/contrib plugin types, defines none of its own)

- Field type `view_mode_switch` (`Plugin/Field/FieldType/ViewModeSwitchItem`).
- Widget `view_mode_switch` (`Plugin/Field/FieldWidget/ViewModeSwitchWidget`).
- Formatters `view_mode_switch_default`, `view_mode_switch_machine_name`.
- Diff field builder `Plugin/diff/Field/ViewModeSwitchFieldBuilder` (Diff module integration).

## What an agent should know

- The effect is purely at render time; it never rewrites stored display config — it just changes
  which view mode core uses for that one entity render.
- `origin_view_modes` (storage) vs `allowed_view_modes` (instance) is the key distinction: origin
  = "which modes I hijack", allowed = "which modes the editor may pick".
- Requires Drupal 11.3+ because it uses attribute-based hook classes and current field APIs.
- No config object of its own beyond the field storage/instance settings; no permissions; no
  Drush.
