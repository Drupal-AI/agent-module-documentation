<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable HTML5 validation adds the `novalidate` attribute to every form on the site so the browser's built-in HTML5 client-side validation (the pop-up bubbles on `required`, `type="email"`, `pattern`, `maxlength`, etc.) is turned off and Drupal's own server-side validation handles everything instead.

---

The whole module is a single `hook_form_alter()` implementation that unconditionally sets `$form['#attributes']['novalidate'] = 'novalidate'` on every form it is passed. When Drupal renders the `<form>` element, that attribute tells the browser not to run native HTML5 constraint validation before submit, so users never see the browser's built-in validation tooltips and the form always reaches Drupal's PHP-side `#element_validate` / `validateForm()` logic. There is no settings form, no configure route (`configure` is null), no permissions, no config schema, no services, and no per-form targeting — it is all-or-nothing and global. It applies equally to admin forms, node edit forms, the login form, Views exposed filters, Webform, and any custom form. To exclude a specific form you must implement your own `hook_form_FORM_ID_alter()` that unsets the attribute again. Because the effect is purely a rendered HTML attribute, it changes nothing about stored data or server-side validation behavior.

---

- Turn off the browser's native "Please fill out this field" bubble on required fields site-wide so all validation goes through Drupal.
- Prevent HTML5 `type="email"` / `type="url"` browser validation from blocking submission before Drupal validates.
- Stop the browser from silently focusing/scrolling to an invalid field on multi-step or long forms.
- Let editors save a partially complete node edit form and rely on Drupal's own required-field messages instead of browser popups.
- Provide a consistent, themeable validation message experience (Drupal messages) instead of inconsistent per-browser HTML5 tooltips.
- Avoid HTML5 `pattern` mismatches on fields where the pattern is stricter than the server-side rule.
- Work around browser validation that rejects values Drupal would actually accept (e.g. locale-specific number formats).
- Make AJAX-driven forms behave predictably by removing native validation that fights with partial submits.
- Support accessibility workflows that need server-rendered error summaries rather than transient browser bubbles.
- Disable HTML5 validation on the user login/registration forms for a uniform error style.
- Keep Views exposed filter forms from triggering browser validation on typed filter inputs.
- Ensure Webform and Contact form submissions reach Drupal validation for custom handlers.
- Standardize form behavior across Chrome, Firefox and Safari, which each render HTML5 validation differently.
- Let a "Save as draft" button bypass browser `required` enforcement without extra `formnovalidate` markup on the button.
- Remove native validation that interferes with conditional-fields / `#states` visibility logic.
- Provide a quick site-wide fix while a theme's custom validation UX is being built.
- Debug server-side validation by guaranteeing the request always hits Drupal even with "invalid" input.
- Prevent duplicate validation messaging (browser tooltip + Drupal message) confusing content editors.
- Allow copy-paste of values that the browser would otherwise reject before submit.
- Uninstall the module to instantly restore default HTML5 validation everywhere (no leftover config).
