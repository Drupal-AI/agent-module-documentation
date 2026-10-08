# A11Y: Form Helpers — agent index

Accessibility fixes for Drupal forms: disable HTML5 validation, tie errors to fields via
`aria-describedby`, and set WCAG input-purpose `autocomplete` attributes per widget. Depends on core
`inline_form_errors`. No Drush.

- **Settings (`a11y_form_helpers.settings`), the 3 feature toggles, and how each is applied** →
  [configure/settings.md](configure/settings.md)
- **`AutocompleteAttribute` plugin type — map fields to WCAG input purposes / add your own** →
  [plugins/autocomplete-attribute.md](plugins/autocomplete-attribute.md)
- **Template replacement (`form_element`/`fieldset`) and the render/preprocess wiring** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Config UI `/admin/config/content/a11y_form_helpers` (route `a11y_form_helpers.settings`, perm
  `configure a11y_form_helpers`, `restrict access: true`).
- Config keys (all default TRUE): `features.no_html5_validation`, `features.readable_error_messages`,
  `features.replace_core_templates`.
- Plugin type `autocomplete_attribute` (manager `a11y_form_helpers.autocomplete_attribute`); ships
  `given-name`, `name`.
