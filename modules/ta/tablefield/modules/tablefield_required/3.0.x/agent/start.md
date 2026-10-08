# tablefield_required — agent start

Submodule of **tablefield**. Adds per-row and per-column required validation to a
`tablefield` field: mark whole rows and/or columns (zero-based indexes) as mandatory so
editors must fill those cells. Configured on the **field's own settings form** as
third-party settings (namespace `tablefield_required`), not a separate admin page. No
permissions, no menu, no Drush. Depends on `tablefield:tablefield`.

- Required rows/cols settings, storage, multi-value inherit, and when it applies → [configure/tablefield_required.md](configure/tablefield_required.md)
