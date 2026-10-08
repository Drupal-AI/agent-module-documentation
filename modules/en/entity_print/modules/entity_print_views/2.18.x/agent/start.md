# entity_print_views — agent start

Submodule of `entity_print`. Prints a whole **View** (or a row's entity) to PDF/EPub/Word.
Depends on core `views` + `entity_print`. Print route
`print/view/{export_type}/{view_name}/{display_id}` (+ `/debug`). Engines, export types, and the
settings form all come from the parent module.

- Add print link/field to a View + the access permission → [configure/views.md](configure/views.md)
