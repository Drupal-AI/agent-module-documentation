# A11Y: Form Helpers — templates & render wiring

## Template replacement

When `features.replace_core_templates` is TRUE, `a11y_form_helpers_theme_registry_alter()` overrides the
core `form_element` and `fieldset` theme entries: if the current template's path starts with `core/`, it
repoints `path` (and `theme path`) to this module's `templates/<themeFamily>/` copy. The family is taken
from the third path segment of the core template's path; if a matching subdir doesn't exist it falls
back to `templates/system`.

Shipped template families (each has `form-element.html.twig` + `fieldset.html.twig`):
- `templates/claro/`
- `templates/classy/`
- `templates/stable/`
- `templates/system/`

To customize for your own theme, copy one of these into your theme (start from `system` or the base
theme your theme extends).

## Variables the templates rely on

`hook_preprocess_form_element` and `hook_preprocess_fieldset` add, when the element has `#errors` and no
`#error_no_message`:
- `errors` — the element's error message(s).
- `errormessage_id` — `<element #id>--errormessage`.

The module's templates render `errors` inside an element referenced by `errormessage_id`, which the
`aria-describedby` (below) points to.

## Render element pre_render

`A11yFormHelpersRenderElement` (a `TrustedCallbackInterface`):
- `alterElementInfo()` (via `hook_element_info_alter`) appends `preRenderElement` to the `#pre_render`
  of **every** element type.
- `preRenderElement()` — when `features.readable_error_messages` is on and the element has `#errors`,
  sets `#attributes['aria-describedby']` to `<id>--errormessage` (preserving any existing
  `aria-describedby`). This is what programmatically ties the error text to the input for screen readers.
