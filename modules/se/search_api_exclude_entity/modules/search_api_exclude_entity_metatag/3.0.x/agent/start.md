# search_api_exclude_entity_metatag — agent start

Submodule of `search_api_exclude_entity`. Adds a Search API processor
`search_api_exclude_entity_processor_metatag` that excludes **published** entities whose
Metatag `robots` value contains `noindex`. Depends on `metatag` and the parent module.
Package: Search. No settings form, no config schema, no admin route (`configure` null) —
enabling it is all that's needed.

- Enable the processor / how the noindex exclusion works → [configure/search_api_exclude_entity_metatag.md](configure/search_api_exclude_entity_metatag.md)
