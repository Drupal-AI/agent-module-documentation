<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ComputerMinds Data Layer (cm_data_layer) — agent index

**A messenger-like service that queues server-side data and pushes it into the client `window.dataLayer` on the next HTML or AJAX response.**

- **Version:** 3.1.x (3.1.0)
- **Core:** ^9 || ^10 || ^11
- **Service:** `cm_data_layer.data_layer` (`push()`, `getData()`, `migrateAnonData()`), args `@tempstore.private`, `@session_manager`.
- **Subscriber:** `DataLayerSubscriber` on `KernelEvents::RESPONSE` — attaches `drupalSettings.cm_data_layer` for HtmlResponse, emits `dataLayerPush` AJAX commands for AjaxResponse.
- **Hooks:** `hook_page_attachments` (loads command library), `hook_user_login` (migrates anon data).
- **JS:** `Drupal.behaviors.dataLayerPush` and `Drupal.AjaxCommands.prototype.dataLayerPush` both call `dataLayer.push()`.
- **No routes / no permissions.**

**Security:** No public routes. Data travels via `drupalSettings` (JSON-encoded) and is handed to `dataLayer.push()`; the client never injects it into the DOM as HTML, so the transport is not an XSS sink. The module does no filtering of payloads — sanitization of any user-controlled values is the caller's responsibility. No TLS/credential handling.

See [api/push.md](api/push.md)