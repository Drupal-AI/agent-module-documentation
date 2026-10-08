<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Client Retry implements a retry middleware for Drupal's base HTTP client, retrying failed outbound requests.

---

HTTP Client Retry adds a retry middleware to Drupal's base HTTP client (Guzzle) — automatically
retrying outbound HTTP requests that fail transiently (network blips, 5xx, timeouts), improving resilience of
integrations that call external APIs. It is configured at `http_client_retry.settings` and provides its own
permissions.

Use it to make outbound API calls more robust. It is a developer/integration feature affecting how the HTTP
client retries; it does not change TLS/verification behaviour (retries use the same request options). Note:
tune the retry count/backoff sensibly (excessive retries can amplify load on a failing dependency or delay
error surfacing), and be aware retries re-send the request (fine for idempotent calls; be careful with
non-idempotent POSTs). It has no content-access role. Configure the retry policy.

---

- Retry failed outbound HTTP requests.
- Add a retry middleware.
- Handle transient failures.
- Retry on 5xx/timeouts.
- Improve integration resilience.
- Configure at http_client_retry.settings.
- Provide its own permissions.
- Not change TLS/verification behaviour.
- Tune retry count/backoff.
- Be careful retrying non-idempotent POSTs.
- Avoid amplifying load on a failing dependency.
- Have no content-access role.
- Make API calls robust.
- Configure the retry policy.
- Retry transient errors.
- Handle network blips.
- Retry requests.
- Configure retries.
- Improve outbound resilience.
- Add HTTP retries.
