<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purger flow, tag conversion, overflow safeguard, diagnostics & config

## Install / enable

`drush en cloudflare_purger` (pulls in `key` + `purge`). Then:
1. Create a Key (`/admin/config/system/keys`) holding a Cloudflare API token that has the **Purge**
   permission for the zone.
2. Configure the purger at `/admin/config/services/cloudflare-purger` — enter the **Zone ID**
   (32-char hex) and select the **API token key**.
3. Add the **Cloudflare** purger in Purge (`/admin/config/development/performance/purge`) so the
   Purge pipeline routes invalidations to it, and confirm the
   *Cloudflare Purger Configuration* diagnostic is green.

## Purger plugin — `Plugin/Purge/Purger/CloudflarePurger`

`@PurgePurger(id = "cloudflare", types = {"tag","url","everything"}, multi_instance = FALSE)`.

`routeTypeToMethod()` maps: `tag`→`invalidateTags`, `url`→`invalidateUrls`,
`everything`→`invalidateEverything`; the fallback `invalidate()` throws (never expected).

Each method:
- chunks invalidations by `MAX_PURGES_PER_API_REQUEST = 100` (everything is a single call),
- sets each invalidation to `PROCESSING`,
- calls `cloudflarePurgeRequest()`,
- sets each to `SUCCEEDED` or `FAILED` based on the boolean result.

`invalidateTags` converts Drupal tags via the converter service before sending `{tags: […]}`.
`invalidateUrls` sends the raw expressions as `{files: […]}`. `invalidateEverything` sends
`{purge_everything: true}`.

`getIdealConditionsLimit()` = `MAX_PURGES_PER_API_REQUEST * 2` = 200 (max ~2 API calls/run).
`hasRuntimeMeasurement()` = TRUE.

### `cloudflarePurgeRequest(array $data): bool`

- Reads `zone_id` + `api_token_key` from `cloudflare_purger.settings`; resolves the token via
  `keyRepository->getKey($api_token_key)?->getKeyValue()`.
- `POST https://api.cloudflare.com/client/v4/zones/{zone_id}/purge_cache`, headers
  `Content-Type: application/json` + `Authorization: Bearer <token>`, `connect_timeout` 1.5s,
  `timeout` 3.0s, body = `json: $data`.
- Returns FALSE (and logs an error) on: any exception (token stripped from the message before
  logging), non-200 status, unparseable JSON / missing `success`, or `success: false` (Cloudflare
  `errors[].code/message` are folded into the log). Returns TRUE only on `200` + `success: true`.

## Tag conversion — `CloudflareTagsConverter` (service `cloudflare_purger.tags_converter`)

`convertDrupalTagsToCloudflareTags(array $drupal_tags): array`:
- prefix = `Settings::get('cloudflare_purger_cache_tag_prefix', Settings::get('hash_salt', ''))`,
- per tag: `substr(base_convert(hash('xxh3', $prefix . $tag), 16, 36), 0, 6)`.

Rationale (from in-code docs): Drupal tags are long and can blow past response-header limits, and
the same tag string must be unique per site so purges don't cross sites sharing one zone. Base-36
keeps it compact while staying uppercase (Cloudflare tags are case-insensitive); truncating to 6
chars trades a small collision risk (benign over-purge) for compactness.

## Tags header — `Plugin/Purge/TagsHeader/CloudflareTagsHeader`

`@PurgeTagsHeader(id = "cloudflare", header_name = "Cache-Tag", dependent_purger_plugins = {"cloudflare"})`.
`getValue($tags)` returns the converted tags joined by `,`. Purge attaches this to cacheable
responses; Cloudflare stores it for later tag-based purge.

## Overflow safeguard — `EventSubscriber/CloudflareTagsOverflowSubscriber`

Listens on `KernelEvents::RESPONSE` at priority **-1000** (after the upstream Purge subscriber),
main request only. If `strlen(Cache-Tag) > %cloudflare_purger.max_response_header_length%`
(default **16373** = 16384 − `strlen("Cache-Tag: ")`), it removes the `Cache-Tag` header and sets
`Cloudflare-CDN-Cache-Control: no-cache, no-store`. This marks the page uncacheable **at
Cloudflare only** (other caches may still cache it) so a page whose tags were dropped never becomes
permanently stale. Override the parameter in `services.yml` for hosts with smaller caps (Acquia:
`cloudflare_purger.max_response_header_length: 8181`).

## Diagnostic check — `Plugin/Purge/DiagnosticCheck/ConfigCheck`

`@PurgeDiagnosticCheck(id = "cloudflare_purger_config_check", dependent_purger_plugins = {"cloudflare"})`.
`run()` returns `SEVERITY_ERROR` if `zone_id` is empty, `api_token_key` is empty, or the referenced
Key entity does not exist; otherwise `SEVERITY_OK` ("Zone ID and API Token Key are set."). Surfaced
in Purge's status dashboard.

## Configuration reference

`cloudflare_purger.settings` (`config/schema/…`, `FullyValidatable`):

| key | type | constraints |
|-----|------|-------------|
| `zone_id` | string | `NotBlank`; `Regex ^[a-f0-9]{32}$` |
| `api_token_key` | string | `NotBlank`; `ConfigExists prefix key.key.` (must name an existing Key) |

Form `Form/CloudflarePurgerSettingsForm` (`ConfigFormBase`): `zone_id` textfield
(`#maxlength 32`, `#config_target`), `api_token_key` `#type key_select`. Route
`cloudflare_purger.settings` → `/admin/config/services/cloudflare-purger`, requires
`administer site configuration`, `_admin_route: TRUE`.
