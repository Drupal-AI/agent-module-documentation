<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Field Widget Actions (eca_field_widget_actions) — agent index

Bridges **ECA** to the **Field Widget Actions** module: a Field Widget Actions button on an entity
form fires an **ECA event**, an ECA model computes a value, and that value is offered as a
suggestion or written straight into the widget. Package `ECA`. Depends on `eca` (`^2 || ^3`) and
`field_widget_actions` (`^1`). Core `^11 || ^12`. PHP `>=8.1`. License GPL-2.0-or-later.
Installed release 1.0.0.

No routes, no permissions, no Drush, no `.services.yml`, no `config/install`. Everything is plugins
+ one attribute-based hook class + a config schema. All access is inherited from the entity edit
form the button lives on.

## What it provides
- **ECA event** `eca_field_widget_actions:eca_field_widget` ("ECA Field Widget"), event name
  `eca_field_widget_actions.field_widget_action`, event class `FieldWidgetEvent`. Tokens: `entity`,
  `field_name`, `field_key`. One config key: `fill_strategies` ("Restrict by widget kind").
  → [plugins/event.md](plugins/event.md)
- **ECA action** `eca_set_field_widget_value` ("Set field widget value") — the model's way to return
  the value; config keys `widget_value`, `use_yaml`. → [plugins/action.md](plugins/action.md)
- **FieldWidgetAction plugin** `eca_field_widget` (derived one-per-model) — the button itself, its
  `direct_fill` setting, the direct-fill/suggestion/compound AJAX logic, the deriver, the widget/
  field-type catalog (`FieldWidgetSupport`), and the cache-clear hook.
  → [plugins/field-widget-action.md](plugins/field-widget-action.md)

## Key classes (src/)
- `Plugin/ECA/Event/FieldWidgetActionsEvent.php` (+ `FieldWidgetActionsEventDeriver.php`)
- `Plugin/Action/SetWidgetValue.php`
- `Plugin/FieldWidgetAction/EcaFieldWidget.php` (+ `EcaFieldWidgetDeriver.php`)
- `Event/FieldWidgetEvent.php`, `FieldWidgetActionsEvents.php`, `FieldWidgetSupport.php`
- `Hook/EcaEntityHooks.php` (attribute hooks `entity_insert` / `entity_update`)
- `config/schema/eca_field_widget_actions.schema.yml`
