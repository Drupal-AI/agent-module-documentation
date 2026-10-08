<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cloudflare_node_cc — service API

Service id `cloudflare_node_cc.cloudflare_service` → `Drupal\cloudflare_node_cc\CloudflareService`. Key methods:

- `getZones($email='', $apiKey='', $apiToken='')` — list all zones (paged 50/page) as `[zone_id => zone]`.
- `getZone($zoneId)` — single zone object.
- `purgeZoneCache($zoneId): bool` — purge everything in a zone (`cachePurgeEverything`).
- `purgeZoneCacheFiles($zoneId, array $files): bool` — purge specific URLs (`cachePurge`).
- `getUserId(): ?string`, `getZoneId()`, `isMultiZone()`, `getLanguageZones()`, `getLanguageZoneId($langcode)`, `getLanguageDomain($langcode)`.
- `getApiKey()/getApiToken()` — resolve the secret from the configured Key entity (`key.repository`).

Auth selection logic: if `email`+`apiKey` present → `APIKey` auth; else if `apiToken` present → `APIToken` auth. Requests go through `Cloudflare\API\Adapter\Guzzle`; exceptions are caught and logged to the `cloudflare_node_cc` channel.

The node-form "Save & Purge" submit handler `_cloudflare_node_cc_purge_node()` (`.module`) purges the saved node's alias/URL after save; the `CloudflareController::purgeCache()` action purges the configured zone(s) and redirects to `HTTP_REFERER` (or `/`).
