# Migrate Process Negate — manual setup guide

**Migrate Process Negate** (`migrate_process_negate`) is a tiny Migrate
*process plugin* whose only job is to logically invert the value that passes
through it — `true` becomes `false`, `1` becomes `0`, and vice versa. It solves a
very common migration annoyance: a source system stores a flag with the
*opposite* sense to the Drupal field you are mapping it onto.

The classic example is a source `is_deleted` flag. In Drupal you usually want
that to drive the node's `status` (published) field — but the meaning is
reversed: when the source says "deleted" (`1`/`TRUE`), the Drupal node should be
*unpublished* (`0`/`FALSE`). Rather than writing a custom callback, you drop the
`negate` plugin into the process pipeline and it flips the value for you.

The module is pure migration tooling. It depends only on core's **Migrate**
module, adds no admin pages, no permissions, and nothing runs at request time —
it only transforms values under the control of a migration you write. There is
nothing to configure in the UI; you use it entirely from your migration YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

In a migration's `process` section, point the `negate` plugin at the source
property whose value you want to invert:

```yaml
process:
  status:
    plugin: negate
    source: is_deleted
```

Here, a source row where `is_deleted` is `1` (true) produces a `status` of `0`
(unpublished), and a row where `is_deleted` is `0` produces `1` (published) —
exactly the inversion you want. Run the migration as usual with
`drush migrate:import` and the value is flipped for every row.
