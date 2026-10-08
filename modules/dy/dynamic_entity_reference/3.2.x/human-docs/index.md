# Dynamic Entity Reference — manual setup guide

**Dynamic Entity Reference** (`dynamic_entity_reference`), often shortened to
**DER**, provides an entity-reference field whose single field can point at **more
than one entity type at once**. Core's Entity Reference field locks each field to a
single target type, so referencing both nodes and users means creating two separate
fields. DER removes that limitation: one "related" field can reference nodes, users,
taxonomy terms, or any content entity type interchangeably.

It works by storing both a `target_id` and a `target_type` for every value, so the
field always knows *what kind* of entity each reference points to as well as which
one. In the field's storage settings you decide which entity types are allowed —
either as a whitelist or a blacklist — and per-type selection settings control which
bundles are referenceable, exactly like core's reference handlers. DER ships the
widgets and formatters you would expect (an autocomplete widget, options select and
buttons widgets, and label, rendered-entity, and raw-id formatters), integrates with
**Views** by exposing both the target type and target id, and works with the
**Diff** module for revision comparison.

You add and configure a DER field through the normal **Field UI**, just like any
other field — there is no separate admin settings page. It is a common building
block for flexible data models: polymorphic "attach anything" fields,
paragraph-style relationships, and unified reference tables that span heterogeneous
entity types.

DER requires only core's **Field** module and PHP 8.1 or newer, and it targets
Drupal 10, 11, and 12. This guide is written for a **human** clicking through the
admin UI. If you want terse, token-cheap references for an AI coding agent — including
how to set, read, and query values in code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

DER has **no dedicated settings page**. You use it through the standard **Field UI**
wherever you manage fields — for example **Structure → Content types → your type →
Manage fields** (`/admin/structure/types/manage/*/fields`), or the equivalent for
users, taxonomy, media, or custom entities.

## How to use it

Add and configure a Dynamic Entity Reference field like any other field:

1. On a fieldable entity, go to **Manage fields → Add field** and choose **Dynamic
   entity reference** (it appears under the *Reference* category).
2. In the field's **storage settings**, choose which entity types the field may
   reference. Two settings work together:
   - **Exclude the selected entity types** — when on, the list you pick is a
     *blacklist* (everything except those types is allowed); when off, the list is a
     *whitelist* (only those types are allowed).
   - the list of **entity types** the rule applies to.
3. In the field's per-instance settings, each allowed entity type gets its own
   selection handler settings — which bundles are referenceable, sorting,
   auto-create, and so on — the same options you know from core Entity Reference.
4. Choose a **widget** on Manage form display and a **formatter** on Manage display:
   - Widgets: autocomplete (pick entity type + entity), an options select list, or
     radios/checkboxes.
   - Formatters: the referenced entity's **label** (optionally linked), the entity
     **rendered** in a chosen view mode, or the raw **target id**.

Once the field exists, editors can reference mixed entity types from the one field,
Views can filter or relate on either the target type or target id, and a validation
constraint ensures stored values only ever point at the entity types you allowed.
For setting, reading, and querying DER values from custom code, see the
[`agent/`](../agent/start.md) docs.
