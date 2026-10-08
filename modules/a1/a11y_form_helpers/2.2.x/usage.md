A11Y: Form Helpers makes Drupal forms more accessible: it disables browser HTML5 validation in favour of Drupal's own messages, wires form errors to fields with `aria-describedby` for screen readers, and lets you assign WCAG input-purpose `autocomplete` attributes to field widgets.

---

Three independently toggleable features (config `a11y_form_helpers.settings`, key `features.*`, all on by
default): (1) `no_html5_validation` adds `novalidate` to every form via `hook_form_alter`, so validation
falls to Drupal/Inline Form Errors rather than inconsistent browser bubbles; (2) `readable_error_messages`
makes a `#pre_render` on every render element (added by `A11yFormHelpersRenderElement::alterElementInfo`
through `hook_element_info_alter`) set `aria-describedby` to the element's `<id>--errormessage`, and
preprocess hooks for `form_element`/`fieldset` expose `errors` + `errormessage_id` to the templates so the
error text is programmatically associated with the input; (3) `replace_core_templates` repoints the core
`form_element` and `fieldset` theme registry entries at this module's own Twig templates (variants for
`claro`, `classy`, `stable`, `system`) so the error markup renders. The module also defines an
`AutocompleteAttribute` plugin type (manager `a11y_form_helpers.autocomplete_attribute`) whose plugins map
to WCAG 2.1 input purposes (ships `given-name`, `name`); via
`hook_field_widget_third_party_settings_form` you set a "Purpose" per field widget in Manage form display,
and `hook_field_widget_form_alter` applies the matching `autocomplete` HTML attribute to the widget.
Requires core Inline Form Errors. Settings page at `/admin/config/content/a11y_form_helpers` behind the
`configure a11y_form_helpers` permission (restricted). No Drush. The maintainer notes this is a stopgap:
features may be dropped as Drupal core absorbs them.

---

- Turn off native browser HTML5 validation so all validation uses accessible Drupal messages.
- Associate each field's error message with the input via `aria-describedby` for screen-reader users.
- Ship accessible `form-element.html.twig` / `fieldset.html.twig` overrides matching your base theme.
- Add WCAG input-purpose `autocomplete` attributes (e.g. `given-name`) to text field widgets.
- Improve autofill and cognitive-accessibility by declaring field purposes on a registration form.
- Set the "Purpose" of a field per widget from Manage form display, no code required.
- Enable only the readable-error-message feature and leave HTML5 validation untouched.
- Enable only `novalidate` behavior site-wide without replacing templates.
- Keep error markup consistent across Claro, Classy, Stable and System-based themes.
- Provide a11y-friendly forms on a Webform-based site (works with core and contrib field widgets).
- Meet WCAG 1.3.5 (Identify Input Purpose) by mapping fields to input purposes.
- Meet WCAG 3.3.1 (Error Identification) by tying errors to their fields semantically.
- Extend the set of supported input purposes by adding your own `AutocompleteAttribute` plugin.
- Restrict which widget field types a purpose applies to via the plugin's `field_types`.
- Gate configuration behind a dedicated restricted permission for site builders.
- Toggle each accessibility feature on or off independently as core catches up.
- Roll the module out with zero configuration (all three features default to enabled).
- Audit-friendly: centralizes common form accessibility fixes in one module.
- Apply readable errors to custom render elements automatically (pre_render added to all elements).
- Fall back to the module's `system` templates when no theme-specific variant matches.
