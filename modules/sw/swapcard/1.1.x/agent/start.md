<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swapcard (swapcard) — agent index

**GraphQL API client + plugin manager for the Swapcard event platform, with optional content and media sync submodules.**

- **Version:** 1.1.x
- **Core:** ^9 || ^10
- **Configure:** `swapcard.config` → `/admin/config/services/swapcard/config` (permission `administer site configuration`).
- **Service:** `plugin.manager.swapcard` (extends default_plugin_manager); plugins annotated `@Swapcard`, base `SwapcardPluginBase` (`queryString()`, `post()`).
- **Config store:** `swapcard.settings` — `api_key`, `guzzle_options` (base_uri, timeout).
- **Auth:** API key sent as `Authorization: <api_key>` header; Guzzle defaults (TLS verification not disabled).
- **Submodules:** `swapcard_content` (4 content types, QueueWorker sync, Drush `SwapcardCommands`, purge form; requires Queue UI), `swapcard_content_media` (media image sync).
- **Hooks:** `hook_swapcard_request_alter()` to extend query fields; `swapcard` plugin alter.

**Security:** single admin config route (`administer site configuration`); API key stored in config; outbound-only GraphQL over Guzzle with default TLS verification. No anonymous or mutating public endpoints.

See [api/graphql-client.md](api/graphql-client.md)
