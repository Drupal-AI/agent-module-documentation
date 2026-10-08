# CML Starter Demo — manual setup guide

**CML Starter Demo** (`cmlstarter_demo`) supplies demonstration content for a
[CML Starter](https://www.drupal.org/project/cmlstarter) shop. It imports example
commerce content through Drupal's Migrate framework (Migrate Tools / Migrate Plus),
with a YAML‑editable configuration, so you can populate a demo or evaluation site
with sample products and catalog data in one go.

Its job is to let you **see CML Starter working quickly** — rather than building
example products by hand, you enable this module and run its migration to fill the
store with illustrative content. The migration configuration is editable as YAML
(via the YAML Editor module), so you can tweak what gets imported.

This is a **demo/evaluation helper, not a production feature.** The content it
imports is illustrative and meant for demonstration; don't rely on it for a live
store. It's best used on a fresh CML Starter site while you're evaluating or
building.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate dependencies.

There is **no configuration page** — the module ships migrations you run (and can
edit as YAML). See "How to use it" below.

## How to use it

1. Make sure you have a working [CML Starter](https://www.drupal.org/project/cmlstarter)
   shop first — this module provides content *for* that structure.
2. Enable CML Starter Demo (see [Installation](installation/index.md)).
3. Run the bundled Migrate imports (via Migrate Tools — for example
   `drush migrate:import` for the module's migrations) to populate the store with the
   demo products and catalog content.
4. If you want to change what's imported, edit the migration configuration as YAML
   (the module depends on YAML Editor for this).

To remove the demo content later, roll back the migrations with Migrate Tools
(`drush migrate:rollback`).
