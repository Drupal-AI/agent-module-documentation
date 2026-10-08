# Update Config Entity — manual setup guide

**Update Config Entity** (`update_config_entity`) is a one‑command repair tool for
a single, specific Drupal error:

> *A non-existent config entity name returned by
> FieldStorageConfigInterface::getBundles()*

Drupal keeps an internal key‑value store, `entity.definitions.bundle_field_map`,
that maps each entity type's fields to the bundles that use them. If a bundle
disappears without that map being updated — an uninstall that didn't clean up, a
botched migration, a comment type deleted outside the UI — the map still claims a
field exists on a bundle that's gone. Drupal then throws the `getBundles()` error,
often blocking a cache rebuild or the Field UI. There's no admin screen for editing
that store, which is exactly why this module exists.

The module is deliberately tiny: it provides one Drush command that loads the map,
removes the stale bundle entry for the field you name, and writes it back. That's
the whole module — no hooks, no config, no permissions, no UI. Once your site is
repaired, you can uninstall it.

This guide is written for a **human** performing a repair. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is **no configuration** — you run a single Drush command. The command takes
three arguments: the entity type, the bundle, and the field name. The error
message itself normally tells you the entity type and bundle (for example "entity
type comment, bundle comment").

```bash
# Remove the stale mapping, then rebuild caches:
drush update:correct-field-config-storage comment comment field_foo
drush cr
```

You can inspect the map before and after to confirm the fix:

```bash
drush php:eval '
$map = \Drupal::keyValue("entity.definitions.bundle_field_map")->get("comment");
print_r(array_map(fn($f) => array_keys($f["bundles"] ?? []), $map));'
```

### Cautions

- The command edits a **derived, cache‑like store**, not real config. If the
  underlying cause still exists (some field storage still referencing the bundle),
  the entry can reappear on the next rebuild — fix the root cause as well.
- There is **no dry‑run and no confirmation**, so get the three arguments right.
  If you want a record, dump the store first with the `php:eval` snippet above.
- The module has no other purpose — **uninstall it once the site is repaired**.

## Where it lives in the admin menu

Nowhere — this module has no admin screens or settings. It works purely through the
`drush update:correct-field-config-storage` command.
