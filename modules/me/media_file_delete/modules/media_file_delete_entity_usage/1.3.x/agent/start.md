# media_file_delete_entity_usage — agent start

Submodule of **media_file_delete**. Registers an Entity Usage-backed file-usage resolver so that
files still referenced by entities tracked in the Entity Usage module are retained when their
media item is deleted. No config, permissions, routes, or UI. Depends on `media_file_delete` and
`entity_usage`.

- How the Entity Usage resolver plugs into the chain → [extend/entity-usage-resolver.md](extend/entity-usage-resolver.md)
