# Easy Migration — manual setup guide

**Easy Migration** (`easy_migration`) is a developer toolkit that provides base
code and helpers for building content migrations in plain PHP. Its tagline says
it all — "because migrations are never easy!" — and its goal is to keep simple,
one-off content ports simple. Rather than layering the full Migrate framework's
YAML plugins over your data, you write a migration class that says where the
source content comes from and where it should be saved.

It takes a deliberately different, case-based approach from core's **Migrate**
module: you can pull from other Drupal entities or straight from database
queries, port content into any Drupal entity type (nodes/pages, taxonomy terms,
users, and so on), bring files across with the correct mappings, and lean on
image data so Media libraries are populated seamlessly. It depends on nothing but
Drupal core.

Because it is a code framework, there is **no configuration page and no
click-through UI** — you use it entirely by writing code. Once installed, you
create `EasyMigration` plugin classes that define how content is retrieved and
where it is written. The bundled **Easy Migration Example**
(`easy_migration_example`) submodule is the best starting point: it demonstrates
porting Drupal 7 content into the Drupal 10+ Entity API, and you can copy its
structure for your own migrations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the example submodule.

There is **no configuration page** for this module — it is a code framework with
no settings form. You configure it by writing `EasyMigration` plugin classes, as
described below.

## How to use it

1. Enable Easy Migration (and, to learn from a working example, the
   `easy_migration_example` submodule).
2. Create an `EasyMigration` plugin class for each migration. In it you define
   how the source content is retrieved (from another Drupal entity, or a raw
   database query) and which Drupal entity, fields, and files it maps to.
3. Model your class on `easy_migration_example`, which shows a Drupal 7 → Drupal
   10 Entity API port, including file and image/media handling.
4. Run your migration as a privileged, trusted operator — it processes source
   data with migration privileges, so validate your sources before running it on
   production content.
