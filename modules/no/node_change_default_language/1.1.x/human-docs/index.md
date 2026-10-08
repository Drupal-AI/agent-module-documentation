# Node Change Default Language — manual setup guide

**Node Change Default Language** (`node_change_default_language`) lets editors change
which language is a node's **default (source/original) language** through the admin
UI. On a multilingual site the default language is the "master" translation that
others are derived from — and if content was originally created in the wrong
language, Drupal gives you no straightforward way to fix that. This module does.

It adds a **"Change default language"** operation to the node operations dropdown in
admin content lists, and a dedicated form at **`/node/{nid}/change-default-language`**
for a single node. Changing the source language creates a **new revision** with a
log message recording the change (e.g. "Default language was changed from X to Y"),
works alongside Drupal's Content Moderation without tripping validation errors, and
carefully carries over **non‑translatable field** values (which normally live only on
the default translation) so nothing is lost in the switch. Under the hood it updates
Drupal's `default_langcode` flag directly via the database API.

It depends on core's **Node**, **Language**, and **Content Translation** modules, and
provides its own permission to control who may perform the change. There is no global
settings form — once enabled and permissioned, the feature appears on nodes.

> **Heads-up.** Changing a node's source language affects its translation
> relationships, so treat it as a deliberate editorial action rather than routine
> housekeeping. The project also notes that correctly handling certain
> non‑translatable field cases may require a Drupal **core patch** (tracked in a core
> issue) — if you rely heavily on non‑translatable fields, review that before rolling
> this out to production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its multilingual dependencies.

There is **no configuration page** — the feature is controlled by a permission and
used directly on nodes, as described in "How to use it" below.

## Where it lives in the admin menu

Node Change Default Language adds no settings page. You use it from
**Content** (`/admin/content`) via each node's **operations dropdown → Change default
language**, or by going directly to **`/node/{nid}/change-default-language`** for a
specific node.

## How to use it

1. Grant the module's *change default language* permission to the roles that should
   be allowed to do this, at **People → Permissions**
   (`/admin/people/permissions`). Give it only to trusted editors, since it alters
   translation metadata.
2. Go to **Content**, find the node whose source language you need to change, and
   choose **Change default language** from its operations dropdown (or open
   `/node/{nid}/change-default-language`).
3. Pick the new default language and confirm. The module creates a new revision with
   a log message noting the change and transfers non‑translatable field values to the
   new default translation.
