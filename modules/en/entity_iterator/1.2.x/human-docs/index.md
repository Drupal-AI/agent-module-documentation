# Entity Iterator — manual setup guide

**Entity Iterator** (`entity_iterator`) is a small **developer utility** that lets
your code loop over a very large number of entities without running out of memory.
Loading every entity of a type at once can exhaust PHP's memory on a big site;
Entity Iterator avoids that by fetching the matching entity IDs, processing them in
**chunks** (50 at a time by default), loading one chunk at a time, and evicting each
processed entity from Drupal's `entity.memory_cache` as it goes — so memory usage
stays flat no matter how many entities you touch.

The class `Drupal\entity_iterator\EntityIterator` implements PHP's `Iterator`,
`ArrayAccess` and `Countable` interfaces, so you can drop it straight into a
`foreach`, count it with `count()`, and probe or remove items by entity‑ID offset.
It is designed for update hooks, Drush scripts, migrations and cron jobs — anywhere
code must process every entity of a type or bundle.

There is **no admin interface, no settings, and no web surface** — you use it
entirely from PHP. This is worth knowing for safety: the internal ID query runs with
access checking turned off by design (it is a low‑level maintenance helper, like any
batch or CLI script), so if your code exposes results to users it is up to that code
to enforce access. There is no way for an unauthenticated or low‑privileged web user
to invoke it directly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is nothing to configure. Once enabled, the `EntityIterator` class is available
to your code.

## How to use it

Enable the module, then use the class from PHP. The constructor takes an entity type
ID, an optional array of IDs (`NULL` loads all entities of that type), an optional
chunk size (default 50), and an optional bundle to filter on:

```php
use Drupal\entity_iterator\EntityIterator;

// Iterate every node, memory-safely.
foreach (new EntityIterator('node') as $node) {
  // ... do work with $node ...
}

// Iterate only 'article' nodes, in chunks of 50.
foreach (new EntityIterator('node', NULL, 50, 'article') as $node) {
  // ...
}

// Iterate a specific set of IDs.
foreach (new EntityIterator('node', [1, 2, 3]) as $node) {
  // ...
}
```

Because it is `Countable` and supports array access, you can also call
`count($iterator)`, check membership with `isset($iterator[$id])`, fetch one entity
with `$iterator[$id]`, and drop one from the remaining iteration with
`unset($iterator[$id])`. Remember that the ID query uses access checking off — add
your own access checks if you surface the results to users.
