# Configuration

Entity Hierarchy has **no central settings form**. You configure it per field, on
the content type (or other entity type) you want to make hierarchical, and then
optionally wire the tree into Views and grant the reorder permission. This page
walks through each step.

## 1. Add the hierarchy field

On the content type you want to nest — say a "Page" type — go to **Structure →
Content types → Page → Manage fields → Add field** and add a field of type
**Entity reference: Hierarchy** (`entity_reference_hierarchy`). The key points:

- **Point it at the same entity type.** A hierarchy only makes sense within one
  entity type, so a Page's "Parent" should reference Pages. Set the reference
  **target type** to the same type as the bundle you're editing.
- **Keep cardinality at 1.** Each item has a single parent, so the field should
  allow one value.
- **Limit the allowed parent bundles** if you like, using the reference field's
  *target bundles* setting. Leave it empty to allow any bundle of the target type.

The field uses a lineage‑aware **selection handler** (`entity_hierarchy`): when an
editor picks a parent, the autocomplete shows that entity's ancestry, and the
module prevents choosing a parent that would create a loop (a cycle is rejected on
save).

Alongside the parent reference, the field stores an integer **weight** that orders
siblings under the same parent. Three field settings control it:

- **Minimum weight** — the lowest allowed sibling weight (default `-50`).
- **Maximum weight** — the highest allowed sibling weight (default `50`).
- **Weight label** — the label shown for the weight sub‑field (default "Weight").

## 2. Choose the edit widget

On the content type's **Manage form display** tab, pick the widget for your
hierarchy field:

- **Autocomplete** (`entity_reference_hierarchy_autocomplete`, the default) — an
  autocomplete box for the parent, plus the weight field.
- **Select** (`entity_reference_hierarchy_select`) — a drop‑down of options for the
  parent, plus the weight field.

Both widgets offer a **Hide weight** option. Tick it to hide the weight sub‑field
from editors — sibling order is then managed only through the *Reorder children*
screen (below), which is usually the friendlier experience.

## 3. Choose the display formatter

On **Manage display**, the field's default formatter is **Hierarchy label**
(`entity_reference_hierarchy_label`), which renders the parent's label. It has a
*weight output* setting that controls whether (and how) the weight value is shown.

## 4. The "Reorder children" screen and its permission

As soon as a bundle has a hierarchy field, every entity of that type gains a
**Reorder children** local task (a tab) at `<entity>/children` — a drag‑and‑drop
table for setting the order of that entity's direct children without editing each
child by hand.

Access to that screen is gated by a permission this module provides. Go to
**People → Permissions** and grant **Reorder entity_hierarchy children**
(`reorder entity_hierarchy children`) to the roles that should be able to reorder
content (the user also needs view access to the parent entity).

## 5. Views integration — listings and navigation

Each hierarchy field's tree is exposed to Views, so you can build hierarchy‑aware
listings with no code. The building blocks:

**Contextual filters (arguments)** — given an entity id from the URL, filter a
view relative to that entity in the tree:

| Filter | Selects | Extra setting |
|--------|---------|---------------|
| **Is child of** (`entity_hierarchy_argument_is_child_of_entity`) | the entity's descendants | **Depth** — limit how many levels (e.g. `1` = direct children only) |
| **Is parent of** (`entity_hierarchy_argument_is_parent_of_entity`) | the entity's ancestors | **Depth** |
| **Is sibling of** (`entity_hierarchy_argument_is_sibling_of_entity`) | the entity's siblings | **Show self** — include or exclude the entity itself |

**Relationship** — **Hierarchy root** (`entity_hierarchy_root`) relates each row to
its top‑level (root) ancestor, so you can group or section content by the top of
its tree.

**Field** — **Tree summary** (`entity_hierarchy_tree_summary`) shows a summary of
how many children an entity has; its *summary type* setting controls the display.

There's also a **Hierarchy order** sort (based on the tree's `left_pos`) so listings
come out in true tree order. A common recipe — "child pages of the current page" —
is a view with the **Is child of** contextual filter (depth `1`), the argument
provided from the URL, sorted by **Hierarchy order**.

## 6. Bulk imports and migrations — pause and rebuild

Because tree writes happen on every save and are deliberately expensive, disable
them during a large migration and rebuild the tree once at the end:

```bash
# Pause per-save tree writes
drush sset entity_hierarchy_disable_writes 1

# ... run your migration / bulk entity saves ...

# Resume writes and rebuild the tree in one pass
drush sset entity_hierarchy_disable_writes 0
drush entity-hierarchy:rebuild-tree field_parent node
```

`drush entity-hierarchy:rebuild-tree <field_name> <entity_type_id>` rebuilds a
hierarchy field's nested‑set table from the current content. Run it after bulk
imports, after re‑enabling writes, or any time a tree ever looks out of sync. You
never edit the underlying `nested_set_<field>_<entity_type>` table by hand — the
module maintains it for you.
