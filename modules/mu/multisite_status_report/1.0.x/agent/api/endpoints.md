<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HMAC JSON endpoints

All three routes require permission `access multisite status report` and the `multisite_status_report_hmac`
authentication provider. Sign every request; unsigned/invalid requests are denied and flood-counted per IP.

## Routes
- `GET /multisite-status-report/status-report` — full core status report as JSON.
- `GET /multisite-status-report/modules-updates` — enabled projects, versions, available updates.
- `GET /multisite-status-report/summary` — compact status summary object.

## Signing (HmacValidator)
- Canonical string is HMAC-SHA256'd with the configured secret (`sign()`).
- Required headers: key id (optional), timestamp (Unix, within window), unique nonce, signature.
- Server checks: timestamp within `TIMESTAMP_WINDOW`, nonce not previously seen (key-value expirable store),
  `hash_equals(expected, given)`. Nonce is remembered for 2× the window to block same-window replays.
- Configure/rotate the shared secret at `/admin/config/development/multisite-status-report`.
