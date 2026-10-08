# Properties Field — manual setup guide

**Properties Field** (`properties_field`) provides a single field type that stores an
arbitrary bag of key/value properties on any content entity. Instead of creating a
separate field for every attribute — width, height, weight, material, and so on — you
add one Properties field and let editors add as many name/value rows as each item
needs.

A classic use is product specifications: rather than a dozen dedicated fields, one
Properties field holds all of them. Each property has a **label**, a **machine name**,
a **type**, and a **value**. The label and machine name can be autocompleted from
properties already used on other entities of the same kind, which helps keep naming
consistent.

This is a content‑modelling feature. The values are ordinary field content and the
module plays no access‑control role. It has **no settings page of its own** — you set
it up entirely by adding the field to a bundle and configuring its widget and display,
just like any core field.

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
2. Add a new field and choose the **Properties** field type.
3. On the field's **Manage form display**, the Properties widget lets editors add rows,
   each with a label, an auto‑generated machine name, a type, and a value.
4. On the field's **Manage display**, choose how the properties render for visitors.

Once the field is in place, content authors define both the property name and its value
inline while editing — no further site‑builder work is needed.
