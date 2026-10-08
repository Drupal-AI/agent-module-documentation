# Migrate Source Queue — manual setup guide

**Migrate Source Queue** (`migrate_source_queue`) adds a Migrate *source plugin*
that lets items on a **Drupal queue** become the rows a migration processes.
Instead of migrating from a fixed source like a CSV or a database, you enqueue
work as it arrives and let Migrate consume it — which makes event‑driven and
incremental migrations possible.

The pattern is useful in a couple of ways. It can make your own custom API
endpoints or import forms faster: instead of creating or updating entities
immediately on each request, you drop a queue item and let a migration handle the
heavy lifting later. And because failed rows can be retried through the migrate
map, you can combine it with the **Dead Letter Queue** module to automatically
retry and then give up after a set number of attempts.

One thing to be clear about: this plugin **only consumes queue items** — it does
not create them. You are responsible for putting items on the queue yourself (via
`createItem()`), and the items must be arrays. It depends only on core **Migrate**
and ships a `migrate_source_queue_cron_example` submodule that shows how to process
the queue during cron (see below). It has no admin UI — you use it from your
migration YAML.

A word on trust: queued data is processed with migration privileges, so make sure
only trusted code enqueues items, and validate the data as you would any migration
source. The plugin itself has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the optional cron example submodule.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

In your migration file, use the `queue` source plugin, naming the queue to read
from and declaring the fields each queue item carries:

```yaml
source:
  plugin: queue
  # The queue from which items will be processed.
  queue_name: users
  # The queue-item array keys to expose to the migration. Can also be an
  # associative array with human-readable labels as the values.
  fields:
    - id
    - firstName
    - lastName
    - address
    - email
    - telephoneNumber
  # The primary key: a list of source columns, keyed by column name, with the
  # field storage definition as the value.
  keys:
    id:
      type: string
```

Alongside the keys you declare in `fields`, the plugin also exposes: `data` (the
same value you passed into `createItem()`), `item_id` (the unique ID returned by
`createItem()`), and `created` (the timestamp the item was queued).

### Processing the queue

Remember that this defines a migration *source*, not a queue worker — the queue
items do **not** process automatically during cron. This is deliberate (running
the migration directly is more efficient than a per‑item worker). If you want the
queue to drain on cron runs, look at the bundled
**`migrate_source_queue_cron_example`** submodule, which demonstrates exactly how
to wire that up. Otherwise, run the migration when you need it with
`drush migrate:import`.
