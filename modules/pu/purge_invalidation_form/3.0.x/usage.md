Purge Invalidation Form adds an admin form that invalidates cache items (URLs, paths, tags, wildcards, or everything) immediately through Purge's purgers, bypassing the Purge queue.

---

The module depends on `purge:purge` and provides a single admin form at
`/admin/config/development/performance/purge-invalidation-form`. It ships a Purge **processor** plugin
(`invalidation_form`, enabled by default) that authorises the direct invalidation. On the form you pick an
invalidation **type** — the select only lists types actually supported by the currently *enabled*
purger(s) (e.g. `url`, `path`, `tag`, `wildcardurl`, `wildcardpath`, `everything`) — and, for non-
`everything` types, enter one item per line in a textarea whose placeholder shows examples from the purger.
On submit, the `InvalidationManager` service builds Purge invalidation objects via the invalidation factory
and calls `purge.purgers->invalidate()` directly (no queue), then reports the per-item success/failure state.
Because it does not use the queue, invalidation happens synchronously in the request. Everything is gated by
the restricted `purge_invalidation_form purge invalidation` permission, and the form shows a helpful message
if no purger is loaded. Requires PHP 8.3.

---

- Immediately clear a specific URL from Varnish/CDN without waiting for the Purge queue/cron.
- Invalidate a batch of URLs by pasting one per line.
- Invalidate by internal path where the purger supports the `path` type.
- Invalidate one or more cache **tags** on demand (e.g. `node:123`).
- Invalidate by wildcard URL or wildcard path to clear a whole section.
- Purge **everything** in one click when the purger supports the `everything` type.
- Debug caching behaviour by forcing an on-demand invalidation and reading the result state.
- Verify a newly configured purger actually works by invalidating a test item.
- Bypass the queue entirely for time-sensitive content updates.
- Give editors/ops a UI to clear cache without Drush or terminal access.
- See only the invalidation types your enabled purgers can actually handle.
- Get example expressions per type from the purger's own examples.
- Trigger a synchronous purge and receive success/failure feedback per item inline.
- Call the invalidation logic programmatically via the `InvalidationManager` service.
- Reuse the `invalidation_form` processor as the authorising processor for direct invalidations.
- Clear stale pages after an emergency content fix on a CDN-fronted site.
- Confirm cache-tag invalidation is wired correctly end to end.
- Provide an ops runbook step ("purge this URL") that non-developers can follow.
- Log each direct invalidation to the module's logger channel for auditing.
