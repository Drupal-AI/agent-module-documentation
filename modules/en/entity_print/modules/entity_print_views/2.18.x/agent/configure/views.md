# Print a View

Two Views handlers (no admin form of its own — engine/paper settings live on the parent module's
`entity_print.settings`).

## Global "Print" area handler
`@ViewsArea("entity_print_views_link")` — in the View UI add it to **Header** or **Footer**
(*Add → Print*). It renders a link that prints the entire display via
`print/view/{export_type}/{view_name}/{display_id}`. Configure the export type and window
behavior on the handler.

## Per-row "Print link" field
`hook_views_data_alter()` adds an `entity_print_<entity_type>` field ("Print link", id
`entity_print_link`) to each entity type's Views data. Add it as a field to print the individual
entity of that row. Field settings (schema `views.field.entity_print_link`):
- `export_type` — machine name of the export type (`pdf`, `epub`, `word_docx`).
- `open_new_window` — open the printable output in a new tab.

## Access
Permission `entity print views access` ("Access Printable version of View") gates the print
routes. Grant it to the roles that may download printable Views.

Debug the generated HTML at `print/view/{export_type}/{view_name}/{display_id}/debug`.
