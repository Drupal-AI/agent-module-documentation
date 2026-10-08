<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Client Retry — agent index

Adds a **retry middleware to Drupal's base HTTP client** (Guzzle) — auto-retry transiently-failing outbound
requests (5xx/timeouts/network blips). Config at `http_client_retry.settings`; provides permissions. Version
**2.0.2**. Core `^10.1||^11`.

Developer/integration — doesn't change TLS/verification (same request options). Tune count/backoff; careful
retrying non-idempotent POSTs. No content-access role.
