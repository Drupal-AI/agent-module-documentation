# scanner — agent start

Search and Replace Scanner (`scanner`, 2.0.x / **2.0.0-beta3**, beta). Admin-driven
find-and-replace across chosen **text/string/link fields** of entities (Node, Paragraph,
Commerce Product + Variation, extensible). Two-step UI: search + highlighted preview →
confirm → batch replace, with per-entity revisions and an **Undo** tab. No dependencies, no
Drush commands.

- Tool UI: **Admin → Content → Search and Replace Scanner** (`/admin/content/scanner`, route `scanner.admin_content`). Undo: `/admin/content/scanner/undo` (`scanner.undo`).
- Settings + which fields are scannable + default match options → [configure/settings.md](configure/settings.md) (route `scanner.admin_config`, `/admin/config/content/scanner`, config `scanner.admin_settings`).
- Run a search/replace/undo programmatically (the `plugin.manager.scanner` service) → [api/service.md](api/service.md).
- Add scanning support for a new entity type (a `Scanner` plugin) → [plugins/scanner-plugin.md](plugins/scanner-plugin.md).
- Alter/replace an existing scanner handler (`hook_scanner_info_alter`) → [hooks/hooks.md](hooks/hooks.md).
- Permissions (search-only / search-and-replace / administer) → [permissions/permissions.md](permissions/permissions.md).
