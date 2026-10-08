# Configure webform nodes

Enabling the module creates a **Webform** content type whose body is a Webform
entity-reference field (`webform` field type). No admin settings route — configuration is
per-node and per-field.

## Node form
Create content → **Webform**. Fields on the reference widget:
- **Webform** — which webform to render.
- **Default submission data** — YAML of default values.
- **Default status / state** — open/closed/scheduled override for this node.

## Add the field elsewhere
The `webform` field type can be added to any content type via **Manage fields** →
"Webform" — the node then embeds the chosen form.

## Per-node routes (auto-provided)
- Form/confirmation: `/node/{node}/webform`, `/node/{node}/webform/confirmation`
- Results: `/node/{node}/webform/results/submissions`, `.../results/download`, `.../results/clear`
- Test: `/node/{node}/webform/test`
- User's own: `/node/{node}/webform/submissions`, `/node/{node}/webform/drafts`

## References report
`/admin/structure/webform/manage/{webform}/references` (route
`entity.webform.references`) lists every node referencing a webform; add via
`entity.webform.references.add_form`.
