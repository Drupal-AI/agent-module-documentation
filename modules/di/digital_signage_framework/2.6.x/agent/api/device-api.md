<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Device rendering API

Screens fetch their content from the framework's own HTTP endpoints rather than normal Drupal pages.

## `/api/digital_signage`  (Controller\Api)
- Access: `_custom_access` = `Api::access()`. Requires either the `digital signage framework access preview` permission (editors previewing in the UI) **or** a valid per-device fingerprint in the `x-digsig-fingerprint` header.
- Fingerprint: `Crypt::hmacBase64($device->extId(), Settings::getHashSalt() . $device->id())` (see `Api::fingerprint()`). It is derived from the site hash salt, so it cannot be reproduced without that secret.
- `access()` also confirms the device has a schedule and, for entity requests, that the requested `entityType`/`entityId` is actually present in the device schedule or the emergency list before allowing.
- Query params: `deviceId` (loads the Device), `mode` (`load`/`preview`/`schedule`/`diagram`/`screenshot`/`log`), `type` (`html`/`css`/`content`/`image`/`video`), `entityType`, `entityId`, `contentPath` (base64), `storedSchedule`, `umlType`, `refresh`.
- `mode=schedule` returns the device's JSON playlist (items, underlays, overlays, emergency entities, rendered assets). `mode=load` returns rendered HTML/CSS or a binary (media file / content proxy). `mode=preview`/`diagram`/`screenshot`/`log` back the in-Drupal preview popup.
- The `type=content` load path proxies a URL built from the site's own front URL plus the decoded `contentPath`, forwarding the request's `Authorization` header, and caches the result under `temporary://` (offline content caching).
- Options: `_maintenance_access: TRUE`, `no_cache: TRUE`.

## `/api/digital_signage/block/{id}`  (Controller\BlockApi)
- Access: `_custom_access` = `BlockApi::access()`. Allowed for a user with `digital signage framework access preview`, or for a request whose `x-digsig-fingerprint` header matches a known device (reverse fingerprint→device lookup, cached at `digital_signage_framework:device_fingerprints`).
- `request()` renders the block only when `isSignageBlock()` passes: the block belongs to the default theme, sits in one of `Regions::ALL`, and its plugin definition carries `digitalsignage_refresh`. Everything else returns an identical `404` so block configuration cannot be enumerated. Rendered with `max-age: 0` under the default theme.

## Middleware
- `digital_signage_framework.middleware` (priority 260) intercepts requests under `/sites/default/files/languages/` and, when the file is missing, serves the locale JS translation recorded in `state('locale.translation.javascript')` — a language-file fallback for offline screens.
- Submodule `digital_signage_crowdsec` adds a middleware that disables the CrowdSec bouncer for the `/api/digital_signage` path so device polling is not throttled/blocked by CrowdSec.
