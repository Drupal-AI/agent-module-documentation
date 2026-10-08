# Configuration

Getting the anchor index to appear is a short, ordered process: give your field
groups IDs, tell the module which node types to work on, and choose how the index
is placed.

## 1. Give each field group an ID

The anchors are built from your field groups, so those groups must exist first and
each one you want in the index needs an **ID**.

1. Go to **Structure → Content types → (your type) → Manage display** (or *Manage
   form display*, wherever your field groups are defined).
2. Create the field groups you want to act as sections, if you have not already.
3. In each field group's configuration, set its **ID** — this is the anchor the
   index links to. Only groups with an ID participate.

## 2. Choose node types and placement in the module settings

In the **module settings**, specify:

- **Which node types** the module should apply to. (The module currently works
  with nodes only, and with the **full** view mode.)
- **How the index is rendered** — as a **pseudo field** or as a **block**:
  - **Pseudo field** — the index becomes a field‑like item you can position on the
    content type's **Manage display**, so it sits within the node's rendered
    output.
  - **Block** — the index becomes a block you place in a region via **Structure →
    Block layout**.

## 3. Position the index

- If you chose the **pseudo field**, go to **Manage display** for the node type and
  drag the field‑group‑anchors pseudo field to where you want the index to appear.
- If you chose the **block**, go to **Structure → Block layout**
  (`/admin/structure/block`), place the module's block in a region, and configure
  its visibility as usual.

## Verify

View a node of a configured type (in the full view mode). You should see the index
of anchor links; clicking one should jump the page to the matching field group.
If nothing appears, re‑check that the field groups have IDs and that the node type
is enabled in the module settings, then clear the cache (`drush cr`).
