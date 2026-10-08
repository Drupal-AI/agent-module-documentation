# Configuration

Setting up a mega menu is three steps: build the menu links (normal Drupal), lay
out the mega menu in the builder, and place the block that renders it.

## 1. Build the menu links

We Mega Menu doesn't create links — it styles an existing menu. So first, under
**Structure → Menus** (`/admin/structure/menu`), pick a menu (for example *Main
navigation*) and add the top-level items and their children the usual way. The
mega menu builder reads this link tree.

## 2. Lay out the mega menu

1. Go to **Structure → Mega Menu** (`/admin/structure/we-mega-menu`). You'll see a
   list of every menu, each with a **Config** action.
2. Click **Config** for your menu. This opens the drag-and-drop builder.
3. In the builder you can:
   - **Split a dropdown into rows and columns** and set each column's width
     (Bootstrap-style `span1`–`span12`).
   - **Drop a Drupal block into a column** — a promo, a contact form, a View, a
     video, or custom HTML — and choose whether to show the block's title.
   - **Give menu items an icon and caption**, a custom CSS class, or a link target.
   - **Group child links under a heading** inside a dropdown.
   - **Set the menu's behaviour** (see the options below).
4. **Save** in the builder. (There's also a **Reset** action that returns a menu's
   layout to the default derived from its links.)

### Per-menu behaviour options

These apply to the whole menu and control how the dropdowns behave on the front
end:

- **Style** — the menu's skin/style.
- **Animation** — the open animation for dropdowns (for example `fadeInUp`), with
  optional **delay** and **duration** in milliseconds.
- **Action** — whether a submenu opens on **hover** or on **click**.
- **Auto mobile collapse** — collapse the mega menu into a hamburger-style menu on
  small screens.
- Extras such as auto-appending a dropdown arrow, keeping a submenu always visible,
  and hiding specific columns when the menu collapses on mobile.

## 3. Place the Mega Menu block

Building the layout doesn't put the menu on your site — you also place a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the menu (typically the
   header).
3. Choose the **Mega Menu** block for your menu — there is one per menu, listed
   under the category **"Drupal 8 Mega Menu"** (e.g. the block for *Main
   navigation*).
4. Save the block, then save the block layout.

Your menu now renders as a mega menu on the front end. There's also a **Mega Menu
Configure** contextual link on the placed block that jumps straight back to the
builder for that menu.

## Good to know

- **Layout is stored per menu *and* per theme.** Each menu can have a different
  mega-menu layout under each theme, so if you switch or add a theme you may need
  to build the layout again there. A menu is "active" as a mega menu once it has a
  layout for the current theme (the builder creates one, and the front end will
  auto-create a default on first render if none exists).
- **The layout is not standard exportable configuration.** Unlike most Drupal
  settings, a mega menu's layout is stored in the database, not in exportable
  config — so `drush cex` won't pick it up. For deployments, the layout can be
  seeded programmatically (see the [`agent/`](../start.md) docs), or rebuilt in the
  builder on each environment.
- Keep editing your menu links normally under **Structure → Menus** — the module
  keeps the stored layout in sync as links are added, changed, or removed.
