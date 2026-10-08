<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Refresh WebHook — agent index

**On node save, queue an outbound POST to a configured endpoint so an external system refreshes the changed page.** Version **2.0.1**. Core `^11.2 || ^12`, PHP `>=8.3`. Depends on core `node` and `key`.

Outbound only — there is no inbound route. The single route is the admin settings form, gated by `administer site configuration`. Requests are queued on save and sent by the queue worker on cron. Payload: `{"docs":[{"url":...}],"depth":N}`; optional `api-key` header from a Key entity.

- **Configure endpoint, API key, content types, depth** → [configure/settings.md](configure/settings.md)
- **Veto or allow a trigger from custom code** → [hooks/trigger-webhook.md](hooks/trigger-webhook.md)
- **Customize sending by decorating the services** → [extend/services.md](extend/services.md)
- **Flush pending webhooks without waiting for cron** → [drush/queue.md](drush/queue.md)

Config object: `page_refresh_webhook.settings` (`endpoint`, `api_key`, `content_types.{bundle}.{enabled,depth}`). Queue name: `page_refresh_webhook`.
