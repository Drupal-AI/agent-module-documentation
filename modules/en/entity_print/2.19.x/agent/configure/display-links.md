# Expose print links on entities

Three ways to give users a link to `print/{export_type}/{entity_type}/{id}`:

## 1. "View PDF" pseudo-field (Manage Display)
`hook_entity_extra_field_info()` adds a display component `entity_print_view_<export_type>`
(e.g. `entity_print_view_pdf`) to **every** bundle. On *Structure → Content types → Manage
display*, drag it out of "Disabled" and position it. The label is editable inline and stored as
a third-party setting (`core.entity_view_display.*.third_party.entity_print`). It renders a
`#type => 'print_link'` element, access-checked against the print route.

## 2. Print Links block
Block plugin `print_links` (category *Entity Print*), context `entity:node`. Config
(`block.settings.print_links`) toggles `pdf_enabled` / `epub_enabled` / `word_docx_enabled`
and their link text. Place it in a region on node pages.

## 3. Bulk action
Action `entity_print_download_action` ("Print", type `node`, config
`action.configuration.entity_print_download_action`) streams the PDF for a selected node from a
Views bulk-operations / admin listing.

Access to any of these is governed by [../permissions/permissions.md](../permissions/permissions.md).
For printing a whole View, see the `entity_print_views` submodule.
