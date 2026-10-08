# Properties Field — manual setup guide

**Properties Field** (`properties_field`) adds a single field type, **Properties**,
that stores an ordered, unlimited list of typed key/value rows on any fieldable entity.
Instead of creating a separate field for every attribute — width, height, weight,
material, SKU — you add one Properties field and let editors add as many rows as each
item needs. It is ideal for product specifications, technical spec sheets, recipe
facts, and other ad‑hoc metadata that does not warrant a field apiece.

Each row is a quadruple: a human **label**, an auto‑generated **machine name**, a
**value type**, and a **value**. Editors fill a drag‑orderable table, so they control
the display order by reordering rows. The label field autocompletes from labels already
used for that field on the same entity type and bundle, which keeps naming consistent,
and a built‑in constraint rejects two rows with the same label or machine name within
one entity.

The **value type** decides how the value is entered and displayed. Five types ship out
of the box: **String**, **Integer**, **Decimal** (with configurable decimal and
thousands separators), **Size** (a number plus a length unit — cm, m, km, inch, feet,
mile), and **Weight** (a number plus a mass unit — grams, kilograms). Developers can
add their own value types as plugins.

This is a content‑modelling feature. The values are ordinary field content — the
shipped formatters and templates autoescape them — and the module plays no
access‑control role. It has **no settings page of its own**: you set it up entirely by
adding the field to a bundle and configuring its widget and display. New in the 1.2.x
branch is Drupal 11 compatibility; the field, widget, and formatter behaviour is
unchanged from 1.0.x.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You use
it entirely from Field UI, described in "How to use it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the Manage
   fields tab of any fieldable entity: taxonomy terms, media, users, and so on).
2. Add a new field and choose the **Properties** field type. Its cardinality is always
   unlimited, so one field holds many rows.
3. On the field's **Manage form display**, the Properties widget shows a drag‑orderable
   table. For each row an editor types a label, gets a machine name automatically,
   picks a value type, then enters the value in a control specific to that type.
4. On the field's **Manage display**, choose one of the two formatters:
   - **Properties table** *(default)* — a two‑column label/value table, with optional
     zebra striping.
   - **Properties list** — a definition list (`<dl>`), with each label as a term and
     its value as the definition.
   For number‑based value types (Decimal, Size, Weight) the formatter lets you set the
   decimal and thousands separators.

Once the field is in place, content authors define both the property name and its typed
value inline while editing — no further site‑builder work is needed.
