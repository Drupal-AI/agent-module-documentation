<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Toggle Switch Webform (css_toggle_switch_webform) — agent index

Submodule of **css_toggle_switch** that surfaces the `toggle_switch` element in **Webform**.
Package `Field`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.7.
Dependencies: **`webform:webform`** (declared) and the base **`css_toggle_switch`** module (the
element/plugins it extends). No routes, permissions, services, config objects, or Drush.

- **The two Webform elements, their settings and mechanism** →
  [webform/elements.md](webform/elements.md)
- Base module (the underlying `toggle_switch` render element) →
  [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md)

## What it provides (from source)

- **`Plugin/WebformElement/ToggleSwitch`** — `@WebformElement(id="toggle_switch", label="Toggle
  Switch", category="Options elements")`, extends Webform's `OptionsBase`/`Radios`. Adds default
  properties `toggle_on__attributes`, `toggle_type` (`switch-toggle`), `toggle_classes`,
  `wrapper_type=container`; renders the three config fields on the element form; in `prepare()`
  swaps `#type` to `radios` then to `toggle_switch` and normalises `#toggle_on__attributes` to a
  `['class' => [...]]` array via `preg_split`.
- **`Plugin/WebformElement/ToggleSwitchEntity`** — `@WebformElement(id="toggle_switch_entity",
  label="Entity Toggle Switch", category="Entity reference elements")`, extends the above and
  implements `WebformElementEntityOptionsInterface` using `WebformEntityReferenceTrait` +
  `WebformEntityOptionsTrait` (single-entity reference via the switch).
- **`Element/ToggleSwitchEntity`** — `@FormElement("toggle_switch_entity")`, extends the base
  module's `Drupal\css_toggle_switch\Element\ToggleSwitch` and uses `WebformEntityTrait`;
  `processToggleSwitch()` calls `static::setOptions($element)` (populate entity options) before
  delegating to the parent process.

Purely a Form API / Webform element bridge — presentational, no request-handled endpoints or
access logic of its own.
