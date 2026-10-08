<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cached Computed Field provides field types that cache the result of an expensive computation in normal field storage and refresh it in the background once it goes stale, so page requests never pay the computation cost.

Each field stores a value plus an `expires` timestamp. On cron, `cached_computed_field_cron()` either processes the refresh queue or repopulates it: `CachedComputedFieldManager` scans entities for cached-computed fields whose `expires` has passed, queues `ExpiredItem`s, and for each dispatches a `RefreshExpiredFieldsEvent`. Your module subscribes (extending `RefreshExpiredFieldsSubscriberBase`) to recompute and write the fresh value back via `updateFieldValue()`. Field types are provided for string, string-long, text, text-long, integer, decimal, float, and boolean values. A settings form (under `/admin/config/cached_computed_field/settings`) tunes refresh behaviour; the integer field also reuses core number widget/formatter.

Typical setup: add a cached-computed field to an entity, then write an event subscriber that listens for the refresh event, computes the value for the fields you own, and stores it — cron keeps it fresh.

---

Short summary: fields that cache costly computed values in storage and refresh them via cron + queue + an event.

It solves the performance problem of “computed” fields that recalculate on every render (an API call, a heavy aggregate): here the value is persisted and only recomputed in the background when its TTL expires, so reads are cheap. It works through a manager that finds expired items, a queue worker driven by cron, and a `RefreshExpiredFieldsEvent` your code subscribes to.

Operationally: the only route is the admin settings form (permission *access administration pages*). The heavy lifting is in your subscriber; without one, fields keep their last value. Refresh cadence depends on cron frequency and configured max-age.

---

- Cache an expensive computed value (e.g. an external API result) in a field.
- Add a cached-computed string / text / integer / decimal / float / boolean field.
- Refresh stale field values automatically on cron.
- Offload recomputation to Drupal's queue system.
- Write an event subscriber to recompute your field's value.
- Store a value with an `expires` timestamp per item.
- Serve cheap reads while recomputation happens in the background.
- Repopulate the refresh queue when it empties (handled on cron).
- Tune refresh behaviour on the settings form.
- Use `CachedComputedFieldManager` to find expired field items.
- Recompute values in bulk via the queue worker.
- Subscribe to `RefreshExpiredFieldsEvent` for targeted field updates.
- Extend `RefreshExpiredFieldsSubscriberBase` for boilerplate helpers.
- Update a field value in code with `updateFieldValue()`.
- Cache aggregates (counts, sums) that are costly to compute live.
- Reuse core number widget/formatter for the integer field type.
- Avoid per-request computation on high-traffic pages.
- Control the field's staleness window via configuration.
- Populate initial values on cron's first queue run.
- Integrate slow third-party lookups without blocking page render.
