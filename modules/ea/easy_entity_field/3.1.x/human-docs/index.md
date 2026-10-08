# Easy Entity Base Field — manual setup guide

**Easy Entity Base Field** (`easy_entity_field`) lets you add **base fields** to a
content entity type through a Field‑UI‑style interface, **without writing code**.
Normally, adding a base field (a field that lives directly in the entity's own base
table rather than in its own separate field tables) means hand‑coding
`hook_entity_base_field_info()` in a custom module. This module gives you a
point‑and‑click "Manage Base Fields" screen for it instead.

The problem it targets is database sprawl. Every field you add through the normal
Field UI creates its own storage tables — and if revisions are on, roughly double
that. On an entity with hundreds of fields, that's a lot of tables. Base fields
avoid it by storing their data in the entity's existing base/data table, which can be
a meaningful simplification for the right fields. Easy Entity Base Field makes those
base fields manageable from the UI, with exportable configuration
(`easy_entity_field.field.<entity_type>.<field>.yml`) you can drop into a custom
module to recreate the field on install elsewhere.

A few limits are worth knowing before you commit. **Multi‑value fields are not
supported** — use core's Field module for those. Some field types (like Map, URI,
File URI, Password) can be added as pure data storage but need a custom form element
in the entity's add/edit form. And adding many fields to one table can itself affect
performance, so this is a tool to use with judgement, ideally alongside a developer
who understands the trade‑off. It requires **Field UI** and targets **Drupal 11.2**.

**This is a powerful, schema‑changing tool** — adding or altering a base field
changes the entity's storage schema. Every screen is locked behind restricted
administrator permissions for exactly that reason. Grant those permissions only to
trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with Field UI).
2. [Configuration](configuration/index.md) — enable target entity types and add base
   fields.

## Where it lives in the admin menu

The settings form — where you choose which entity types get base‑field management —
is at `/admin/config/development/easy-entity-field`. Once an entity type is enabled,
you manage its fields from a **Manage Base Fields** tab that appears on that entity
type's own admin UI. See [Configuration](configuration/index.md).
