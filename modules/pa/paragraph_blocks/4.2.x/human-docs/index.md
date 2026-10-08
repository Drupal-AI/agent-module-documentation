# Paragraph Blocks — manual setup guide

**Paragraph Blocks** (`paragraph_blocks`) exposes each value of a multi-value
paragraph field as an individual **Layout Builder block**, so editors can place a
specific paragraph item into a layout rather than rendering the whole field at once.
If a page has a paragraph field with a hero, three cards, and a call-to-action, this
module lets an editor drop each of those into whatever layout region they like — and
reorder them freely, independent of their storage order.

It works by deriving a Layout Builder block for every combination of entity,
paragraph-reference field, item position (delta), and bundle. Fields with a
cardinality of 1 are intentionally skipped (render those as a normal field); unlimited
fields are capped at a configurable maximum number of delta blocks. To keep the many
resulting blocks identifiable in the placement UI, the module adds an **admin title**
to paragraph entities, and lets each Paragraphs type define a default admin title
(token-aware when the Token module is present) so titles auto-populate from content.

You control which paragraph fields are exposed with a per-field **"Enable Paragraph
Blocks"** checkbox, and it integrates with Layout Builder Restrictions so you can
allow or deny paragraph blocks per display. A small global settings form tunes the
overall behaviour: the maximum number of delta blocks offered, whether to show
per-item checkboxes in Layout Builder Restrictions, whether to hide the redundant
block label field during placement, and whether to only offer paragraphs from the
Paragraphs Library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant the permission.
2. [Configuration](configuration/index.md) — the global settings form, the per-field
   enable checkbox, and per-type default admin titles.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Paragraph
Blocks** (`/admin/config/content/paragraph_blocks`), gated by the **Administer
paragraphs settings** permission. Per-field and per-type options live on the
respective field and Paragraphs-type edit forms, and the blocks themselves appear in
the Layout Builder "Add block" chooser under the **Paragraphs** category.

## How to use it

1. On a content type (or other entity) with a multi-value paragraph reference field,
   confirm the field has **"Enable Paragraph Blocks"** ticked (see
   [Configuration](configuration/index.md)).
2. Give your paragraphs meaningful **admin titles** — set a default admin title per
   Paragraphs type so they auto-populate.
3. Edit the entity's layout with Layout Builder, click **Add block**, and pick the
   paragraph items you want from the **Paragraphs** category.
4. Place and reorder them across regions as you like.
