<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emporiqa (emporiqa) — agent index

Drupal side of the **Emporiqa** SaaS AI chat assistant for **Drupal Commerce**. Syncs Commerce
products/variations and opted-in content nodes to the Emporiqa platform over **signed webhooks**,
embeds the chat widget, and exposes JSON **cart**, **order-tracking**, and **user-token** endpoints.
Package `Commerce`. Depends on `commerce:commerce_product` and core `drupal:node`; composer requires
`drupal/commerce ^2.40 || ^3`. Core `^10.3 || ^11 || ^12`, PHP `>=8.1`. License GPL-2.0-or-later.
Version dir 1.0.x (installed 1.0.31). Not covered by the security advisory policy.

## What it provides
- **Permission** `administer emporiqa` (restrict access). **Config** object `emporiqa.settings`
  (settings + sync + field mapping; schema in `config/schema/emporiqa.schema.yml`).
- **Settings route** `emporiqa.settings` (`/admin/config/services/emporiqa`) and **Sync** tab
  `emporiqa.sync`; menu/task links + `emporiqa/admin` library.
- **Two `entity_view_mode`s** shipped in `config/optional`: `node.emporiqa`,
  `commerce_product.emporiqa` (the sync renders descriptions/pages through them).
- **Public JSON API routes** (`_access: 'TRUE'`, guarded inside the controllers) — cart CRUD +
  order tracking; **user-token** route (`_user_is_logged_in`).
- **Services**: `emporiqa.webhook_client`, `emporiqa.data_formatter`, `emporiqa.sync_processor`,
  the OOP hook handler, and two event subscribers.
- **QueueWorker** `emporiqa_webhook` (cron, 60s). **Drush** commands `emporiqa:sync-products`,
  `:sync-pages`, `:sync-all`, `:test-connection`. **9 alter hooks** (`emporiqa.api.php`).
- Two front-end JS libraries: `emporiqa/widget-loader`, `emporiqa/cart`.

## Solution docs
- **Settings, permission, install auto-detection, view modes** → [config/settings.md](config/settings.md)
- **Sync pipeline: hooks → queue → WebhookClient → DataFormatter/SyncProcessor, subscribers, Drush**
  → [sync/pipeline.md](sync/pipeline.md)
- **HTTP API: cart, order-tracking, user-token routes & controllers** → [api/endpoints.md](api/endpoints.md)
- **Alter hooks reference** → [api/hooks.md](api/hooks.md)
