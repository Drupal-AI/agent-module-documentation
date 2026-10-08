# config_split — agent start

Splits Drupal config into independently import/exportable sets per environment. Config entity
type `config_split`. Config UI: **Admin → Config → Development → Configuration → Configuration
Split settings** (`/admin/config/development/configuration/config-split`, configure route
`entity.config_split.collection`). No module dependencies; integrates with core config sync.

- Create/configure split entities (folder, modules, themes, complete/partial lists) → [configure/config_split.md](configure/config_split.md)
- Drush commands (export/import/activate/deactivate/status-override) → [drush/config_split.md](drush/config_split.md)
- Activate splits per environment / status override in code → [api/config_split.md](api/config_split.md)
- Permissions → [permissions/config_split.md](permissions/config_split.md)
