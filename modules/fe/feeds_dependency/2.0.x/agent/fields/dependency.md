<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a feed dependency (base fields)

There is **no settings form**. A dependency is declared per-feed using two base fields the module
adds to the `feeds_feed` entity in `feeds_dependency_entity_base_field_info()`
(`feeds_dependency.module`). Both appear on the feed's edit form.

| Field (machine name) | Type | Label | Default | Widget (form) | Notes |
|---|---|---|---|---|---|
| `feed_dependency_id` | `entity_reference` → `feeds_feed` | Feed dependency | none | `entity_reference_autocomplete` (weight 5, `match_operator: CONTAINS`, size 60) | Revisionable, translatable. `handler: default`, `target_bundles: NULL` (any feed type), `auto_create: FALSE`. Multi-value is allowed by the base-field cardinality; each referenced feed is imported first. |
| `clear_dependency` | `boolean` | Clear the dependency. | `TRUE` | `boolean_checkbox` (weight 15) | Revisionable, translatable. When `TRUE`, clearing (Delete items) this feed also clears the referenced dependency feed — see [../hooks/import-order.md](../hooks/import-order.md). |

Both fields are `setDisplayConfigurable('form', TRUE)` / `('view', TRUE)`, so their placement can be
moved on the feed type's *Manage form display* / *Manage display*.

## Set it in the UI
Edit a feed (`/feed/{id}/edit`), pick another feed in the **Feed dependency** autocomplete, and
leave/clear the **Clear the dependency.** checkbox as desired. Save. The next import of this feed
imports the referenced feed first.

## Set it in code
```php
/** @var \Drupal\feeds\FeedInterface $feed */
$feed->set('feed_dependency_id', $dependency_feed->id()); // or an array of ids
$feed->set('clear_dependency', TRUE);
$feed->save();
```
Reading it back:
```php
$deps = $feed->get('feed_dependency_id')->referencedEntities(); // FeedInterface[]
$cascade = (bool) $feed->get('clear_dependency')->value;
```

## Config-schema note
These are **code-defined base fields**, not configuration — the module ships no `config/schema` or
`config/install`. The dependency graph is entity data on each feed (stored/revisioned with the feed),
so it is not exported via config sync. Enabling the module applies the fields through the entity
definition update system (base-field install); no settings config object exists.
