# Configuration

## Create a fixed block

1. Go to **Structure → Block content → Fixed block content**
   (`/admin/structure/block-content/fixed-block-content`). This page needs the
   **Administer block types** permission.
2. Click **Add new fixed block content**.
3. Give it a **title** — a human‑readable name that is also the label of the block
   you will place — and pick the **custom block type** (bundle) it targets, for
   example *Basic block*.
4. Save.

The underlying custom block is not created immediately; an empty one of the
chosen type is created on demand the first time the fixed block is rendered or
placed.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region you want, click **Place block** and find your block under the
   **Fixed custom** category.
3. If the custom block type has more than one view mode, the block's settings let
   you choose which **view mode** it renders in.
4. Save the placement.

Now edit the linked custom block content as you normally would. Because the
placement points at the stable fixed‑block wrapper rather than a content id, it
stays valid even if that content block is later deleted.

## Manage default content (staging and permanence)

Each fixed block can carry a snapshot of its content in configuration, which is
what makes it deploy cleanly between environments. From the fixed block's
operations you can:

- **Save current block content as default** (export) — snapshot the current block
  into the fixed block's config. When you deploy that config to another
  environment, the block is recreated there automatically.
- **Restore default block content** (import) — rewrite the live block from the
  stored snapshot, for example to undo an editor's change back to the shipped
  default.

Two further options refine the behavior:

- **Auto‑export** — re‑snapshot the block's content into config automatically
  whenever it is saved, for continuous config staging.
- **Protected** — mark the custom block non‑reusable so it can't be edited or
  deleted independently of its fixed wrapper, keeping the two in step.

This combination is what lets Fixed Block Content bridge content‑staging and
config‑management workflows: your standard blocks become reliable, config‑driven,
and guaranteed to exist in every environment.
