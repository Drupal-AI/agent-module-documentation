# Field Inheritance — manual setup guide

**Field Inheritance** (`field_inheritance`) lets you pull the value of a field on
one entity into a read-only, computed field on another entity. Think of it as a
configurable, field-level alternative to an entity reference: instead of just
linking to another entity, the destination entity actually *shows* the source
entity's field value, kept in sync automatically because it is recomputed each
time it is read.

A classic example: an Event node that inherits its location from a referenced
Venue, or a piece of content that shows the description of the taxonomy term it is
tagged with — without editors having to copy and paste the value. You choose the
**source** (an entity type, bundle, and field), the **destination** (an entity
type and bundle), and an **inheritance strategy** that controls how the value is
combined:

- **Inherit** — simply show the source field's value.
- **Prepend** — put the source value before the destination's own value.
- **Append** — put the source value after the destination's own value.
- **Fallback** — use the destination's own value if it has one, otherwise fall
  back to the source.

Each inheritance you set up is stored as a configuration entity, so it deploys
cleanly across environments. Out of the box you can inherit between block content,
files, nodes, and taxonomy terms; you can widen that list in the settings. Two
built-in strategies handle plain fields and entity-reference-style fields (images,
files, paragraphs), and developers can add their own strategy as a plugin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to write a
custom inheritance plugin — read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings (which entity
   types can participate) and how to create an inheritance, field by field.

## Where it lives in the admin menu

Inheritances are managed at **Structure → Field inheritance**
(`/admin/structure/field_inheritance`), gated by the **Administer field
inheritance** permission. The global settings that control which entity types can
take part are at `/admin/structure/field_inheritance/settings`.

## How to use it

The workflow is: (optionally) widen the list of participating entity types in the
settings, then create an inheritance that names a source field, a destination
bundle, and a strategy. The module adds a computed, read-only field to the
destination bundle, which you can then arrange on the destination's *Manage
display* screen like any other field. See
[Configuration](configuration/index.md) for the details.
