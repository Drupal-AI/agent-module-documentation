# moderated_content_bulk_publish — agent start

Adds bulk moderation Action plugins (publish latest revision, unpublish/archive current
revision, pin/unpin) to `/admin/content` for content types using core Content Moderation.
Transitions run per-translation through workflow states, not a raw status flip. Depends on
`content_moderation`, `workflows`, `pathauto`, `views_bulk_operations`. Settings UI:
**Admin → Config → Content authoring → Moderated content bulk publish**
(`/admin/config/content/moderated-content-bulk-publish`); route
`moderated_content_bulk_publish.settings.form`.

- The bulk actions, the admin-content view setup, dialog/language/revision settings → [configure/settings.md](configure/settings.md)
- Permissions gating each bulk action → [permissions/permissions.md](permissions/permissions.md)
- Veto a transition from another module (verify hooks) → [hooks/hooks.md](hooks/hooks.md)
