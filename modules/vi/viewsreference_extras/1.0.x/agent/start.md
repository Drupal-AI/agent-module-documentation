<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Reference Extras (viewsreference_extras) — agent index

A companion to **Views Reference Field** (`viewsreference`) whose **single feature** is a
drop-in replacement for the `viewsreference.compression` service. It cures **HTTP 414
(URI Too Long)** errors that AJAX-enabled viewsreference embeds hit when a field carries a
large settings payload (e.g. a term filter with hundreds of checkboxes). Version **1.0.3**,
core `^10.2 || ^11`. Requires `views` and `viewsreference`; test dependency on
`views_ajax_history`.

## What it actually does (not "per-embed options")

Parent `viewsreference`, when an embed runs with AJAX (pager / exposed filter / sort),
gzip-packs the **entire** `#viewsreference` array — including the serialized `data` blob of
every setting plugin — into a `compressed` query parameter so the reloaded view rebuilds
identically. For heavily-configured fields even the compressed string exceeds the server's
URI limit → **414**.

This module re-declares the **same service id** `viewsreference.compression`
(`viewsreference_extras.services.yml`) pointing at `ViewsReferenceExtrasCompressionReload`:

- **`compress()`** — strips the bulky `data` (and any prior `compressed`), stores only a small
  `reload` param: a gzip-packed JSON pointer of `parent_entity_type`, `parent_entity_id`,
  `parent_revision_id`, `parent_entity_langcode`, `parent_field_name`, `field_item_delta`.
- **`uncompress()`** — loads that entity (specific revision via `loadRevision()` when present),
  restores the recorded **translation**, checks **`$entity->access('view', $currentUser)`**,
  then re-reads the `data` blob straight from the field item(s) with
  `unserialize(..., ['allowed_classes' => FALSE])`.

Net effect: the AJAX URL stays short regardless of how many options the field has, because the
settings are reloaded **from the source entity** instead of the query string.

The swap is **global and automatic** — every viewsreference field uses the reload strategy once
enabled. No admin UI, no per-field opt-in, no config, no permissions, no Drush commands, no
new fields or ViewsReferenceSetting plugins.

## Files

- `src/ViewsReferenceExtrasCompressionReload.php` — the whole feature (implements
  `ViewsReferenceCompressionInterface`).
- `viewsreference_extras.services.yml` — overrides `viewsreference.compression`.
- `tests/` — functional-JS 414-scenario test (uses `views_ajax_history`) + kernel langcode/
  translation-restore test.

## Solution docs

- `agent/services/compression-reload.md` — the compression-reload mechanism in detail
  (interface contract, the two methods, the reload pointer fields, revision/translation handling,
  the access guard).

## Key facts

- Overriding the service is the **only** integration point; there is nothing to call from code.
- Correct behaviour depends on the parent formatter recording the parent-entity pointer fields
  on `#viewsreference` (it does, in `ViewsReferenceFieldFormatter` / `ViewsReferenceLazyFieldFormatter`).
- The reload path re-reads settings from the **live** entity, so an embed's AJAX response reflects
  the entity's current stored settings/revision, not a snapshot frozen in the URL.
