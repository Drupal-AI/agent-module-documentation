<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugins — form_display_visibility

## Plugin type
- Manager service: `plugin.manager.form_display_visibility_condition`
- Namespace: `Drupal\<module>\Plugin\FormDisplayVisibilityCondition`
- Interface: `FormDisplayVisibilityConditionInterface`
- Annotation: `@FormDisplayVisibilityCondition(id, label, description)`

## Interface methods
- `buildForm()` — returns the settings form fragment shown under the widget's "Visibility Conditions" details.
- `applyCondition()` — returns an `AccessResult` (`allowed` / `forbidden` / `neutral`) for the current user.
- `displaySummary()` — short string shown in the Manage form display summary.

## How enforcement works
`form_display_visibility_field_widget_complete_form_alter()` instantiates every condition with the field's settings, `andIf()`s all their `applyCondition()` results, and sets:
```php
$field_widget_complete_form['widget']['#access'] = !$access->isForbidden();
```
Return `AccessResult::neutral()` when your condition is disabled so it does not affect the AND.

## Bundled conditions
- `access_by_role` (`AccessByRole`): allowed if the current user has any selected role, else forbidden; neutral when disabled.
- `access_by_permission` (`AccessByPermission`): allowed if the user has the chosen permission, else forbidden; neutral when disabled.

## Adding your own
1. Create a plugin class implementing `FormDisplayVisibilityConditionInterface` (extend `PluginBase`, add `ContainerFactoryPluginInterface` if you need services).
2. Read/write settings under `field_settings.third_party_settings.form_display_visibility.conditions.<your_id>`.
3. Return an `AccessResult` from `applyCondition()`.
