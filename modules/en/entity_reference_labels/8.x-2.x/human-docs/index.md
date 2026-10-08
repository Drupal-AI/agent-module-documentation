# Entity Reference Labels — manual setup guide

**Entity Reference Labels** (`entity_reference_labels`) makes entity-reference
autocomplete labels more descriptive by appending the entity's machine name to
its label. Instead of a bare "Entity Label" in the typeahead, editors see
"Entity Label [machine_name]" — which is a real help when two referenced
entities share the same human-readable name.

The problem it solves is ambiguity. Core's autocomplete shows only the label, so
if you have, say, two configuration blocks both called "Sidebar", there is no
way to tell them apart while selecting. Adding the machine name gives each
suggestion a unique, identifying suffix, so editors pick the right item with
confidence.

It works by providing a selection method — **Default (Descriptive)** — that you
choose on a reference field's settings. The referenced entities still respect
their own access; this is purely a content-editing/display aid with no
access-control role. There is no site-wide settings form; you enable it
per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Setup happens on a reference field's settings, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types (or
other bundles) → *(bundle)* → Manage fields**, on an entity-reference field's
edit page, plus **Manage form display** for the widget.

## How to use it

1. Create (or edit) an **entity-reference** field — for example one that
   references block configuration, though any entity type works.
2. On the field's **edit page**, set the **reference method** (selection
   method) to **Default (Descriptive)**.
3. On the bundle's **Manage form display**, make sure the field uses an
   **autocomplete** widget.
4. On the edit form, search by typeahead as usual — suggestions now read
   "Entity Label [machine_name]" instead of just the label.
