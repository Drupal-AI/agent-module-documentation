# pathauto — agent start

Auto-generates URL aliases from token patterns per entity type/bundle. Depends on `token`
+ core `path`. Config UI: **Admin → Config → Search and metadata → URL aliases**
(`/admin/config/search/path`, configure route `entity.pathauto_pattern.collection`).

- Create/manage alias patterns → [configure/patterns.md](configure/patterns.md)
- Global cleanup settings (separator, length, transliterate, update action) → [configure/settings.md](configure/settings.md)
- Bulk generate / delete aliases → [configure/bulk-operations.md](configure/bulk-operations.md)
- Make a new entity type aliasable (plugin) → [plugins/alias-type.md](plugins/alias-type.md)
- Generate aliases in code → [api/generate-alias.md](api/generate-alias.md)
- Alter behavior via hooks → [extend/hooks.md](extend/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
