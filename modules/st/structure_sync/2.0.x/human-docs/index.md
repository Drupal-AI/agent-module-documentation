# Structure Sync — manual setup guide

**Structure Sync** (`structure_sync`) lets you move three kinds of *content that
behaves like configuration* — **taxonomy terms**, **custom (content) blocks**, and
**menu links** — between environments. Drupal's core configuration management moves
*configuration*, but these three are stored as *content* entities, so they don't
travel with `drush config:export`. Structure Sync bridges that gap: it exports them
into a single config object (`structure_sync.data`) that you commit and deploy like
any other config, then imports them back into real entities on the target.

Each of the three types has its own **export** and **import**, plus "export all" /
"import all" shortcuts. Imports come in three styles so you can decide how
aggressively the target should match the source: **safe** (only add what's missing,
never update or delete), **full** (safe, plus update entities that already exist),
and **force** (delete everything of that type first, then recreate from config).
Entities are matched by **UUID**, so re‑running an import is idempotent — it won't
create duplicates.

Everything is available both as **admin screens** under *Structure → Structure
Sync* and as **Drush commands** (`export-taxonomies`, `import-menus`,
`export-all`, and so on), which makes it easy to script into a CI/CD deploy step. A
general settings screen has a single option: toggle logging of the module's
operations. Structure Sync depends on core **Taxonomy**, **Menu link content**, and
**Block**. It defines no permissions of its own — all screens are gated by the core
**Administer site configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the export/import screens, the
   `structure_sync.data` config object, the import styles, and the general
   settings.

## Where it lives in the admin menu

Structure Sync lives at **Structure → Structure Sync**
(`/admin/structure/structure-sync`). From there you reach the general settings form
and the per‑type export/import screens for taxonomies, blocks, and menu links. All
screens require the **Administer site configuration** permission.

## How to use it

1. On the **source** environment, open *Structure → Structure Sync*, go to the type
   you want (taxonomies / blocks / menu links), and click **Export** (or use
   *export all*). This writes the data into `structure_sync.data`.
2. Commit `structure_sync.data.yml` and deploy it like any other config
   (`drush config:import` on the target).
3. On the **target** environment, run the corresponding **Import** and pick a style
   (safe, full, or force) to turn the data back into entities.

See [Configuration](configuration/index.md) for the details of each step.
