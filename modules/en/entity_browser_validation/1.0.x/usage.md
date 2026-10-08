<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Browser Validation makes the Entity Browser entity-reference widget show a red error highlight when its field fails validation, the way core does for standard inputs.

---

Core flags failed form elements (inputs, selects, textareas) with an `error` class, but the Entity Browser widget wrapper has no targetable element, so validation errors did not visually mark it. This module implements `hook_field_widget_single_element_entity_browser_entity_reference_form_alter` to add a `name` attribute to the widget's `details` wrapper (built from the field name and the form's `#parents`), giving the error-flagging mechanism a target, and attaches a small CSS library (`entity_browser_validation/validation`) whose single rule styles `.form-wrapper details.error` in red. There is no configuration, route, permission, service or settings form — enabling the module is the entire setup. It only affects fields that use the Entity Browser "entity reference" widget. Because the highlight is just the same `error` class core uses, the styling can be overridden in a theme. The maintainer notes the feature ideally belongs in Entity Browser itself, which would make this module obsolete.

---

- Highlight a failing Entity Browser widget in red on form validation
- Match core's error styling for entity-reference fields
- Give required Entity Browser fields a visible error state on submit
- Help editors immediately spot which media/reference field failed
- Add a targetable `name` attribute to the entity browser `details` wrapper
- Improve form UX on multi-field content edit forms
- Apply automatically to entity-browser entity-reference widgets, with no per-field setup
- Enable with zero configuration
- Override the red error styling from a custom or sub-theme
- Work alongside any Entity Browser display type (modal, iframe, standalone)
- Flag empty required media fields when a save is rejected
- Reduce editor confusion when a save fails with no visible cause
- Support node, media, taxonomy or any entity form that uses the widget
- Keep the error cue consistent with core field-validation behaviour
- Provide a drop-in fix while waiting for the feature to land in Entity Browser
- Style the highlight to match the site's design system via theme CSS
- Cover both single-value and multi-value entity-reference fields using the widget
- Restyle `.form-wrapper details.error` to change the highlight colour or border
- Remove the module cleanly once Entity Browser adds native error flagging
- Improve accessibility by giving reviewers a clear visual failure indicator
