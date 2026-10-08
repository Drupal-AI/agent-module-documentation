# Taxonomy Machine Name — agent index

Adds a `machine_name` **string base field** to every `taxonomy_term`, auto-filled on save
(transliterated slug of the term name) and made unique per vocabulary. No configure route
(`configure: null`), no Drush. Persists as a real column on `taxonomy_term_field_data`.

- **The property, how it is generated/uniquified, loading a term by machine name, tokens,
  Migrate, the term body class** → [api/machine-name.md](api/machine-name.md)
- **Set/see machine names in the UI, the overview-page column + permission, Views filter &
  argument validator, uninstall behavior** → [configure/ui-and-views.md](configure/ui-and-views.md)
- **Override the slug algorithm** → [hooks/clean-name.md](hooks/clean-name.md)

Key facts:
- Base field id is `machine_name` on entity type `taxonomy_term`; read it with
  `$term->get('machine_name')->value` (or `$term->machine_name->value`).
- Generation: `taxonomy_machine_name_clean_name($name)` → transliterate, lowercase, non
  `[a-z0-9_]` → `_`. Uniqueness: `taxonomy_machine_name_uniquify()` appends `_0`, `_1`, ….
- Load: `taxonomy_machine_name_term_load($machine_name, $vid)` returns a term or NULL.
- Token `[term:machine_name]`; permission `view machine name overview page`.
- Submodule `search_api_taxonomy_machine_name` nests under
  `modules/taxonomy_machine_name/modules/search_api_taxonomy_machine_name/2.0.x/`.
