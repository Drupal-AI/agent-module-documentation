<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Themable Forms adds fine-grained Twig theme suggestions for form elements and their labels, and stamps every form element with the `#form_id` of the form it belongs to, so you can theme a form element differently per element type, per form, or per element-type-within-a-form without any custom PHP.

---

The module is four hook implementations and no configuration. `hook_form_alter()` walks the whole form render array recursively and attaches `#form_id` (the form's id) to every child element. `hook_theme_suggestions_form_element()` then offers extra Twig template suggestions for the `form_element` theme hook: `form_element__type__<element_type>`, `form_element__form_id__<form_id>`, and `form_element__<form_id>__<element_type>`. `hook_theme_suggestions_form_element_label()` does the same for the `form_element_label` theme hook (`form_element_label__type__<type>`, `form_element_label__form-id__<form_id>`, `form_element_label__<form_id>__<type>`), and `hook_preprocess_form_element()` copies `#form_id` and `#form_element_type` onto the label element so those label suggestions have the data they need. Because the suggestions are standard Drupal theme-hook suggestions, you act on them purely by adding matching Twig templates (e.g. `form-element--form-id--node-article-form.html.twig`) to your theme; the more specific the suggestion, the higher its priority. There is no settings form, no configure route (`configure: null`), no permissions, no config schema, and no services — enabling the module simply makes the suggestions available site-wide.

---

- Theme all text fields on one specific form differently (e.g. wrap the article node form's inputs in custom markup) with `form-element--form-id--node-article-form.html.twig`.
- Give every checkbox on the site a custom wrapper via `form-element--type--checkbox.html.twig`.
- Style just the search block's textfield without affecting other textfields, using `form-element--<form-id>--textfield.html.twig`.
- Add per-form BEM/utility classes to form-element wrappers in a template override.
- Customize the markup of form-element **labels** on a particular form via `form-element-label--form-id--<form_id>.html.twig`.
- Restyle labels for a single element type (e.g. radios) site-wide with `form-element-label--type--radios.html.twig`.
- Build a design-system form component library where each field type maps to its own Twig template.
- Differentiate the login form's fields from registration form fields purely in the theme layer.
- Add form-specific wrappers for a multi-step / wizard form so each step's elements look distinct.
- Theme Webform or Contact form elements separately from node-form elements by targeting their form ids.
- Read `#form_id` inside any form-element template to branch markup with Twig logic.
- Apply special styling to elements on an exposed Views filter form without touching other forms.
- Provide accessible, form-specific label markup (extra hint spans, icons) via label suggestions.
- Prototype form redesigns in the theme without patching the module or writing render-element plugins.
- Keep form theming in Twig (designer-friendly) instead of PHP `hook_form_alter` render tweaks.
- Override the wrapper for a single element type on a single form (most specific suggestion wins).
- Standardize form markup across a multisite by shipping the templates in a base theme.
- Target admin forms' elements separately from front-end forms using their distinct form ids.
- Add data attributes derived from `#form_id` to elements for JS hooks, all in the template.
- Migrate legacy per-form CSS to clean, suggestion-scoped templates.
- Inspect a form's attached `#form_id` values to discover which suggestions are available for it.
