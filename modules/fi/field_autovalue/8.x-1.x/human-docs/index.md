# Field Autovalue — manual setup guide

**Field Autovalue** (`field_autovalue`) provides a **pluggable way to fill field
values automatically** whenever the entity they belong to is saved. Rather than
writing a custom `hook_entity_presave()` every time you need a computed or derived
value, you configure a field to use an **autovalue plugin**, and the module runs it
on save to populate that field.

It suits auto‑generated identifiers, values derived from other fields, and computed
defaults — anything where a field's value should be produced by logic instead of
typed by an editor. The value it writes becomes ordinary content; the module has no
access‑control role.

> **Important:** the module itself **ships no plugins** (only a test plugin inside
> its test module). It provides the framework and the per‑field configuration; the
> actual value‑generating plugins come from **other modules or your own custom
> code**. Think of Field Autovalue as the socket, not the bulb.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — you choose an autovalue plugin per field,
as described in "How to use it" below.

## How to use it

1. Make sure an **autovalue plugin** is available — either from another module or
   one you have written. Out of the box the module provides none, so this is the
   prerequisite step.
2. Go to the field you want to auto‑fill, under **Structure → (content type or
   bundle) → Manage fields**, and edit it.
3. In the field's configuration, select the **autovalue plugin** that should
   generate its value.
4. **Save.** From now on, whenever an entity of that bundle is created or saved,
   the plugin computes and writes the field's value automatically.

Because the value is produced on save, editors do not enter it by hand — the field
is populated for them.
