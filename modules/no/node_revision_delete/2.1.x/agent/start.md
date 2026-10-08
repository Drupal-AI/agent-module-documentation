# node_revision_delete — agent start

Tracks and prunes old node revisions per content type, via queue workers on cron. Depends on
`node`. Config UI: **Admin → Config → Content authoring → Node Revision Delete**
(`/admin/config/content/node_revision_delete`, route `node_revision_delete.admin_settings`).

- Configure retention rules, threshold, queueing → [configure/settings.md](configure/settings.md)
- Deletion-strategy plugin type (amount/created/drafts/only_drafts) → [plugins/strategy.md](plugins/strategy.md)
- Queue/prune from the CLI → [drush/commands.md](drush/commands.md)
- Inspect/queue revisions in code → [api/service.md](api/service.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
