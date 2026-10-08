# Base Field Override UI — manual setup guide

**Base Field Override UI** (`base_field_override_ui`) adds a **Base fields
Override** tab to every entity type's *Manage fields* page, letting you change the
**label** and **description** of code‑defined base fields — like a node's Title —
per bundle, through the admin UI and without writing any code.

Drupal core lets modules define base fields, but the admin UI normally exposes
almost none of them for per‑bundle customization (out of the box you can only
rename the node Title). This module surfaces the rest: for each content entity
type that has a Field UI *Manage fields* page, it adds a secondary tab where a list
of the entity's base fields is shown, and you can add, edit or delete an override
that changes a base field's label and description for one specific bundle.

Under the hood it does not invent any new storage — it edits core's own
`base_field_override` configuration entity, the same one core uses when you rename
the node Title. That means your overrides live in exported configuration and
deploy cleanly, and they can be translated per language through config
translation. Deleting an override simply reverts the base field to its
code‑defined default.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the routes it adds
and the programmatic `BaseFieldOverride` API — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. Instead, the module adds a **Base fields
Override** secondary tab next to the normal **Fields** tab on each entity type's
*Manage fields* page — for example, for the Article content type, at
**Structure → Content types → Article → Manage fields**
(`/admin/structure/types/manage/article/fields`).

Access uses core's existing per‑entity permission — for example **Administer node
fields** (`administer node fields`) for content types — so anyone who can already
manage that entity type's fields can manage its base‑field overrides.

## How to use it

1. Go to the bundle's **Manage fields** page (e.g. Article).
2. Click the **Base fields Override** secondary tab, beside **Fields**.
3. The list shows the entity type's base fields. Use it to **Add**, **Edit** or
   **Delete** an override:
   - The edit form exposes **Label** (required) and **Description**, plus the base
     field type's own field‑settings form.
   - **Save settings** to apply. For instance, rename **Title** to "Headline" on
     the Article type only, or add editor‑friendly help text to a base field that
     ships with none.
4. To revert a base field to its original, code‑defined label and description,
   **delete** its override.

Notes:

- Only entity types that have a Field UI *Manage fields* page get the tab, and only
  base fields that are display‑configurable on the form can be overridden.
- Because overrides are stored in core's `base_field_override` config, they export
  with your configuration and can be translated per language via config
  translation.
