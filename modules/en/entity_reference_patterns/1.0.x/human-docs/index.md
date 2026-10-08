# Entity Reference Patterns — manual setup guide

**Entity Reference Patterns** (`entity_reference_patterns`) controls what an
entity‑reference field's autocomplete and option lists actually *show*. Out of the
box, Drupal offers `Label (id)` and nothing more — unhelpful when many entities
share the same title. This module lets you build the suggestion label from a
**token pattern** instead, so an autocomplete can read "Article title — Author
name" or "SKU — Product name."

Patterns are stored as reusable configuration entities. Each one has a token
pattern, an entity **type** it applies to, **selection criteria** describing which
fields or widgets it targets, and a **weight** so that when several patterns could
apply, the ordering decides which wins. Because patterns are token strings, any
token the Token module can resolve for that entity works, and an unresolvable token
simply renders empty rather than erroring.

The relabelling happens at the form‑element level and affects both autocomplete
widgets and select/checkbox widgets, so the same friendly label appears whichever
widget a field uses. It changes presentation only — the field's stored value is
untouched, so nothing downstream that reads the raw reference is affected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (it needs the Token module) and enable it.

## How to use it

1. Go to **Configuration → Search and metadata → Entity reference patterns**
   (`/admin/config/search/entity-reference-patterns`). This is the pattern list.
2. Click to **add** a pattern and fill in:
   - **Label** — a name for the pattern, for your own reference.
   - **Type** — the entity type the pattern applies to (e.g. `node`).
   - **Pattern** — the token string that builds the suggestion label, for example
     `[node:title] — [node:author:name]`.
   - **Selection criteria** — which fields/widgets this pattern should apply to.
   - **Weight** — the order among patterns; when more than one could match, weight
     decides which is used.
3. Save. You can also **edit**, **duplicate** (a quick way to start a new pattern
   from an existing one) and **delete** patterns from the list.

The operations are governed by their own permissions: **Administer entity
reference pattern** and **Delete entity reference pattern** are restricted
(admin‑level), while **Add**, **Edit** and **Duplicate** are ordinary editorial
permissions you can grant to trusted editors without giving them full admin
rights.

## Where it lives in the admin menu

The pattern list and its add/edit/duplicate/delete screens are at **Configuration
→ Search and metadata → Entity reference patterns**
(`/admin/config/search/entity-reference-patterns`).
