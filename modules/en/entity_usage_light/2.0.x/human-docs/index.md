# Entity Usage Light — manual setup guide

**Entity Usage Light** (`entity_usage_light`) is a simple, lightweight way to see
which entities a piece of content references. Rather than *tracking* usage over time
(as the full Entity Usage module does), it adds a **"Usage" tab** to an entity's
local tasks that, on demand, lists all the entities that entity references. The most
common use is enabling it on nodes and selecting *Media*, so an editor can open a
node's Usage tab and instantly see every media item it uses.

Its detection is broad: it finds referenced entities in **entity reference fields**,
**image fields**, **Paragraphs fields** (including fields nested inside paragraphs),
and **text fields** such as CKEditor bodies with embedded entities. It works with
all entity types.

The module needs a two‑step configuration after enabling: first you activate it for
each entity type on its settings page, then on each bundle's edit form you choose
which referenced entity types the Usage tab should detect. Access to the tab is
controlled by a permission. If a bundle has revisions enabled, you can also view
usage per revision (a work in progress). It works on Drupal 10, 11, and 12; for a
more advanced tool that persistently *tracks* usage, consider the full **Entity
Usage** module instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — activate it per entity type and choose
   the detectable entity types per bundle.

## Where it lives in the admin menu

Its settings form is at **Configuration → Content authoring → Entity Usage Light
settings** (`admin/config/content/...`). Per‑bundle detection is configured on each
bundle's own edit form (for example the *Article* content type). The **"Usage"** tab
then appears on each configured entity's local tasks.
