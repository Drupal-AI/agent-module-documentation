# Cached Computed Field — manual setup guide

**Cached Computed Field** (`cached_computed_field`) provides field types that store an
expensive computed value in normal field storage and refresh it in the background,
so page requests never pay the computation cost. If you have a field whose value
comes from something slow — an external API call, a heavy database aggregate — a
normal computed field recalculates it on every render. This module instead persists
the last computed value (together with an `expires` timestamp) and only recomputes it
in the background, on cron, once it goes stale. Reads stay cheap; the expensive work
happens out of band.

It ships cached-computed field types for string, long string, text, long text,
integer, decimal, float, and boolean values. Under the hood, cron drives a manager
that finds items whose `expires` has passed, queues them, and dispatches a refresh
event for each one.

**This is a developer module: it stores the value but does not know how to compute
it — you supply that.** You write a small event subscriber that listens for the
refresh event, computes the value for the fields you own, and writes it back. Without
a subscriber, the fields simply keep their last value. There is a settings form (at
`/admin/config/cached_computed_field/settings`, gated by the core *access
administration pages* permission) for tuning refresh behaviour, but the real work is
in your subscriber code.

The module works on Drupal 8.9, 9.1, 10, and 11.

This guide is written for a **human** setting the module up. For the code — the event
subscriber pattern, the manager service, and the field-type machine names — read the
sibling [`agent/`](../agent/start.md) docs, especially
[`agent/extend/subscriber.md`](../agent/extend/subscriber.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form sits at **Configuration → Cached Computed Field**
(`/admin/config/cached_computed_field/settings`), reachable with the **access
administration pages** permission. It tunes refresh behaviour; the field types
themselves are added to entities through the usual **Manage fields** UI.

## How to use it

1. Add a cached-computed field (for example a cached-computed integer) to an entity
   through **Manage fields**. Each item stores a value plus an `expires` timestamp.
2. Write an event subscriber (extending the module's `RefreshExpiredFieldsSubscriberBase`)
   that listens for the refresh event, computes the value for your fields, and stores
   it. See [`agent/extend/subscriber.md`](../agent/extend/subscriber.md) for a worked
   example.
3. Make sure **cron runs regularly** — it drives the whole refresh cycle. How fresh
   the values stay depends on your cron frequency and the field's configured max-age.
