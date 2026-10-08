# Config Import Delete Entities — manual setup guide

**Config Import Delete Entities** (`config_import_de`) removes the roadblock that
happens when a configuration import wants to delete something that content still
depends on. If your import deletes a content type, a bundle, or a field, Drupal
refuses to proceed until you manually delete all the content that relied on it —
which is awkward during automated deployments, when switching between branches that
each define different entity types, or under a CI system like Jenkins. Worse, the
orphaned entities aren't always easy to find and delete by hand.

This module fixes that by **automatically deleting the affected content entities**
during the import, so the configuration import can carry on. It also offers a
**debugging mode** that instead just *lists* the entities that would (or need to)
be deleted, as entity-type/id pairs, so you can see the consequences before letting
it act. Both behaviours — the automatic deletion and the debug listing — can be
turned on or off independently to suit your workflow.

It requires no other modules and supports Drupal 8 through 11.

> **This deletes content — treat it with care.** The whole point of the module is
> that a *configuration* change (removing a content type or field) now triggers the
> **irreversible deletion of the associated content**. That's powerful and
> genuinely destructive. Any config import that touches content-bearing config
> must be reviewed with that in mind: run imports deliberately, use the debug mode
> first to confirm exactly what will be deleted, and always keep backups —
> especially on production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

The two behaviours are toggled on a small settings page at
**Configuration → Development → Configuration Import - Delete Entities**
(`/admin/config/development/config_import_de`), which has just two checkboxes —
**Delete detected entities** and **Debug mode** — that can be turned on or off
independently. The module then acts automatically during a normal config import.
Note that **Delete detected entities is on by default** once the module is enabled.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings page (above). Before relying on automatic deletion, turn on
   **Debug mode** so you can see which entities a given import would delete — they're
   reported as entity-type/id pairs.
3. Once you're confident, keep (or enable) **Delete detected entities** so that
   `drush config:import` (or a UI import) removes the orphaned content and completes
   without manual intervention.
4. Because deletion is irreversible, take a database backup before importing config
   that removes content-bearing configuration.
