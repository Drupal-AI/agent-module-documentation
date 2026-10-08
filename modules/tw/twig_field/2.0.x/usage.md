Twig Field adds a `twig` field type whose stored value is a Twig template that is compiled and rendered at display time, edited in-browser with a CodeMirror code editor. Editing the field is gated behind the restricted `access twig fields` permission (trusted users only).

---

The module ships one field type (`TwigItem`, id `twig`, a `big` text column) with its own widget
(`TwigWidget`, "Template editor") and formatter (`TwigFormatter`, "Rendered Twig template"). The widget
renders a CodeMirror editor (via the required `codemirror_editor` module) with `html_twig` mode plus a
"Variables" insert helper listing every available Twig context key. The formatter renders each item as a
core `inline_template` element (`'#template' => $item->value`), i.e. the stored string is executed as
Twig. The context passed in is: a **global** context from `twig_field_default_context()` (`theme`,
`theme_directory`, `base_path`, `front_page`, `is_front`, `language`, `is_admin`, `logged_in`); one
variable **per rendered field** of the host entity when the field's `display_mode` setting points at an
entity view display (that display is built and each of its components becomes a context variable, the Twig
field itself removed to avoid recursion); and the **host entity** itself keyed by its entity type id. Two
alter hooks — `hook_twig_field_widget_variable_alter()` and `hook_twig_field_formatter_variable_alter()` —
let other modules add widget-picker options and formatter context. The widget's `#element_validate`
compiles the template in isolation on save (`renderInIsolation`) and surfaces syntax errors. Because a
Twig template is effectively executable code (SSTI/RCE risk), the module implements
`hook_entity_field_access()` so that **editing** any `twig`-type field is forbidden unless the user holds
`access twig fields` — a permission flagged `restrict access: true` (grant to trusted admins only). There
is no global settings page; the field type, widget, and formatter are configured per field/display.

---

- Add a `twig` field to a content type to store a per-entity Twig template.
- Render a computed/derived display from other fields on the same entity via a Twig template.
- Compose several fields into custom markup without writing a preprocess or template file.
- Build a small presentational snippet (badge, callout, ratio) driven by entity field values.
- Give trusted site builders inline templating without shipping theme code.
- Reference another display mode's rendered fields as Twig variables via the `display_mode` field setting.
- Use the CodeMirror editor with Twig/HTML/CSS/JS syntax highlighting to author the template.
- Insert available context variables into the template with the widget's "Variables" picker.
- Access global context (`theme`, `base_path`, `language`, `is_front`, `logged_in`, `is_admin`) in a template.
- Access the host entity object (keyed by entity type id, e.g. `node`) inside the template.
- Validate a template's Twig syntax automatically on save (errors block the save).
- Add extra widget variable options for editors via `hook_twig_field_widget_variable_alter()`.
- Inject extra formatter context variables via `hook_twig_field_formatter_variable_alter()`.
- Restrict who can create/edit Twig templates using the `access twig fields` permission.
- Provide a default template as the field's default value.
- Set the editor size (rows) and placeholder text per widget instance.
- Toggle CodeMirror options (toolbar, line wrapping, line numbers, fold gutter, auto-close tags).
- Store multiple Twig templates on one entity via a multi-value `twig` field.
- Use the field on any fieldable entity type (nodes, taxonomy terms, media, etc.).
- Render context-aware output that changes with the current theme, language, or login state.
