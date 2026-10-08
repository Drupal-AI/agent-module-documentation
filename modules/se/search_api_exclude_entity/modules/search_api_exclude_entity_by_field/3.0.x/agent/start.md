# search_api_exclude_entity_by_field — agent start

Submodule of `search_api_exclude_entity`. Adds a Search API processor
`search_api_exclude_entity_by_field_processor` that excludes items when an **indexed field**
matches a configured value — no dedicated exclude field needed. Depends on the parent module
(`search_api_exclude_entity`). Package: Search. No admin route (`configure` null).

- Enable the processor and set per-field match values → [configure/search_api_exclude_entity_by_field.md](configure/search_api_exclude_entity_by_field.md)
