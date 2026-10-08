<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
State Expirable adds expiration (TTL) to Drupal's State API, exposing a `state_expirable.state` service that stores values which automatically expire after a given time.
---
Where core's `State` service persists key/value data indefinitely in the `keyvalue` store, this module's `StateExpirable` service is constructed with both `@keyvalue` and `@keyvalue.expirable` and offers the familiar `get/set/getMultiple/setMultiple/delete` surface plus a TTL on writes, so values are dropped once expired. It is a developer building block — there are no routes, permissions, forms, or admin UI — intended to be injected into other code that needs short-lived server-side state (transient flags, rate-limit windows, cached remote lookups) without abusing the cache system or leaving stale keys around forever.

There is no request surface and nothing to configure through the UI, so the security posture is neutral: it is only reachable from server-side PHP that already holds a service reference. Setup is simply enabling the module and injecting/`\Drupal::service('state_expirable.state')` where expiring state is needed.
---
- Enable the module to get the `state_expirable.state` service.
- Inject `state_expirable.state` into a custom service.
- Store a state value that expires after N seconds.
- Read an expirable state value with `get()`.
- Set multiple expirable values at once with `setMultiple()`.
- Read multiple expirable values with `getMultiple()`.
- Delete an expirable state key with `delete()`.
- Implement a time-boxed feature flag.
- Cache a remote lookup result with a short TTL.
- Track a rate-limit window in expiring state.
- Store a transient "last run" marker that self-cleans.
- Avoid stale permanent State keys for temporary data.
- Back a one-time notice that disappears after a period.
- Hold a short-lived token/nonce server-side.
- Use it instead of cache for semantically-stateful data.
- Combine core keyvalue and keyvalue.expirable via one service.
- Prototype TTL-based flags without custom storage.
- Clear expired values automatically via the expirable backend.
