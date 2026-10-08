<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform elements: `toggle_switch` and `toggle_switch_entity`

Enable with `drush en css_toggle_switch_webform` (pulls in `webform` and the base
`css_toggle_switch`). Two elements then appear in the Webform element picker.

## `toggle_switch` — "Toggle Switch"

`modules/css_toggle_switch_webform/src/Plugin/WebformElement/ToggleSwitch.php`,
`@WebformElement(id="toggle_switch", category="Options elements")`, extends
`Drupal\webform\Plugin\WebformElement\Radios`.

- **Default properties** (`getDefaultProperties()`): `toggle_on__attributes = ''`,
  `toggle_type = 'switch-toggle'`, `toggle_classes = ''`, `wrapper_type = 'container'`, plus
  `OptionsBase::getDefaultProperties()`.
- **Config form** (`form()`): adds under `options`:
  - `toggle_type` — required select, `switch-light` ("Light") / `switch-toggle` ("Toggle").
  - `toggle_classes` — textfield, space-separated CSS classes controlling the switch behaviour.
  - `toggle_on__attributes` — textfield, class(es) for the "on" indicator.
- **`prepare()`**: sets `#type = 'radios'`, calls `parent::prepare()`, then sets
  `#type = 'toggle_switch'`. If `#toggle_on__attributes` is a non-empty string it is
  `preg_split` on whitespace into `['class' => [...]]` (or `[]`).
- **`getElementInfoDefaultProperty()`**: reads defaults from the `toggle_switch` element info
  (`$this->elementInfo->getInfoProperty('toggle_switch', $property_name, NULL)`).

The submitted value is a single option key, exactly like a Webform radios element.

## `toggle_switch_entity` — "Entity Toggle Switch"

`.../WebformElement/ToggleSwitchEntity.php`, `@WebformElement(id="toggle_switch_entity",
category="Entity reference elements")`, extends `ToggleSwitch` and implements
`WebformElementEntityOptionsInterface` via `WebformEntityReferenceTrait` +
`WebformEntityOptionsTrait`. Renders a **single** entity-reference selection with the switch UI;
options are the referenced entities.

Its render element is `Element/ToggleSwitchEntity` (`@FormElement("toggle_switch_entity")`), which
extends the base module's `ToggleSwitch` and overrides `processToggleSwitch()` to call
`static::setOptions($element)` (from `WebformEntityTrait`) before running the parent process, so
the entity options are populated before the switch is expanded.

## Notes

- Both elements are thin wrappers over the base `toggle_switch` render element — styling/behaviour
  come from the same library classes (see the base module's
  [elements/toggle-switch.md](../../../../1.0.x/agent/elements/toggle-switch.md)).
- All three settings (`toggle_type`, `toggle_classes`, `toggle_on__attributes`) are set by the
  form builder in the Webform element edit UI and rendered as element class attributes.
