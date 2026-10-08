# Radioactivity — manual setup guide

**Radioactivity** (`radioactivity`) tracks how popular or "hot" your content is,
using a clever energy‑and‑decay model. You add a special **energy** field to a
content type; every time an entity is viewed, that field *emits* energy (its value
goes up), and Drupal's cron gradually *decays* the energy over time. The result is
that recently‑and‑frequently‑viewed content ranks highest, while interest in older
content naturally fades — so you can build "Trending now" or "Most viewed this
week" listings that stay fresh on their own.

You choose how energy behaves per field via a **profile**:

- **Count** — energy only goes up (+1 per view) and never decays; a plain view
  counter.
- **Linear** — energy rises on each view and loses 1 point per second.
- **Decay** — energy rises on each view and drops by half every configurable
  *half‑life* (exponential decay); this is the default and the most "trending"‑like.

The recommended field type stores the energy on a small dedicated entity that the
content *references*, so recording a view doesn't create a new revision of your node
on every page load. Radioactivity integrates with **Views** so you can sort or
filter "most popular" listings by energy, and it fires an event (and a Rules event)
when an item's energy cools below a cutoff — handy for automatically un‑featuring
stale content. There's also a Drush command to backfill references.

To keep view events accurate even behind aggressive page caches or a decoupled
front end, Radioactivity can send them through a standalone REST file endpoint
instead of the normal Drupal route. Note the emitted events are cryptographically
signed with your site's hash salt, so energy values can't be forged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — adding the energy field, the emitter
   formatter, the storage backend, and how decay/cron work.

## Where it lives in the admin menu

Radioactivity has **no central settings page**. All setup happens per field, on the
content type's **Manage fields**, **Manage form display**, and **Manage display**
tabs — plus one storage config object you set with Drush. See
[Configuration](configuration/index.md).

## How to use it

In short: add a **Radioactivity reference** field to your content type, set its
profile and decay options, set the field's **Emitter** formatter on *Manage
display* (which is what emits energy on view), choose a storage backend, and let
cron process and decay the energy. Then sort a view by the field to build your
"trending" listing. The full walkthrough is in
[Configuration](configuration/index.md).
