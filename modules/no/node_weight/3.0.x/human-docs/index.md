# Node Weight — manual setup guide

**Node Weight** (`node_weight`) lets editors manually order nodes with a
drag-and-drop screen, instead of relying on publish date or title. You switch it on
per content type; each enabled type gets a shared integer weight field
(`field_node_weight`) and a **Manage order** page where its nodes appear in a
draggable table. Because the weight is a normal field, you can use it as a **Views
sort criterion** to control the order of any listing, block, or feed.

Typical uses are ordering a "Featured", "Staff", or "Testimonials" content type for
a custom homepage, arranging slides for a carousel, or giving a marketing team a way
to reorder content without touching each node individually. Reordering is
revision-free — saving the order does not create new node revisions — and it can
include or exclude unpublished nodes, and even toggle a node's published status
right from the ordering table.

Two permissions separate the two audiences: **Administer node weight** (a sensitive
permission — it creates and deletes fields) for the site builder who enables the
feature per type, and **Assign node weight** for the editors who reorder content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration and day-to-day use are covered in *How to use it* below.

## Where it lives in the admin menu

- The global settings form is at **Configuration → Node weight**
  (`/admin/config/node-weight`).
- Each enabled content type gets an ordering screen at
  **Structure → Content types → [type] → Manage → Order**
  (`/admin/structure/types/manage/{type}/order`), also reachable from a "Manage
  order" operation on the content-types list.
- The two permissions are assigned at **People → Permissions**.

## How to use it

### 1. Enable Node Weight for a content type

You can do this in either of two places:

- On the settings form at `/admin/config/node-weight`, tick the content types you
  want to enable, or
- On a content type's own edit form, use the **Node weight settings** section to
  enable weighting for that type.

Enabling a type creates the `field_node_weight` field on it and adds a weight
selector to the node edit form. Disabling a type later **removes** that type's
weight field.

### 2. Global settings

The settings form (`/admin/config/node-weight`) has:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Enabled content types** | none | Which content types have node weight turned on. |
| **Minimum weight** | −10 | The lowest weight an editor can assign. |
| **Maximum weight** | 10 | The highest weight — must be greater than the minimum. |
| **Include unpublished** | On | Whether the ordering screen also lists unpublished nodes. |

The minimum and maximum set the range offered by the weight selector on the node
edit form and the ordering table.

### 3. Reorder content

Open a type's **Manage order** screen. Its nodes appear in a drag-and-drop table,
sorted by their current weight, with a published/enabled checkbox and edit/delete
links per row. Drag rows to reorder, adjust the published state if you like, and
save. Saving runs in batches (25 nodes at a time) and does **not** create new
revisions. The screen operates on the current language's nodes.

### 4. Sort a listing by weight

To actually display content in the manual order, add **`field_node_weight`** as a
**sort criterion** (ascending) to a View. Because it is an ordinary integer field,
it also works in entity queries and anywhere else you can sort by a field.

### Permissions

- **Administer node weight** — access the settings form and enable/disable
  weighting per type. Sensitive, because it creates and deletes fields; give it to
  site builders only.
- **Assign node weight** — use the drag-and-drop **Manage order** screens. Give this
  to editor or marketing roles that should reorder content without full admin
  access. (The order and list screens require *both* permissions.)
