<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
POST to an endpoint when specific content types are saved.

---

Page Refresh WebHook triggers a POST request to a configurable endpoint when specific content types are saved — so an external system (e.g. a static-site builder, CDN, or cache) can be notified to rebuild/refresh when relevant Drupal content changes.

The webhook endpoint URL and any secret/token are configured (the token via a Key entity, env-backed). Depends on core `node` and `key`; supports Drupal 9, 10, and 11.

---

- POST a webhook on content save.
- Target specific content types.
- Notify an external system.
- Trigger rebuild/refresh.
- Configure the endpoint.
- Store the token via a Key entity.
- Depend on core `node` and `key`.
- Support Drupal 9, 10, and 11.
- Aid decoupled/static builds.
- Handle the webhook.
- Notify on save.
- Refresh external systems
- Support Drupal.
- Support Drupal.
- Support Drupal.
