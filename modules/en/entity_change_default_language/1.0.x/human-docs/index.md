# Entity Change Default Language — manual setup guide

**Entity Change Default Language** (`entity_change_default_language`) is a small
developer and command-line utility for multilingual sites. On a translated
content entity, one language is the *default* (original, source) language and the
rest are translations of it. This module changes which language holds that
"original" role — promoting an existing translation (or a newly created one) to
become the source, and optionally pruning the translations you no longer want.

It is most useful for cleaning up content that was created under the wrong
original language: content imported with the wrong source locale, entities
authored before a site's default language was changed, or a multilingual site you
want to normalise so everything shares one consistent source language. Because it
recurses into `entity_reference` and `entity_reference_revisions` fields, a
paragraph or reference tree is re-based to the new default language together with
its host entity.

There is **no UI, no settings form, no permissions, and no routes** — this is a
service and a pair of Drush commands. You either call the
`entity_change_default_language` service from your own code, or run the Drush
commands to convert one entity or an entire entity type (the whole-type command
queues the work so large sites can process it on cron without timing out). Saves
are done with syncing enabled and without creating a new revision, so it does not
bump revision history.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — this module has no admin pages. Everything happens through Drush or the
`entity_change_default_language` service in code.

## How to use it

### The Drush commands

**Change one entity** with `ecdl:cdl`:

```bash
# Make Spanish the default/original language of node 1
drush ecdl:cdl node 1 es
```

The command validates that the entity type exists and is translatable and that
the target langcode is valid, then asks you to confirm (the default answer is
*No*). Two options fine-tune it:

- `--preserve-legacy-default-language` (default **on**) — keeps the old default
  language as a translation rather than dropping it.
- `--preserve-languages` — a comma-separated list of translation langcodes to
  keep; any translation not listed is removed. For example
  `drush ecdl:cdl node 1 en --preserve-languages=en`.

**Change every entity of a type** with `ecdl:dlet`:

```bash
# Re-base every node to English as the default language
drush ecdl:dlet node en
```

This finds all entities of the type whose language differs from the target,
optionally filtered with `--bundle`, reports the count, confirms, and then
**enqueues** one item per entity onto the `entity_change_default_language` queue.
It does *not* process them inline — the queue runs on cron, or you can drain it
immediately with:

```bash
drush queue:run entity_change_default_language
```

`ecdl:dlet` accepts the same `--bundle`, `--preserve-legacy-default-language`, and
`--preserve-languages` options.

### The service (for custom code)

Call the `entity_change_default_language` service and its `update()` method:

```php
\Drupal::service('entity_change_default_language')->update(
  $entity,            // a translatable content entity
  'es',               // the langcode that should become the new default
  TRUE,               // $create: create the target translation if missing
  ['es', 'en'],       // translations to preserve; others are removed
);
```

It returns `TRUE` on success (or when there is nothing to do) and `FALSE` if the
entity is not translatable or an exception was caught (which is logged).

### Good to know

- **No new revision.** Saves force syncing on and skip creating a new revision,
  so hooks that key off normal saves or revision creation may not fire as usual.
- **Not transactional.** A failure part-way through is logged and returns `FALSE`,
  but partial saves may already have happened — test on a copy before running it
  across a large reference graph.
- **References come along.** Referenced content entities (paragraphs, references)
  are re-based with the same target language and preserve options, and a static
  guard stops the same entity being processed twice in one run.
