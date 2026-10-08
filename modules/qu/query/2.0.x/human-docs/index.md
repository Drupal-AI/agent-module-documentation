# Query — manual setup guide

**Query** (`query`) is a small **developer library**, not an end‑user feature. It
provides a `query` service for building generic, object‑oriented **Condition**
objects that describe *what* you want to query — without tying those conditions to
any particular storage or query system. You hand the Condition objects to a function
of your own, and that function decides how to turn them into a real query (a
database query, an API call, an entity query, and so on).

In practice you request the service and build conditions fluently, for example:

```php
/** @var \Drupal\query\Services\QueryInterface $q */
$q = \Drupal::service('query');

$conditions = [
  $q->condition('type')->isEqualTo('event'),
  $q->condition('month')->isBetween(2, 10)->isNotIn([3, 5, 7]),
];
```

Each Condition carries requirement groups, conjunctions, operators and values that
your consuming function reads back to assemble the actual query. The library is used
by tooling such as Form Factory Kits' `UserAutoCompleteKit` and `NodeAutoCompleteKit`.

Because it is a base library, there is nothing to click and nothing to configure —
you enable it so that other modules or your custom code can depend on the `query`
service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a developer library with
no settings form and no admin UI. It plays no role in access control; it simply
exposes the `query` service for code to use.

## How to use it

Enable the module so the `query` service is available, then request it in your own
code (via dependency injection or `\Drupal::service('query')`) to build Condition
objects, and write the consumer function that translates those conditions into your
target query. See the module's project page and the `agent/` docs for the full
operator list.
