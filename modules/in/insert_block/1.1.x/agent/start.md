# insert_block — agent start

Insert Block adds one text-format **filter** plugin, `filter_insert_block` ("Insert blocks"), that
replaces `[block:BLOCK_ID]` placeholders in filtered text with a rendered block. `BLOCK_ID` resolves
first as a placed-block config entity (`block`) id, then falls back to a content block
(`block_content`) numeric id. One setting, `check_roles` (default TRUE), honors placed blocks' role
visibility. Depends only on core `block` + `filter`. No routes, no `configure` route, no permissions,
no services, no Drush — configuration is entirely through core's Text formats UI.

- Enable the filter on a text format, the `check_roles` setting, tag syntax, config schema
  → [configure/insert_block.md](configure/insert_block.md)
- How the filter resolves ids, role-visibility check, cache tags, plugin internals
  → [api/insert_block.md](api/insert_block.md)
