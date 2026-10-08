# Campaign Monitor — agent index

Drupal ↔ Campaign Monitor API integration built on the `campaignmonitor/createsend-php` SDK.
Stores API key + Client ID in `campaignmonitor.settings`; two services wrap the SDK. Admin config at
`admin/config/services/campaignmonitor` (`configure: campaignmonitor.admin`), all admin routes gated by
`administer campaignmonitor`. A subscribe block signs visitors up to enabled lists. Optional cron queue.

- **Admin settings, list enablement, per-list settings, config keys, list controller routes** →
  [configure/settings.md](configure/settings.md)
- **Services (`campaignmonitor.manager`, `campaignmonitor.subscription_manager`), subscribe/unsubscribe from code,
  the subscribe block/form** → [api/services.md](api/services.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Invoked hooks (`hook_campaignmonitor_subscribe` / `_unsubscribe`)** → [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs):
- `campaignmonitor_registration` → [../../modules/campaignmonitor_registration/3.0.x/agent/start.md](../../modules/campaignmonitor_registration/3.0.x/agent/start.md)
- `campaignmonitor_user` → [../../modules/campaignmonitor_user/3.0.x/agent/start.md](../../modules/campaignmonitor_user/3.0.x/agent/start.md)

Key facts:
- Depends on core `link`; requires the `campaignmonitor/createsend-php` ^7.0 Composer library (auto-installed).
- No plugin types, no Drush. Provides one block plugin `campaignmonitor_subscribe_block`.
- Subscription can be immediate or queued to `campaignmonitor_queue_cron` (DatabaseQueue) when `cron` is on.
- API host is fixed by the SDK (no arbitrary-URL surface); API key persists in config by design.
