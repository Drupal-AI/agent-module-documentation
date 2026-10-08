# Migrate DC — manual setup guide

**Migrate DC** (`migrate_dc`) — "Migrate Default Content" — is a toolkit of
Migrate plugins for filling a Drupal site with **default or dummy content**. It's
aimed at distributions, demos, and seed data: instead of storing example content
as JSON/YAML files (which get hard to maintain), you describe it as migrations
and let these plugins do the fiddly parts — reading long text from files, hashing
plain passwords, parsing dates, resolving UUID references, and so on.

The problem it solves is the awkwardness of hand‑writing default‑content
migrations. Migrate DC ships several **process plugins** plus a couple of **source
plugins** (JSON and YAML) that plug straight into a normal Migrate/Migrate Plus
setup, so common seed‑content chores become one‑line steps in your migration YAML.

There is **no settings form** — the module is consumed entirely from migration
configuration. It depends on core **Migrate** and **Migrate Plus**
(`migrate_plus`), and the **3.x** branch targets **Drupal 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate Plus dependency.

There is **no configuration page** for this module — you use its plugins from your
migration YAML, summarised below.

## How to use it

Migrate DC provides these building blocks for your migrations.

**Process plugins:**

- `migrate_dc_file_content` — reads content from external files, handy for long
  text fields.
- `migrate_dc_plain_password` — hashes plain‑text passwords so imported users can
  log in.
- `migrate_dc_shipment_item` — helps migrate shipment items for Drupal Commerce.
- `migrate_dc_str_to_time` — accepts any date format that PHP's `strtotime()`
  understands and outputs a configurable format.
- `migrate_dc_uri_transformator` — transforms a UUID reference such as
  `entity.uuid:node/MY-UUID` into an id reference like `entity:node/42`.

**Source plugins:**

- `migrate_dc_json` — read source rows from JSON.
- `migrate_dc_yaml` — read source rows from YAML.

Reference these plugin ids in the `process:`, `source:` and `destination:`
sections of your migration YAML, then run the migrations with core Migrate /
Migrate Plus (`drush migrate:import …`).
