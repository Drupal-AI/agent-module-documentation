<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# The `published_at` field — read, set, compute, integrate

## What it is
`hook_entity_base_field_info()` attaches a base field **`published_at`** to the `node` entity
type only. It is revisionable and translatable. The field type `published_at` extends core
`TimestampItem`, is declared `no_ui = TRUE` (you never add it via Field UI — it always exists),
`default_widget = "publication_date_timestamp"`, `default_formatter = "timestamp"`. Stored in
`node_field_data.published_at` / `node_field_revision.published_at` as a UNIX timestamp.

## Behavior (the whole point)
- While a node is **unpublished**, `published_at` is `NULL`.
- The **first** time a node is saved while published, `PublicationDateFieldItemList::preSave()`
  sets it to `\Drupal::time()->getRequestTime()`.
- Once set it is **not overwritten** on later saves/edits/unpublish/re-publish — it captures the
  original go-live moment. Set it explicitly to override this.

## Read it
```php
$ts = $node->get('published_at')->value;   // int timestamp, or NULL if never published
```

## Set / back-date it
Assign a UNIX timestamp before save. An explicit value wins over the auto-stamp:
```php
$node->set('published_at', 1600000000);    // back-date to a fixed moment
$node->save();
```
To clear it (so the next publish re-stamps): `$node->set('published_at', NULL);`.

## Computed `published_at_or_now`
A computed property (`\Drupal\publication_date\PublishedAtOrNowComputed`) returns the stored
timestamp, or the current request time when none is set — so display/embargo code always has a
value:
```php
$ts = $node->get('published_at')->published_at_or_now;   // never NULL
```

## Token
`publication_date.tokens.inc` exposes a node date token:
- `[node:published]` — publication date, formatted `medium`.
- Date sub-tokens work too: `[node:published:custom:Y-m-d]`, `[node:published:short]`, etc.
  (chained through the core `date` token type).

## Integrations (provided, no config)
- **Feeds** — `src/Feeds/Target/PublishedAt.php` provides a `published_at` import target so a
  feed column can populate the field.
- **Workbench Moderation** — an event subscriber
  (`PublicationDateSubscriber::onWorkbenchModerationStateTransition`) calls the field's
  `preSave()` on a moderation state transition so the date is stamped on publish.
- **Node Clone** — `hook_clone_node_alter()` resets `published_at` to `NULL` on a cloned node so
  the copy gets a fresh publication date.
- **Install back-fill** — `hook_install()` derives each existing node's `published_at` from its
  first published revision (MySQL/MariaDB + PostgreSQL only; other DBs show a warning). The
  module also sets its own module weight to 99 so it runs after Scheduler.
