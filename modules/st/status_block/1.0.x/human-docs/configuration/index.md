# Configuration

Status Block is configured entirely through Drupal's normal block system — you
place the block, then set its options in the block's own configuration form. There
is no separate global settings page.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Select the **theme** where you want the bar to appear.
3. Click **Place block** in any region and choose the **Status bar** block (the
   label the module provides).

Because the bar is **fixed-positioned**, the region you choose does not control
where it physically appears on the page — it always floats in a fixed spot. The
region only controls Drupal's usual concerns: visibility conditions and context.

## Configure the block

Open the block's configuration to set:

- **Which data items are visible** — current project version, active theme, custom
  message, current environment, and any custom widgets a developer has added.
- **Item order** — drag and drop to reorder the items in the bar.
- **The "More" dropdown** — move less-frequently-used items into a "More" section
  so the bar stays compact.
- **The custom message** — free text you can edit here to show whatever note you
  want (a deploy reminder, a warning, etc.).
- **Environment names and colors** — give each environment (dev / stage / prod) its
  own color so the bar's color instantly signals which environment you are on.
- **Visibility and role/permission restrictions** — the standard block visibility
  settings, so only the intended users see the bar.

Save the block.

## Grant the viewing permission

The bar is gated by the **view status blocks** permission. Go to **People →
Permissions** and grant *view status blocks* to the roles that should see the bar
(typically your developer and administrator roles). Without this permission, a user
will not see the block even where it is placed.

## Verify and style

Visit a page in the selected theme to confirm the bar appears and is styled as you
expect. The module ships a minimal stylesheet exposed through **CSS variables**, so
you can override colors, spacing, and typography from your own theme to match your
site.
