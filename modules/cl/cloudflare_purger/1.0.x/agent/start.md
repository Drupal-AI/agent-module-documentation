<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Purger (cloudflare_purger) — agent index

A **Purge module purger plugin** for **Cloudflare** CDN cache invalidation. Two halves:
(1) it tags cacheable responses with a compact `Cache-Tag` header so Cloudflare stores tags
alongside cached content, and (2) when Drupal invalidates cache tags/URLs, it calls the
Cloudflare API `purge_cache` endpoint to invalidate the same items at the edge. Package `Purge`.
Core `^10.6 || ^11`. PHP `>=8.3`. License GPL-2.0-or-later. Installed **1.0.0** (version dir `1.0.x`).

## Dependencies

- Drupal modules: **`key`** and **`purge`** (both required, `.info.yml`).
- Composer: `drupal/key ^1.0`, `php >=8.3`; `drupal/purge ^3.6` is **dev-only** (`require-dev`) —
  Purge is a runtime dependency declared in `.info.yml` but the module's own tests pull it.

## What it provides (from source)

- **Purger plugin** `cloudflare` (`Plugin/Purge/Purger/CloudflarePurger`) — supports invalidation
  types `tag`, `url`, `everything`; `multi_instance = FALSE`. Batches up to
  `MAX_PURGES_PER_API_REQUEST = 100` items/request; `getIdealConditionsLimit()` = 200.
  POSTs to `https://api.cloudflare.com/client/v4/zones/{zone_id}/purge_cache` with a `Bearer`
  token, payload `{tags:[…]}` / `{files:[…]}` / `{purge_everything:true}`.
- **Tags header plugin** `cloudflare` (`Plugin/Purge/TagsHeader/CloudflareTagsHeader`,
  `header_name = "Cache-Tag"`) — emits the converted tags on cacheable responses.
- **Diagnostic check** `cloudflare_purger_config_check`
  (`Plugin/Purge/DiagnosticCheck/ConfigCheck`) — errors in Purge's status UI if `zone_id` or
  `api_token_key` is missing, or the referenced Key entity does not exist.
- **Tags converter service** `cloudflare_purger.tags_converter` (`CloudflareTagsConverter`) —
  hashes each Drupal tag (xxh3 → base-36, first 6 chars) with a per-site prefix.
- **Overflow subscriber** `cloudflare_purger.overflow_subscriber`
  (`EventSubscriber/CloudflareTagsOverflowSubscriber`, `kernel.response` priority -1000) — if the
  `Cache-Tag` header exceeds `cloudflare_purger.max_response_header_length` (16373 bytes default),
  removes it and sets `Cloudflare-CDN-Cache-Control: no-cache, no-store`.
- **Settings form** `cloudflare_purger.settings` at `/admin/config/services/cloudflare-purger`
  (route requires `administer site configuration`; admin menu link under System → Services).
  Fields: **Zone ID** (textfield, 32 hex) and **API token key** (`key_select`).
- **Config** `cloudflare_purger.settings` (`FullyValidatable`): `zone_id` (regex `^[a-f0-9]{32}$`),
  `api_token_key` (must reference an existing `key.key.*`). No `.install`, no `.module`, no
  `.permissions.yml`, no libraries.

## Key settings that live outside config

- `Settings::get('cloudflare_purger_cache_tag_prefix', …)` — per-environment tag prefix
  (`settings.php`); falls back to `hash_salt`. Prevents cross-environment purging when several
  sites share one Cloudflare zone.
- `%cloudflare_purger.max_response_header_length%` container parameter — override in `services.yml`
  to match a host's smaller header cap (e.g. Acquia 8181).

## Solution docs

- **Purger API flow, tag conversion, overflow safeguard, diagnostic check, config** →
  [architecture/purger.md](architecture/purger.md)

## Token handling (summary)

The API token is held in a **Key** entity; config stores only the Key's ID. The purger loads the
token at request time and sends it as a `Bearer` header over HTTPS (default cert verification).
Never stored in config, echoed to the form, or exposed to JS.
