# single_content_sync — agent start

Exports one content entity (plus referenced entities/assets) to YAML or ZIP and imports it on
another site. Adds an **Export** tab/operation to fieldable entities and an **Import** page at
**Admin → Content → Import** (`/admin/content/import`). Settings UI: **Admin → Config → Content →
Single Content Sync** (`/admin/config/content/single-content-sync`); route `single_content_sync.config_settings`.
Depends on core `file`. Provides Drush commands, two plugin types, and services.

- Settings, per-entity Export tab, YAML/ZIP download, config keys → [configure/single_content_sync.md](configure/single_content_sync.md)
- Export/import in code (exporter, importer, file generator services) → [api/single_content_sync.md](api/single_content_sync.md)
- `content:export` / `content:import` Drush commands → [drush/single_content_sync.md](drush/single_content_sync.md)
- Custom field/entity handling: FieldProcessor & BaseFieldsProcessor plugins + events → [plugins/single_content_sync.md](plugins/single_content_sync.md)
- Permissions (import, per-entity-type export, administer) → [permissions/single_content_sync.md](permissions/single_content_sync.md)
