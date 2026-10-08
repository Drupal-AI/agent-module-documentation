# Responsive Tables Filter — agent index

Adds one text-format **filter plugin** (`filter_responsive_tables_filter`) that makes HTML
tables responsive by attaching the bundled Tablesaw library and rewriting `<table>` markup.
Also has an optional module settings form to auto-apply Tablesaw to Views/theme tables.
No permissions, no Drush commands, no plugin types defined; config schema present.

- **The filter plugin: id, settings, how it wraps tables, per-table overrides** → [plugins/filter.md](plugins/filter.md)
- **Enable/configure the filter on a text format + the Views auto-apply settings form** → [configure/settings.md](configure/settings.md)
