<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multisite Status Report exposes a site's status report, enabled projects/updates and a compact summary as JSON endpoints authenticated with strong HMAC request signing, using only Drupal core.

---

It lets an external dashboard poll many sites for their core/module versions, available updates and security warnings without granting a login. Three read-only controller routes (`/multisite-status-report/status-report`, `/modules-updates`, `/summary`) require both the `access multisite status report` permission and the `multisite_status_report_hmac` auth provider. Requests are signed with HMAC-SHA256 over a canonical string; `HmacValidator` enforces a timestamp window (rejecting stale/future requests), a one-time nonce store to defeat replays, constant-time comparison via `hash_equals`, and an IP flood cap on invalid attempts. The signing secret is configured (and rotatable) on the settings form and never travels in the URL.

Set up by enabling the module, granting the permission to a dedicated service account, generating/rotating the shared secret at the settings route, then having the monitoring client sign each request with the timestamp, nonce and secret. The endpoints are marked `no_cache` so each poll returns live data.

---
- Poll a fleet of Drupal sites for their status report from one dashboard.
- Retrieve enabled projects with versions and available-update info as JSON.
- Fetch a compact one-object summary for a status wall.
- Authenticate machine requests with HMAC-SHA256 instead of a session cookie.
- Rotate the signing secret from the admin settings form.
- Grant `access multisite status report` to a dedicated service account only.
- Reject replayed requests via the one-time nonce store.
- Reject stale or clock-skewed requests via the timestamp window.
- Flood-limit invalid signing attempts per IP.
- Verify a signature offline with `HmacValidator::sign()` for client tests.
- Monitor available security updates across many sites centrally.
- Alert when a site falls behind on core or module versions.
- Feed the JSON into an external SIEM or uptime tool.
- Run the endpoints over HTTPS so the signature protects integrity, not secrecy alone.
- Add a per-site key id to distinguish signing keys.
- Keep the secret out of URLs and logs by signing headers.
- Build a cron job on the monitor side that signs and stores results.
- Compare update posture between staging and production sites.
- Detect a site that stopped responding to the poll.
- Confirm HMAC config by hitting `/summary` with a signed request.
