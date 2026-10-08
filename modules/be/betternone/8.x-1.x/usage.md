Better None improves the default "- None -" empty option on Drupal's options/select field widgets, letting editors move, remove, or rename it per widget in Manage form display.

---

The module implements three hooks (`hook_options_list_alter`, `hook_field_widget_third_party_settings_form`, `hook_field_widget_settings_summary_alter`) and one helper class, `BetterNoneAlterer`. For any widget extending core's `OptionsWidgetBase` it adds a "Better None Option" fieldset (a Position select of First/Last/Remove plus a free-text Label override) to the widget's third-party settings, rewrites the rendered options list to apply that choice under the `_none` key, and reflects the setting in the widget's settings summary. If no explicit setting is saved it defaults to keeping a leading empty option on optional single-value fields and removing it on required or multi-value fields. It is a pure form-display enhancement — no routes, permissions, services, plugins, or config objects of its own; the settings ride along in the entity form display's third-party settings under the `betternone` provider. Core requirement `^8.7.7 || ^9 || ^10 || ^11`.

---
- Replace "- None -" with a custom empty label on a select widget
- Set a friendlier empty prompt such as "Choose a category"
- Move the empty option to the top (First) of a select list
- Move the empty option to the bottom (Last) of a select list
- Remove the empty option entirely from an optional single-value field
- Configure the empty option per field widget in Manage form display
- See the chosen position and label in the widget settings summary
- Apply different empty-option handling on different content types
- Keep an empty option but give it meaningful text
- Adjust the empty option on taxonomy term reference select widgets
- Relabel the empty option on list_string / list_integer fields
- Improve UX on optional single-value entity-reference fields
- Localise the empty-option wording via the label override
- Standardise empty-option text across a bundle's forms
- Reduce editor confusion caused by the terse default "- None -"
- Give an optional field a clearer "not selected" prompt
- Apply per-form-mode empty labels (different form displays)
- Keep the customization scoped to options-based widgets only
- Force-remove a stray empty option on a required-looking field
- Preview the effect from the form display summary line before saving
- Add a leading empty prompt where core would otherwise hide it
