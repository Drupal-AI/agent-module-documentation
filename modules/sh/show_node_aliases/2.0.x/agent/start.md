# Show Node Aliases — agent index

On a node **edit form**, lists **every** URL alias pointing at that node (an "Existing Aliases"
details table), with inline **Edit/Delete** links for users who hold core's
`administer url aliases` permission.

Key facts:
- **No config, no settings form, no configure route, no permissions of its own, no Drush.**
  Depends on core `path`. Reuses the core permission `administer url aliases` to gate the
  Edit/Delete operation links.
- It only **reads** aliases from the `path_alias` entity/table (`path = /node/<nid>`); it never
  creates or edits them — those go through core's path UI at
  `/admin/config/search/path/...`.
- Mechanism: `hook_field_widget_single_element_path_form_alter()` on the core `path` widget.

Docs:
- **How the alias list is built + where aliases live (mechanism)** → [api/mechanism.md](api/mechanism.md)
