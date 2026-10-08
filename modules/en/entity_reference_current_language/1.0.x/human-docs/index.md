# Entity Reference Current Language — manual setup guide

**Entity Reference Current Language** (`entity_reference_current_language`)
provides an **entity‑reference selection plugin** that **filters the candidate
entities by the current site language**. On a multilingual site, this keeps the
list of things you can reference (and the values shown) aligned with the language
of the page you are on, so an editor working in French sees French content and a
French page references French content.

Core normally offers all matching entities regardless of language. This module
adds a "current language" reference method you choose on the field's settings; it
is compatible with all entity reference widgets and is set **per field**, so you
opt into the behaviour only where it makes sense. It is a content‑management
convenience — the referenced entity's own access rules still apply.

The module depends on core's **Language** module and works on Drupal 10 and 11.
There is **no central settings page**; you configure it in a field's storage/field
settings by picking this selection method. It has no third‑party dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus core Language).

There is **no configuration page** for this module — it has no settings form. You
select it per field, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You choose the "current language" reference method
in an entity reference field's settings, for example under **Structure → Content
types → *(type)* → Manage fields → *(your reference field)***.

## How to use it

1. Install and enable the module, with core **Language** enabled (see
   [Installation](installation/index.md)).
2. Edit the entity reference field you want to constrain — go to its field
   settings via **Manage fields** on the relevant bundle.
3. In the field's **Reference method** (selection) settings, choose the option
   this module provides so candidates are filtered by the current language.
4. Save the field settings. From then on, that field only offers (and displays)
   entities matching the current page's language.
