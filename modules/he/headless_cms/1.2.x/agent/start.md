<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS (headless_cms) — agent index

Umbrella project of conveniences for **decoupled/headless Drupal**, built on the **Consumers**
module. Version **1.2.x**. Core `^10.3 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later.
Depends on `consumers:consumers`. Package: *Other*.

The base module is thin — the features live in five independently-enablable submodules.

## What the base module actually provides

- **Permission** `administer headless_cms settings` (`restrict access: true`) — gates every
  Headless CMS admin route (`headless_cms.permissions.yml`).
- **Menu page** `headless_cms.settings` at **`/admin/config/headless-cms`** — a plain
  `SystemController::systemAdminMenuBlockPage` landing page under *Configuration*
  (`headless_cms.routing.yml`, `headless_cms.links.menu.yml`). Submodules add their pages beneath it.
- **`HeadlessCmsUtility::alterConsumerForm()`** (`src/HeadlessCmsUtility.php`) — a static helper the
  submodules call from `hook_form_consumer_form_alter()` to add a shared *Additional Settings →
  Headless CMS* vertical-tab group to the `consumer` entity form and attach the `headless_cms/form`
  library (`css/form.css`).
- No entities, services, plugins, routes-with-controllers, hooks or Drush of its own.

## Submodules (each documented separately)

- **headless_cms_notify** — the notification framework: `headless_notify_transport` config entity,
  the `headless_cms_notify_transport` plugin type, per-consumer enable/transport/type fields, and
  the entity-operation + cache-rebuild senders. See
  [../modules/headless_cms_notify/1.2.x/agent/start.md](../modules/headless_cms_notify/1.2.x/agent/start.md).
- **headless_cms_notify_webhook** — a `webhook` transport (queued HTTP POST). See
  [../modules/headless_cms_notify_webhook/1.2.x/agent/start.md](../modules/headless_cms_notify_webhook/1.2.x/agent/start.md).
- **headless_cms_notify_nats** — a `nats` transport (publish to a NATS subject). See
  [../modules/headless_cms_notify_nats/1.2.x/agent/start.md](../modules/headless_cms_notify_nats/1.2.x/agent/start.md).
- **headless_cms_preview** — JSON:API preview of unpublished nodes/revisions via preview tokens. See
  [../modules/headless_cms_preview/1.2.x/agent/start.md](../modules/headless_cms_preview/1.2.x/agent/start.md).
- **headless_cms_preview_nats** — publishes a NATS message when a preview is saved. See
  [../modules/headless_cms_preview_nats/1.2.x/agent/start.md](../modules/headless_cms_preview_nats/1.2.x/agent/start.md).

## Solution docs

- **Install/enable, the settings page, consumer-form integration, submodule map** →
  [config/settings.md](config/settings.md)
