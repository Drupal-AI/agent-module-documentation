# Pax — manual setup guide

**Pax** (`pax`) is a developer and deployment tool that tackles one very specific
team pain point: the huge, hard-to-merge YAML files that Drupal produces when you
export configuration. Large config entities — entity view displays, entity form
displays, field configs — end up as single files whose git diffs constantly
collide, and when two branches touch the same display the merge can be miserable
because the settings of different fields melt into one another.

Pax solves this by **sharding** those big config entities into many small files —
roughly one YAML file per field, per display mode — so that two developers editing
different fields of the same display no longer touch the same file. Merges become
clean, and the rare remaining conflict is usually trivial (a weight that changed
in both branches). It does this by replacing Drupal's config file-storage class,
so Drupal and Drush see no difference — the shards are still ordinary YAML, just
laid out across subdirectories.

There is **no admin UI and no settings form**. Pax works at the file-storage
level and ships a Drush command for CLI workflows. The one thing it *does* require
beyond enabling the module is two lines in `settings.php` so that Drupal can read
the shards back in — see [Installation](installation/index.md) for exactly what to
add.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the two
   required `settings.php` lines, and enable the module.

There is **no configuration page** — Pax has no settings form. It changes how the
config sync directory is laid out on disk and is driven entirely by the normal
config export/import (and its Drush command).

## How to use it

Once the module is enabled and the `settings.php` lines are in place, just export
configuration the way you always do (`drush config:export`). Pax writes the
shardable sections to their own files automatically:

- `entity_view_display` entities shard their `content` section — one file per field.
- `entity_form_display` entities shard both `content` and the Field Group
  third-party settings (`third_party_settings.field_group`) — one file per field
  and one per group.
- `field_config` entities that reference Paragraphs shard the "paragraph types for
  this field" setting — one file per paragraph type.

On config import the shards are recombined transparently, so nothing downstream
needs to change. The main caveat to keep in mind: tools that read your
`config/sync` files *without* going through Drupal's APIs (and that expect the
classic one-file-per-entity layout) may not understand the sharded structure —
the files are still valid YAML, but they live in subdirectories.
