# Configure custom options

## Templates (config entities)
`webform_options_custom` config entities hold the reusable markup. Manage at
`/admin/structure/webform/options/custom/manage`
(route `entity.webform_options_custom.collection`): add / edit / **source** (YAML) /
**preview** / duplicate / delete. Schema: `config/schema/webform_options_custom.schema.yml`.

Key fields (see example `webform_options_custom.webform_options_custom.buttons.yml`):
- `template` — the HTML/SVG; option shapes carry `data-option-value="{value}"`.
- `css` — styling for the graphic.
- `url`, `category`, `type` (e.g. `template`), `help`, `description`.

The module ships examples `buttons` and `us_states`, plus an `example_options_custom` webform.

## The element
Add the **Custom options** element to a webform (element ids
`webform_options_custom` and the entity-backed `webform_options_custom_entity`;
plugins in `src/Plugin/WebformElement/`, with derivatives). Clicking a shape whose
`data-option-value` matches an option selects it; supports single or multiple selection and
per-option descriptions. Point the element at a stored template or supply inline markup.
