# Key/Value Field — manual setup guide

**Key/Value Field** (`key_value_field`) adds field types that store a **key**, a
**value**, and an optional **description** together in a single field item. It is
the tidy way to capture labelled data — spec sheets, attributes, "Label : Value"
rows — without building a custom entity or gluing several separate fields together.

You get two field types, both listed under the **"Key / Value"** category when you
add a field:

- **Key / Value (plain)** (`key_value`) — a plain-text value, built on core's
  string field.
- **Key / Value (long)** (`key_value_long`) — a formatted, rich-text value with a
  text format, built on core's long-text field.

Each item holds a *key*, a *value*, and (if you leave it enabled) a *description*
that editors can use for internal notes. Set the field's cardinality above 1 and
you get repeatable rows — perfect for "SKU : ABC-123", "Weight : 1.2 kg",
"Ingredient : Amount", and similar lists. The key is required only *once a value
has been entered*, so a wholly empty row stays valid instead of nagging editors.

Two widgets ship (a text-field widget for the plain type and a textarea widget for
the long type), each with settings for the key/value/description labels, sizes, and
placeholders, and a switch to turn the description off entirely. A single formatter
renders each item as `key : value`, with a **"Value only"** option to show just the
value and hide the key. Everything is configured per field on the usual *Manage
fields / Manage form display / Manage display* pages — there is no separate admin
page, permission, or Drush command.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Adding and configuring the field is covered in the *How to use it* section below.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure the field per bundle
under **Structure → Content types → (your type) → Manage fields** (and the sibling
*Manage form display* / *Manage display* tabs).

## How to use it

1. **Add the field.** Go to *Structure → Content types → Article → Manage fields →
   Add field* (or the equivalent on any entity type that supports fields). Choose a
   type from the **Key / Value** category — *Key / Value (plain)* or *Key / Value
   (long)*. If you want repeatable rows, set **Allowed number of values** to
   *Unlimited* (or a fixed number greater than 1).
2. **Storage settings.** The plain type lets you cap the key length via
   **key max length** (default 255) and store an ASCII-only key column for faster
   lookups. These lock once the field holds data. The long type lets you set a
   **default text format** for new items.
3. **Tune the widget** on *Manage form display*: customise the key, value, and
   description labels, the key size, placeholders, and the number of description
   rows — or untick **description enabled** to drop the description sub-field
   entirely for a simpler two-input widget.
4. **Tune the display** on *Manage display*: the **Value only** formatter option
   renders just the value and hides the key; leave it off to render `key : value`.

**Entering data:** on the content form, fill in the key and value (and optional
description) for each row. Remember the key becomes required only once you type a
value, so blank rows are simply ignored.

See the [`agent/`](../agent/start.md) docs for creating the field and reading its
values in PHP.
