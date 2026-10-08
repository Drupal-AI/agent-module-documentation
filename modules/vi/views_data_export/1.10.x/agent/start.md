# views_data_export — agent start

Adds a **Data export** Views display + style that serialize View results to a downloadable file
(CSV / XML / JSON / XLS), with batching for large sets. Depends on `views`, `rest`, and
`csv_serialization` (XLS needs `xls_serialization`). No admin page — configured inside a View.

- Build a Data Export display in a View (formats, attach, batch, CSV/XML options) → [configure/views_data_export.md](configure/views_data_export.md)
- Run an export from the CLI (`vde`) → [drush/views_data_export.md](drush/views_data_export.md)
- Alter each exported row via hook → [hooks/views_data_export.md](hooks/views_data_export.md)
