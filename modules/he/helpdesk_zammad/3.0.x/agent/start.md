<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zammad for Helpdesk Integration (helpdesk_zammad) — agent index

**A `zammad` plugin for Helpdesk Integration: syncs Drupal issues/comments ↔ Zammad tickets and embeds the Zammad chat widget.**

- **Version:** 3.0.x  •  core: `^11.4 || ^12.0`  •  depends on `helpdesk_integration:helpdesk_integration`  •  package: Helpdesk
- **Plugin:** `@HelpdeskPlugin id=zammad` (`src/Plugin/HelpdeskIntegration/Zammad.php`) — `createIssue`, `addCommentToIssue`, `resolveIssue`, `pushUser`, `getAllIssues`.
- **Services:** `helpdesk_zammad.client_factory` (builds `ZammadAPIClient\Client` from url + http_token), `helpdesk_zammad.service` (list/chat-instance helper), hooks class `HelpdeskZammadHooks` (`library_info_alter`, `page_bottom`).
- **Config:** per-helpdesk-entity settings (url, api_token, group, state_closed, chat_*). No own routes/permissions/config forms — all UI via `helpdesk_integration`.
- **Library:** `helpdesk_zammad/chat` (+ dynamically added `<url>/assets/chat/chat.min.js`).

**Security:** no routes, permissions or forms of its own → **no anonymous ticket-create endpoint** in this module (ticket creation is a framework-driven server-side action). Credential storage: the Zammad **API token is stored as plaintext** in the helpdesk config entity via a plain `textfield` (`src/Plugin/HelpdeskIntegration/Zammad.php:112`), not a password field or Key-module reference — treat as sensitive. TLS is **not** disabled — `ZammadClientFactory::create()` passes only `url`+`http_token`, no `verify => false` (`src/ZammadClientFactory.php:17`).

See [configure/zammad.md](configure/zammad.md)
