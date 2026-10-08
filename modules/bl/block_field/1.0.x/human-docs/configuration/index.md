# Configuration

Block Field has no central settings page — you configure it per field, using the
standard Field UI on any fieldable entity (content types, taxonomy terms, media, and
so on). This page walks through adding a Block field to a content type.

## 1. Add the field

1. Go to **Structure → Content types → *[your type]* → Manage fields**.
2. Click **Add field** and choose **Block field** (it lives under the *Reference*
   category).
3. Give it a label (for example "Sidebar block") and save.

## 2. Choose which blocks it offers

On the field's settings form you pick a **Selection method** — the strategy that
decides which blocks an author may choose from:

- **Blocks** *(default)* — a table where you tick specific block plugins to build an
  explicit **whitelist**. Use this to expose only a curated, safe set of blocks to
  editors.
- **Categories** — instead of naming individual blocks, you choose whole
  **categories**, and every block in those categories becomes available (for example,
  all "Menus" blocks).

Use the **Change selection** button to switch between the two handlers; the relevant
settings appear beneath it. Save the field settings when you're done.

## 3. Set the editing widget

Go to **Manage form display**. Block Field provides one widget (**Block field**):
when editing content, the author selects a block from the allowed list and is then
shown that block's own configuration form — its administrative label plus whatever
settings the block itself exposes (a Views block's arguments, a search block's
options, and so on).

If you add the field more than once (multiple values/deltas), an author can stack
several blocks in order on a single piece of content.

## 4. Choose how it renders

Go to **Manage display**. Two formatters are available:

- **Block field** — builds and renders the selected block inline, exactly as it would
  appear in a region. This is the usual choice.
- **Block field label** — outputs only the block's administrative label (handy in a
  teaser or a compact listing where you don't want the full block rendered).

Save the display. Now, when you create or edit content of this type, you'll see the
block selector; pick a block, configure it, save, and the block renders inline
wherever you placed the field.

> **Developers:** you can add your own selection strategy by writing a
> `BlockFieldSelection` plugin, alter the available strategies with
> `hook_block_field_block_field_selection_info_alter()`, or read the configured block
> instance in code via `BlockFieldItem::getBlock()`. See the sibling
> [`agent/`](../../agent/start.md) docs.
