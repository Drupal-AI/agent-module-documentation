# Field Clone — manual setup guide

**Field Clone** (`fieldclone`) speeds up creating content that starts from an
existing item. It lets you **pre-fill an entity add form** with field values copied
from a source entity, where the source is named in a **URL query parameter**. You
build a link like this and hand it to an editor (or use it in a menu, button, or
view):

```
node/add/page?fieldclone=node:17:field_common
```

That opens the "create page" form with `field_common` already populated from
node 17. You can copy several fields at once by separating them with `|`, and you
can copy a value from one field into a *different* target field using a four-part
segment `entity_type:id:source_field:target_field`:

```
node/add/page?fieldclone=node:17:field_common|node:23:field_source:field_target
```

Crucially, cloning is **access-checked**. Before copying, the module verifies the
current user's **view access to the source entity** and to the specific **source
field**; if either is lacking it returns an error and copies nothing. This means
the URL parameter cannot be abused to read field values from entities or fields the
user is not allowed to see — so it does not become an information-disclosure vector.

Field Clone depends on the **Replicate** module, which does the underlying value
copying.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Replicate dependency) and enable the module.

There is **no settings form** to fill in — you use the module by constructing
`fieldclone` links, described in "How to use it" below.

## Where it lives in the admin menu

Field Clone has no configuration settings. It does provide an information page at
`fieldclone.information` that explains the URL-parameter syntax; you will normally
just build the links directly rather than visit any admin screen.

## How to use it

The `fieldclone` query parameter is a `|`-separated list of clone instructions.
Each instruction is one of:

- **`entity_type:id:field`** — copy `field` from the given source entity into the
  same-named field on the new entity. Example: `node:17:field_common`.
- **`entity_type:id:source_field:target_field`** — copy `source_field` from the
  source entity into a differently named `target_field` on the new entity. Example:
  `node:23:field_source:field_target`.

Combine several instructions with `|` to pre-fill multiple fields at once, and
append the whole thing to any entity add URL (for example `node/add/page?...`). The
editor still reviews and saves the form as normal — Field Clone only pre-fills the
starting values, and only for fields the current user is allowed to view on the
source.
