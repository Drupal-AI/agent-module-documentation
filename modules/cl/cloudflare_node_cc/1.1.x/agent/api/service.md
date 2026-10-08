<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cloudflare_node_cc — service & command API

Service id `cloudflare_node_cc.cloudflare_service` → `Drupal\cloudflare_node_cc\CloudflareService`. Constructor args: logger factory, config factory, datetime.time, entity type manager, messenger, `key.repository`.

Key methods:

- `getApiAuth()` — build `APIKey($email, $key)` when email+key present, else `APIToken($token)`; NULL if neither.
- `getApiKey($name='')` / `getApiToken($name='')` — resolve the secret from the configured Key entity via `key.repository->getKey()` (name comes from `api_key_name` / `api_token_name` config).
- `getZones($email='', $apiKey='', $apiToken='')` — list all zones (paged 50/page) as `[zone_id => zone]`.
- `getZone($zoneId)` — single zone object.
- `purgeZoneCache($zoneId): bool` — purge everything (`cachePurgeEverything`).
- `purgeZoneCacheFiles($zoneId, array $files): bool` — purge specific URLs (`cachePurge`).
- `getUserId(): ?string`; `getZoneId()`, `isMultiZone()`, `getLanguageZones()`, `getLanguageZoneId($langcode)`, `getLanguageDomain($langcode)`.
- `getZoneSecurityLevel($zoneId)` / `setZoneSecurityLevel($zoneId, $level)` — firewall security level (`FirewallSettings`).
- `isDisabled()`, `needConfirmation()`.

Requests go through `Cloudflare\API\Adapter\Guzzle`; `RequestException`/`Exception` are caught and logged to the `cloudflare_node_cc` channel. Purges are logged at info level only when `log_purges` is set.

## Triggers

- Node form: `_cloudflare_node_cc_purge_node()` (`.module`) purges the saved node's alias/URL(s) after save — handles translations, multi-zone (per-language zone/domain), and optionally the front page.
- Controller: `CloudflareController::purgeCache()` purges the configured zone(s), honours `confirm_cc` (redirect to the confirm form), and redirects to the session `cf_destination` / `HTTP_REFERER` / `/`. Access via `canPurgeAll()` = not disabled AND `cloudflare_node_cc purge cache`.

## Drush (`CloudflareCommands`, `drush.services.yml`)

- `cloudflare-node-cc:flush-cache` (aliases `cfncc-cr`, `cfncc-flush`, `cfncc-flush-cache`) — options `--scheme`, `--domain`, `--zone`, `--path`, `--content-type`, `--nid`; naked run purges configured zone(s); paths/content-type/nid switch to targeted file purges. Interactive confirm (bypass with `-y`).
- `cloudflare-node-cc:attack-mode --zone=<id>` (aliases `cfncc-at`, `cfncc-attack-mode`) — sets the zone security level to `under_attack`; requires the request host to match the zone name.

## Event subscriber

`CloudflareClientIpRestore::onRequest()` (priority 20 on `KernelEvents::REQUEST`) — when `restore_client_ip` is enabled, sets `HTTPS` and `REMOTE_ADDR` from the request's `CF-Connecting-IP` header and calls `overrideGlobals()`, so Drupal attributes the request to the real client behind Cloudflare.
