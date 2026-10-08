# Migrate Scanner — manual setup guide

**Migrate Scanner** (`migrate_scanner`) changes how Drupal *finds* your migration
definitions. Out of the box, core's migration discovery is deliberately flat: it
reads `migrations/*.yml` inside each module and stops there — it does not descend
into subdirectories. That is fine for a handful of migrations, but painful on a
big project with dozens or hundreds, where the only way to impose order is a
naming convention baked into the filenames.

Migrate Scanner swaps that discovery component for a **recursive** one. Once it's
enabled, your migration YAML can live in subdirectories:

```
migrations
 ├─ foo
 │   ├─ foo_bar.yml
 │   └─ foo_foo.yml
 └─ bar
     └─ baz
         └─ bar_baz.yml
```

So you can organise a large migration by entity type or source system —
`migrations/nodes/`, `migrations/media/`, `migrations/users/` — and keep the top
of the folder tidy.

The important thing to understand is that this is **purely organisational**. The
same migrations run in exactly the same way; the only thing that changes is *where
the files are allowed to live*. If a migration misbehaves, this module is almost
never the cause. As a bonus it also provides a hook you can implement to refine
the list of discovered migrations (documented in the module's `.api.php` file). It
depends only on core **Migrate**, adds no admin UI, no permissions, and no
configuration — and its core requirement (`^10 || ^11 || ^12`) already covers
Drupal 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — as the maintainers put it,
"there are no UI and configuration options — you just need to enable the module."

## How to use it

There is nothing to *use* in the traditional sense — once enabled, recursive
discovery is simply active. Move (or create) your migration YAML files into
subdirectories of `migrations/` however you like, and they will be found. To
confirm nothing changed behaviourally, run:

```bash
drush migrate:status
```

The output is the same as before; only the paths the files may live in have
widened.
