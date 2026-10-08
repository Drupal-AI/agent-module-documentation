# Field Is Empty — manual setup guide

**Field Is Empty** (`field_is_empty`) provides a **computed field type** whose
value simply reflects whether another field is empty or has a value. It stores a
`TRUE`/`FALSE` result — and you can optionally invert it — that other parts of
Drupal can act on without any custom code.

Why would you want a field for that? Because several systems can filter and index
on a stored field value but can't easily reason about the emptiness of another
field on the fly. Typical uses include **Search API indexing** (index whether a
field is filled), **exposing empty/non‑empty information about private fields
through REST/JSON:API** without exposing the field itself, and **Views filters**
that need a plain boolean to switch on. The value is recalculated whenever the
parent entity is saved and stored in the database, so it behaves like any other
stored field for querying.

The field can be added the ordinary way through the admin UI, or created
programmatically as a base field (available on all bundles of an entity type);
adding it programmatically as a bundle field currently depends on a core issue,
as noted in the project docs. It depends only on core's Field module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** for this module — it has no site‑wide
settings form. You configure which source field to watch when you add the field
to an entity, described in "How to use it" below.

## Where it lives in the admin menu

Field Is Empty adds no admin page. You use it through the usual Field UI:
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
fields → Add field**, where the computed field type appears in the list.

## How to use it

1. On an entity's **Manage fields**, add a new field and choose the **Field Is
   Empty** computed field type.
2. In the field settings, pick the **source field** whose emptiness this field
   should reflect, and optionally tick the **invert** option so `TRUE` means
   "the source field is filled" rather than "empty."
3. Save the field. Its value is (re)computed and stored each time the parent
   entity is saved.
4. Use the stored boolean wherever you need it — as a **Views** filter, a
   **Search API** index field, or exposed through **REST/JSON:API**.
