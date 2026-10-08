<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stack Reporter provides a sync endpoint for your StackReporter subscription.

---

Stack Reporter provides a **sync endpoint for a StackReporter subscription** — StackReporter is an
external service that tracks your stack, and this exposes `/api/v1/stack-reporter` returning the site's
**Drupal, PHP and Node versions** so the service can monitor them. It provides its own permissions, in the
Utilities package.

Use it to report stack versions to StackReporter. It is a monitoring/integration feature. Its endpoint is
**API-key-gated**: the `access()` check requires a non-empty `apikey` in the request body to match the
configured key (`$externalKey && $internalKey === $externalKey`) — so it correctly denies when no key is
supplied (no empty-key bypass). Two notes: the endpoint **discloses a version fingerprint** (Drupal/PHP/Node
versions) to whoever holds the key, so keep the **API key secret**; and the key comparison uses `===` (strict,
but not constant-time — a minor timing consideration). It has no other access-control role. Configure the API
key.

---

- Expose a StackReporter sync endpoint.
- Report Drupal/PHP/Node versions.
- Let StackReporter monitor the stack.
- Gate the endpoint by API key.
- Require a non-empty matching key (no empty bypass).
- Provide its own permissions.
- Keep the API key secret (version fingerprint).
- Note the key compare is === (minor timing).
- Have no other access-control role.
- Configure the API key.
- Handle the endpoint.
- Report versions.
- Configure the key.
- Handle the integration.
- Sync stack data.
- Secure the endpoint.
- Handle monitoring.
- Report the stack.
- Set the key.
- Provide a report endpoint.
