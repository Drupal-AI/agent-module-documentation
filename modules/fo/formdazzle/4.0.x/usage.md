Formdazzle! makes Drupal form theming far easier by adding fine-grained Twig template suggestions to every form, form element, and label — each including the form ID and the element name — plus Twig-debug comments for the otherwise invisible form template.

---

The module adds no configuration and no output of its own; it purely enriches theme
suggestions. On `hook_form_alter` (registered late via `hook_module_implements_alter`, and the
install sets the module weight to 10 so it runs after other modules) it stashes the form ID on
the form and appends a `#pre_render` callback (`Dazzler::preRenderForm`). During pre-render —
after all other alters have run — it recursively traverses the render array and, for each
element with `#theme` / `#theme_wrappers`, appends a suggestion suffix built from the form ID
and the element name, e.g. `input--textfield--webform-contact--first-name`. It also derives
friendlier form-ID suggestions for special cases (webforms become `webform_<id>`, views
exposed forms fold the View name + display, and numeric-suffixed commerce form IDs are
simplified). Labels get matching suggestions via `hook_preprocess_form_element`. When Twig
debug is on, it injects an HTML "FILE NAME SUGGESTIONS" comment for the top-level form
template (which core normally hides). Where core offered only `input.html.twig` and
`input--textfield.html.twig`, Formdazzle also offers `input--textfield--<form-id>.html.twig`
and `input--textfield--<form-id>--<element-name>.html.twig`, so front-end developers can
target one field on one form with a dedicated template.

---

- Theme a single field on a single form with its own Twig template (e.g. `input--textfield--webform-contact--first-name.html.twig`).
- Add form-ID-specific templates for text inputs, selects, checkboxes, buttons, and other elements.
- Give every form element's label its own template suggestion for targeted label markup.
- See the available form template suggestions in the page source when Twig debug is enabled.
- Reveal suggestions for the top-level form template that Drupal core normally hides.
- Restyle just the search block form without affecting other forms.
- Theme the login form's password field differently from other password fields.
- Target a Webform's fields by simplified `webform_<id>` suggestions instead of long form IDs.
- Theme a Views exposed filter form using suggestions that fold in the View name and display ID.
- Simplify overly specific, numeric commerce "add to cart" form IDs into stable suggestions.
- Provide per-form button templates (e.g. a distinct submit button on the contact form).
- Give designers granular hooks without writing any preprocess or hook_theme_suggestions code.
- Build a form-specific design system where each form has consistent, template-driven styling.
- Distinguish otherwise-identical elements that appear on multiple forms by form ID.
- Theme `actions`, `password_confirm`, `more_link`, and `system_compact_link` wrappers that core leaves without good suggestions.
- Add per-element-name suggestions to elements that only had generic `#theme` values.
- Speed up front-end debugging by reading the suggestion list straight from HTML comments.
- Keep form theming maintainable by using descriptive template file names.
- Override wrapper markup (`form_element` wrappers) per form and per element.
- Apply distinct markup to the same field across different content-type node forms.
- Let a subtheme ship a library of form-element templates keyed by form and field.
