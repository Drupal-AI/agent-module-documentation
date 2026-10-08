# Better Entity Reference Table — manual setup guide

**Better Entity Reference Table** (`bert`) is a friendlier form widget for entity
reference fields. Instead of the default autocomplete or select box, it renders
the referenced items as a manageable **table**, which makes it much easier to
view, reorder and manage a field that references many entities.

It is aimed at multi-value entity reference fields — a "related content" field, a
curated list, anything where the standard widget becomes unwieldy once there are
more than a handful of references. It depends only on core's System module.

This is a content-editing convenience: it changes how references are *entered* and
*ordered* in the edit form, not what they mean. It respects the reference field's
target settings and the usual entity access, and adds no access of its own. You
turn it on by choosing it as the field's widget on the content type's form
display — there is no separate settings page.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Better Entity Reference Table has no settings page of its own. You select it as a
**widget** on an entity reference field under **Structure → Content types →
[type] → Manage form display** (or the equivalent *Manage form display* tab for
any other entity type).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage form display** tab of the content type (or other entity)
   whose reference field you want to improve.
3. For a multi-value **entity reference** field, change its **Widget** to Better
   Entity Reference Table.
4. Save. Editors now manage that field's references in a table, where they can
   view and reorder the referenced items more easily.
