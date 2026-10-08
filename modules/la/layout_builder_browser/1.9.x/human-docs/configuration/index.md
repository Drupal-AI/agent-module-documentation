# Configuration

All configuration lives at **Configuration → Content authoring → Layout Builder
Browser** (`/admin/config/content/layout-builder-browser`), reachable by users
with the **Administer site configuration** permission. The page has three tabs —
**Blocks**, **Block categories**, and **Settings**. The usual order is: create
your categories, add blocks to them, then confirm the settings.

## 1. Create categories (Block categories tab)

A category is a group heading in the browser — the collapsible section editors
see. Add one and fill in:

- **Label** — the heading shown to editors (e.g. "Hero", "Promotions").
- **Weight** — the sort order among categories (lower numbers appear first).
- **Opened** — whether this category starts expanded (on by default). Turn it off
  for rarely used groups so they start collapsed.
- **Preview image path** *(optional)* — a fallback preview image shared by every
  block in the category, given as a path like
  `/themes/mytheme/images/lbb/hero.jpg`, plus its **alt text**.

You can disable a category instead of deleting it to retire it temporarily — a
disabled category (and everything in it) is hidden from the browser.

## 2. Add blocks (Blocks tab)

Each entry here is one block you're allowing editors to place. Add one and the
form asks first for a **Provider** (the block plugin's group — it defaults to
*Inline blocks*), then narrows the **Block** select to that provider's plugins.
Pick the block, then set:

- **Category** — which category it appears under.
- **Label** — the name shown in the browser. This overrides the block's default
  technical name, so you can show "Two‑column promo" instead of, say, "Inline
  block: Bp Columns".
- **Weight** — its order within the category.
- **Preview image path** *(optional)* — a thumbnail for this specific block, with
  **alt text**. If you leave it blank, the block falls back to the category's
  shared image.

Only blocks you add here are offered to editors. A block can also be **disabled**
to hide it temporarily without losing its settings. Note that a category with no
visible blocks is dropped from the browser entirely, so an empty category won't
clutter the list.

## 3. Settings tab

Three options control where and how the browser appears.

### Enabled section storages

This decides *which* Layout Builder screens use your curated browser rather than
core's full list. Two choices are offered:

- **Overrides** *(on by default)* — the per‑page layout screen, where an editor
  customises the layout of one individual entity.
- **Defaults** — the "Manage layout" screen where a site builder defines the
  default layout for a whole content type or view mode.

Leave *Overrides* ticked so editors get the curated browser; add *Defaults* too
if you want site builders to see the same curated set. Any screen you don't tick
keeps showing core's complete block list.

### Use modal

A checkbox, **off by default**. When off, the block browser opens in Layout
Builder's narrow off‑canvas tray on the side. Tick it to open the browser in a
larger centred modal dialog instead — much better when your blocks have preview
images to show off.

### Auto‑added reusable block content bundles

Pick one or more **custom block types** (block content bundles) here and every
*reusable* block of those types is automatically listed in the browser under its
own "Reusable *X*" category — without you having to add each one by hand. This
keeps newly created reusable blocks appearing in the browser as editors make
them. Blocks you've already added explicitly on the Blocks tab aren't duplicated.

## Verify it worked

Open a page in Layout Builder (**edit an entity → Layout**, or **Manage layout**
on a content type if you enabled *Defaults*), and click **Add block**. You should
see your curated categories and blocks — with preview images and your custom
labels — instead of core's provider‑grouped list.
