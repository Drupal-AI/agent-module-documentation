# Simple Menu Icons — manual setup guide

**Simple Menu Icons** (`simple_menu_icons`) lets you attach an image icon to
individual menu links, so your navigation can show a little brand, flag, or category
glyph next to each item. It's aimed squarely at editors: the icon is uploaded right
on the familiar menu‑link edit form, with no theme work and no CSS to hand‑write.

The module keeps things pleasantly simple. When you upload an icon for a menu link,
it's stored on that link, and the module automatically generates a small CSS file
that paints each icon as a left‑aligned `background-image` on the matching menu
item. It even sizes the link's left padding to the icon's width so the text never
overlaps the image. Because it works through CSS and per‑link classes rather than
adding markup, it slots into your existing menu templates without changes, and it
handles nested submenus too.

It's genuinely configuration‑free: there's no settings page, no permission, no
plugin, and no Drush command. The only things it persists are the icon chosen on
each menu link and the generated CSS file. That CSS is regenerated whenever you save
a link's icon and again on a cache rebuild, so your icons survive a `drush cr`. Icons
can be GIF, PNG, JPG/JPEG, or SVG.

One thing to know: icons can only be added to **custom** menu links (the ones you
create in the menu UI, which are `menu_link_content` entities). Links that modules
define in code don't get the upload field. The module hangs off core's **Menu UI**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There's no settings page. Icons are set on individual menu links under **Structure →
Menus** (`/admin/structure/menu`) — edit or add a link and you'll find the icon
field on its form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Menus** and pick a menu (for example, *Main navigation*).
3. **Add link** or edit an existing custom link. You'll see an **Icon image** field
   — a file upload accepting GIF, PNG, JPG/JPEG, and SVG.
4. Upload your icon and **Save**. The module marks the file permanent, regenerates
   the icon stylesheet, and clears caches, so the icon appears next to that menu item
   right away.
5. To **change** an icon, upload a replacement; to **remove** one, clear the upload
   field on the link.

For custom styling, every menu item that comes from a custom link gets `menu-icon`
and `menu-icon-<id>` CSS classes (even when no icon is set), so your theme can target
individual links precisely. To change the generated CSS rules, override the module's
`simple_menu_icons_css_item` template in your theme.
