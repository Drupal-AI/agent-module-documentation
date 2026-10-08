<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Device rendering API

Screens fetch their content from the framework's own HTTP endpoints rather than normal Drupal pages.

## `/api/digital_signage`  (Controller\Api)
- Access: `_custom_access` = `Api::access()`. Requires either the `digital signage framework access preview` permission (editors previewing in the UI) **or** a valid per-device fingerprint in the `x-digsig-fingerprint` header.
- Fingerprint: `Crypt::hmacBase64($device->extId(), Settings::getHashSalt() . $device->id())` (see `Api::fingerprint()`). Compared with `!==` (not `hash_equals()`).
- `access()` also confirms the device has a schedule and, for entity requests, that the requested `entityType`/`entityId` is actually present in the device schedule or the emergency list before allowing.
- Query params: `deviceId` (loads the Device), `mode` (`load`/`preview`/`schedule`/`diagram`/`screenshot`/`log`), `type` (`html`/`css`/`content`/...), `entityType`, `entityId`, `contentPath`, `storedSchedule`.
- Options: `_maintenance_access: TRUE`, `no_cache: TRUE`.

## `/api/digital_signage/block/{id}`  (Controller\BlockApi)
- Access: `_permission: 'access content'`.
- Loads the block config entity `{id}` and renders it via the block view builder with `max-age: 0`. Renders directly, so a block's own visibility conditions are not applied here.

## Middleware
`digital_signage_framework.middleware` (priority 260) intercepts requests under `/sites/default/files/languages/` and, when the file is missing, serves the locale JS translation recorded in `state('locale.translation.javascript')` — a language-file fallback for offline screens.
