# scheduler — agent start

Adds **Publish on** / **Unpublish on** date fields to entity edit forms and processes them on
cron. Enabled per entity type + bundle. Core deps: `datetime`, `field`, `node`, `views`.
Site settings UI: **Admin → Config → Content authoring → Scheduler** (`/admin/config/content/scheduler`,
route `scheduler.admin_form`). Supports Node core + Media, Taxonomy term, Commerce product plugins.

- Global settings + lightweight cron → [configure/settings.md](configure/settings.md)
- Enable scheduling per entity type / bundle (third-party settings) → [configure/entity-types.md](configure/entity-types.md)
- SchedulerManager service (publish/unpublish, lightweight cron) → [api/scheduler-manager.md](api/scheduler-manager.md)
- Scheduler events (subscribe to publish/unpublish) → [api/events.md](api/events.md)
- Hooks to allow/deny/customise processing → [hooks/hooks.md](hooks/hooks.md)
- Add support for a new entity type (SchedulerPlugin) → [plugins/scheduler-plugin.md](plugins/scheduler-plugin.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Drush commands → [drush/drush.md](drush/drush.md)
