# Double Reference — manual setup guide

**Double Reference** (`double_reference`) provides a field type where a *single*
field item holds *two* entity references at once: a **primary** reference that
behaves like a normal Entity Reference field, and an **added** ("secondary")
reference that shares most — but not all — of the same options. The two work
together as one coupled field, which is useful when a value always comes as a pair
— for example a taxonomy term paired with a node, or a product paired with a
variant.

A couple of honest caveats from the module's own notes: the two references do
**not** interact — changing one does not change the other — and the added
reference uses the plain default referencing method (no Views‑based selection or
entity browsers), whereas the primary reference can use everything a normal Entity
Reference field can. It provides two widgets and a formatter for displaying both
labels.

Under the hood it is a well‑behaved field plugin: the field type extends core's
Entity Reference item, it integrates with **Views** (so you can filter on either
reference) and with **Entity Usage** (so both references are tracked), and its
output is escaped by Drupal's render layer. It has no routes, permissions, or
settings form of its own. It depends only on Drupal core, runs on Drupal 9, 10,
and 11, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone configuration page** for this module. You configure it
per field, on your entity's field settings and Manage display, as described below.

## How to use it

### Add the field

When adding a field to a content type (or any fieldable entity), pick **Double
Reference** from the "Reference" category. It behaves like an Entity Reference
field for the primary value and adds a second, "added" reference alongside it.

### Storage settings

- **Type of item to reference** (primary) — the standard entity‑reference target
  type for the primary reference.
- **Added reference: Type of item to reference** — the entity type for the second
  reference. It defaults to *node* (or *user* if node is unavailable). This is
  locked once the field holds data, so choose it deliberately.

### Field settings

- **Primary reference: Field label** — the label for the primary reference.
- **Added reference** group:
  - **Allowed bundles** — which bundles the added reference may point to
    (required).
  - **Label** — the label shown for the added reference.
  - **Weight** — negative to render the added reference *first*, positive to render
    it *second*.
  - **Required** — whether the added reference must be filled in.

### Widgets and display

- Choose one of the two widgets on **Manage form display**: the default
  autocomplete widget, or the autocomplete‑with‑select variant. Both give the
  added reference its own control.
- On **Manage display**, use the Double Reference label formatter to render both
  labels; a setting controls whether the added reference's label links to its
  entity.

### Views and Entity Usage

Both references are exposed to **Views** (the target‑id filters are switched to the
proper entity‑reference filter, or the taxonomy index filter for taxonomy
targets), and both are recorded by **Entity Usage** if you have that module.
