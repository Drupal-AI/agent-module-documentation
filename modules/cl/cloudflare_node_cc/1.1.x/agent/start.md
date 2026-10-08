<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Node Cache Clear (cloudflare_node_cc) — agent index

**Purges Cloudflare edge cache per node (on save) or site-wide per zone, with optional per-language zones/domains, Drush commands, and client-IP restoration.**

- **Version:** 1.1.x (info.yml `1.1.0`)
- **Core:** `^10 || ^11` (Drupal 10 and 11 compatible).
- **Dependencies:** `node`, `admin_toolbar:admin_toolbar_tools`, `key`; PHP lib `cloudflare/sdk` (`^1.1 || ^2.0`) via Composer.
- **Configure:** `/admin/config/services/cloudflare-node-cache-clear` — route `cloudflare_node_cc.config_form` (`administer cloudflare_node_cc`).
- **Routes:** `cloudflare_node_cc.purge_cache` `/admin/cloudflare-node-cache-clear/purge-cache` and `cloudflare_node_cc.purge_cache_confirm` `/admin/cloudflare-node-cache-clear/purge-cache_confirm` — both gated by `CloudflareController::canPurgeAll()` (permission `cloudflare_node_cc purge cache`).
- **Service:** `cloudflare_node_cc.cloudflare_service` (`CloudflareService`); event subscriber `CloudflareClientIpRestore`; Drush command service `CloudflareCommands`.
- **Settings storage:** simple configuration object `cloudflare_node_cc.settings` (has config schema, exported like any config).
- **Secrets:** API key/token resolved at runtime from a **Key** entity via `key.repository`; only the Key's machine name is stored in config, never the secret value.

## What it does

`CloudflareService` wraps the `cloudflare/sdk` library (Guzzle adapter). It lists zones, purges everything in a zone (`purgeZoneCache` → `cachePurgeEverything`), purges specific URLs (`purgeZoneCacheFiles` → `cachePurge`), reads/sets a zone security level (firewall), and returns the Cloudflare user id. Auth is either Email + Global API Key (`APIKey`) or an API Token (`APIToken`), selected by the `auth_type` config value.

Two purge triggers:
- **Per node:** `hook_form_node_form_alter` adds a "Save & Purge Cloudflare Cache" button (or augments the normal Save when `replace_default_save_button` is on) for users with `cloudflare_node_cc purge cache per node`; submit handler `_cloudflare_node_cc_purge_node()` purges the saved node's alias/URL(s), handling translations, multi-zone, and the front page.
- **Site-wide:** `CloudflareController::purgeCache()` purges the configured zone(s), with an optional confirm-form step (`confirm_cc`), then redirects back to the referrer.

Drush: `cloudflare-node-cc:flush-cache` (zone/paths/content-type/nid) and `cloudflare-node-cc:attack-mode --zone=<id>` (sets zone security level to `under_attack`).

An optional event subscriber (`CloudflareClientIpRestore`) rewrites `REMOTE_ADDR` from Cloudflare's `CF-Connecting-IP` header when `restore_client_ip` is enabled, so Drupal sees the real visitor IP behind the Cloudflare proxy.

## Changes vs 1.0.x

- Now **Drupal 11 compatible** (`^10 || ^11`); dropped the old `media` dependency (deps are `node`, `admin_toolbar_tools`, `key`).
- Settings moved to a **simple config object** (`cloudflare_node_cc.settings`, with schema) via `ConfigFormBase` — the config form lives at `/admin/config/services/cloudflare-node-cache-clear`.
- Added **Drush commands** (`flush-cache`, `attack-mode`).
- Added UI options: **confirm cache clear**, **log each purge**, **always purge on node save**, and **purge front page when its node is purged**; added a dedicated confirm form route.

See [configure/settings.md](configure/settings.md) and [api/service.md](api/service.md).
