# Devel Generate Commerce — manual setup guide

**Devel Generate Commerce** (`devel_generate_commerce`) extends the **Devel
Generate** module to create dummy Drupal Commerce data — products, product types,
product variations, stores and orders — so you can populate a store with realistic
test content in seconds instead of hand-entering it. It's the Commerce counterpart
to Devel Generate's node/user/term generators.

You control how much to create (a specific amount of each Commerce entity type),
optionally delete existing data before generating, and even set how "old" the
generated products, product types, variations and orders should appear. The module
runs both from a small admin form and from a Drush command, so it fits into
scripted workflows too.

This is strictly a **development-only tool**. It mass-creates content, so **never
enable or run it on production** — it can flood a live store with fake products and
orders. Gate its permission to developers on non-production environments only. It
depends on **Commerce** (Core, Order and Product) and **Devel Generate**, provides
its own permission, and is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

There is no persistent settings form to document — the generator's options are set
each time you run it, either on its generate form or via Drush.

## Where it lives in the admin menu

Once enabled, the generator sits with the other Devel Generate tools at **Generate
commerce**, `/admin/config/development/generate/commerce`.

## How to use it

**From the admin UI:** go to `/admin/config/development/generate/commerce`, set how
many of each entity type to create, optionally tick the "delete existing data"
option, adjust the age settings, and run it.

**From Drush:**

```bash
# Basic — generate with defaults
drush devel-generate:commerce

# Advanced — 10 products, deleting existing data first
drush devel-generate:commerce --products_num=10 --kill
```

Run this only on a development or staging site.
