# entity_usage — agent start

Tracks which entities reference which (source → target) and shows "where used" info.
No hard module deps. Config UI: **Admin → Config → Content Authoring → Entity Usage
Settings** (`/admin/config/entity-usage/settings`, route `entity_usage.settings.form`).

- Settings: tracked source/target types, plugins, Usage tab, edit/delete warnings → [configure/settings.md](configure/settings.md)
- Rebuild the usage table (batch UI form) → [configure/batch-update.md](configure/batch-update.md)
- Tracking methods & writing an EntityUsageTrack plugin → [plugins/track.md](plugins/track.md)
- Read/write usage data in code (`entity_usage.usage`) → [api/entity-usage.md](api/entity-usage.md)
- Block a tracking record via hook → [hooks/entity_usage.md](hooks/entity_usage.md)
- Drush: recreate all statistics → [drush/entity_usage.md](drush/entity_usage.md)
- Permissions → [permissions/entity_usage.md](permissions/entity_usage.md)
