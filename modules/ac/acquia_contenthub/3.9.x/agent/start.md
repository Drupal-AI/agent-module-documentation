# acquia_contenthub — agent start

Connects Drupal to **Acquia Content Hub** (SaaS) for entity syndication between many sites.
Content is serialized to CDF and pushed by publishers; subscribers receive HMAC-validated
webhooks and import with full dependency graphs (via the required `depcalc` module). The
pipeline is **event-driven** (Symfony events, no `hook_*` API / no `*.api.php`). Config UI:
**Admin → Config → Services → Acquia Content Hub** (`/admin/config/services/acquia-contenthub`,
route `acquia_contenthub.admin_settings`). Single permission: `administer acquia content hub`
(restricted). Webhook endpoint: `/acquia-contenthub/webhook` (public route, HMAC-verified).

- Connect/register, settings keys, secure credential provisioning (settings.php / env var / config), webhook → [configure/settings.md](configure/settings.md)
- Drush commands (connect, queues, filters, webhooks, purge, audit, reindex) → [drush/commands.md](drush/commands.md)
- Subscribe to the CDF/import/webhook events to alter syndication → [extend/events.md](extend/events.md)
- Key services & the common-actions facade for code → [api/services.md](api/services.md)
- `FileSchemeHandler` plugin type (public/private/http(s)/s3 file export) → [plugins/file-scheme-handler.md](plugins/file-scheme-handler.md)

## Roles live in submodules (nested under this dir's `modules/`)
- `acquia_contenthub_publisher` — export content, export queue, exclude settings.
- `acquia_contenthub_subscriber` — import content, import queue, tracker.
- plus curation, dashboard, metatag, moderation, translations, s3 (deprecated),
  site_health, unsubscribe.
