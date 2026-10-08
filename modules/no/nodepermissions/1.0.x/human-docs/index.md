# Granular Node Permissions — manual setup guide

**Granular Node Permissions** (`nodepermissions`) breaks apart one of Drupal's
broadest permissions into smaller, delegable pieces. By default, editing a node's
**administrative base fields** — the author (`uid`), published **status**, the
**created** ("Authored on") date, **promote** (promoted to front page), and **sticky**
(sticky at top of lists) — all require the sweeping **Administer content** (`administer
nodes`) permission. This module adds a **separate permission for each of those five
fields**, so you can grant just the capability a role needs.

It works through `hook_entity_field_access()`, granting edit access to each field to
holders of a dedicated permission (for example *administer node status*). That lets you,
say, allow a role to publish and unpublish content without also letting them change
authorship or add front‑page promotion. It depends only on core's **Node** module.

Two things are important to keep in mind. First, each of these permissions **delegates a
sensitive capability**, so grant them deliberately: *administer node uid* lets a user
change a node's author (effectively authorship spoofing), *administer node status* lets
them publish or unpublish, and *promote* / *sticky* affect front‑page placement and list
ordering. Second, the grants are **additive** — they *open up* these fields to whoever
holds the permission; they do not restrict anything beyond core's defaults, and holders
of the core **Administer content** permission still have full access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

Configuration is done entirely on Drupal's standard **Permissions** page — there is no
dedicated settings form. The steps are below.

## How to set it up

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the module's permissions page at
   **`/admin/people/permissions/module/nodepermissions`** (or find the section on the
   main **People → Permissions** page).
3. Grant each per‑field permission to the roles that should have it — for example give a
   "Section editor" role *administer node status* so it can publish/unpublish, while
   withholding *administer node uid* so it cannot change authorship.
4. Save permissions, then test with a real account that the role can edit exactly the
   fields you intended and no more.

> **Bulk operations note (from the module docs):** after the core fix for
> SA‑CORE‑2025‑002, updating these fields via **bulk operations** requires either the
> core **Administer content** permission or the equivalent permission from this module.
