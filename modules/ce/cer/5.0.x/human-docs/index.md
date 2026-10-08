# Corresponding Entity References (CER) — manual setup guide

**Corresponding Entity References** (`cer`) keeps two entity-reference fields in sync so
that references stay reciprocal. If entity A references entity B, CER automatically writes
the matching back-reference onto B — and removes it again when the forward reference goes
away. It is the Drupal 8+ successor to the old *Corresponding Node References* module, and
it saves you from writing custom code or fiddly Views "reverse reference" relationships
just to keep both sides of a relationship aligned.

You configure it with what CER calls a **preset**: a small piece of configuration naming
a *first field* and a *second field* (both plain entity-reference fields), the bundles
they apply to, and whether new back-references are added at the top or bottom of the list.
The two fields may even be the *same* field, which gives you a symmetric "related content"
relationship where each item lists the other. At runtime CER hooks into every entity save
and delete and updates the corresponding entity automatically. It ships one permission
(**Administer Corresponding Entity References**) and has no Drush commands, plugins or
extra dependencies.

Two things are worth knowing up front. First, CER only acts when an entity is **saved** —
changing a preset never rewrites existing content, so to apply a new preset to content
that already exists you re-save those entities. Second, **do not use the preset's
"Synchronize" tab**: in this release it is broken and deletes the preset instead of
syncing anything.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — create and manage presets that pair up two
   reference fields.

## Where it lives in the admin menu

Once enabled, CER's presets are managed at **Configuration → Content authoring →
Corresponding References** (`/admin/config/content/cer`), gated by the *Administer
Corresponding Entity References* permission.
