# simplenews — agent start

Sends email newsletters. Three concepts: **newsletter** = `simplenews_newsletter` config entity
(a list/category); **subscriber** = `simplenews_subscriber` content entity keyed by email with a
`subscriptions` field; **issue** = a node whose content type has the `simplenews_issue` field.
Sending goes through a **spool** (`simplenews.spool_storage`) drained by the **mailer**
(`simplenews.mailer`) immediately or via cron. Depends on core `node`, `field`, `options`, `views`.
Config UI: **Admin → Config → Web services → Simplenews** (`/admin/config/services/simplenews`);
configure route `simplenews.newsletter_list`.

- Create newsletters, enable issue field on a node type, settings & sending model → [configure/configure.md](configure/configure.md)
- Subscribe/unsubscribe in code, spool & mailer services, recipient handler plugin → [api/api.md](api/api.md)
- Hooks the module invites (`simplenews.api.php`) → [hooks/hooks.md](hooks/hooks.md)
- Recipient handler plugin type (who receives an issue) → [plugins/plugins.md](plugins/plugins.md)
- Drush spool commands → [drush/drush.md](drush/drush.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
