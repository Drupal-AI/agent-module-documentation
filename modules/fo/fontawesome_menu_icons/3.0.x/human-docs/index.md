# FontAwesome Menu Icons — manual setup guide

**FontAwesome Menu Icons** (`fontawesome_menu_icons`) lets you attach a Font
Awesome icon to any Drupal menu link, so the rendered menu shows an icon before,
after, or in place of the link text. It works with both the custom links you
create in the Menus UI (`menu_link_content`) and the module-defined links that
come from other modules' `*.links.menu.yml` files.

When you edit a menu link, the module adds a **"FontAwesome Icon"** fieldset to
the form. There you pick the icon and choose four things about it: the icon
class/name, a style/version prefix (which selects Font Awesome 4, 5, or 6 and the
solid/regular/brands variant), the wrapper HTML tag (`i` or `span`), and where the
icon appears relative to the text (before, after, or "only", replacing the text).
A jQuery icon-picker widget enhances the icon field so you can browse icons rather
than typing class names by hand.

At render time the module injects the icon markup around your link text and, when
the icon replaces the text entirely, adds `aria-hidden`, `aria-label`, and
screen-reader-only titles so icon-only links stay accessible. For custom links the
settings are stored in the link's own `options`; for module-defined links they are
mirrored into a small config object so they survive cache rebuilds. There is **no
central settings form** — every icon is configured on the individual menu link.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Font Awesome and Menu UI dependencies, and enable the module.

## Where it lives in the admin menu

There is no settings page. You work entirely from **Structure → Menus**
(`/admin/structure/menu`): pick a menu, then add or edit a link, and use the
**FontAwesome Icon** fieldset on that link's form.

## How to use it

1. Go to **Structure → Menus** and open the menu you want (for example *Main
   navigation*).
2. Click **Add link**, or **Edit** an existing link.
3. Expand the **FontAwesome Icon** fieldset and fill it in:
   - **Icon** (`fa_icon`) — the icon class/name. For Font Awesome 6 prefix the
     name with `fa-` (for example `fa-house`, `fa-rocket`); for legacy Font
     Awesome 4 use a bare name (for example `home`). The icon-picker helps you
     find the right one.
   - **Prefix** (`fa_icon_prefix`, default `fa`) — the style/version prefix. Use
     `fa`, `fas`, `far`, `fal`, `fad`, or `fab` for Font Awesome 4/5, or the
     Font Awesome 6 style prefixes `fa-solid`, `fa-regular`, `fa-light`,
     `fa-thin`, `fa-duotone`, `fa-brands`. Pick a matching prefix for your icon —
     for example `fa-brands` with a social icon.
   - **Tag** (`fa_icon_tag`, default `i`) — the HTML wrapper element, either `i`
     or `span`. Choose `span` if your theme styles spans.
   - **Appearance** (`fa_icon_appearance`, default `before`) — where the icon
     sits: **before** the text, **after** the text, or **only** (the icon
     replaces the text, useful for icon-only social or toolbar menus).
4. Save the link. The menu now renders the icon in the position you chose.

To **remove** an icon later, edit the link and clear the icon field. For
module-defined links this also clears the mirrored config entry automatically.

You can also set icons programmatically — for example during a migration or an
install hook — by writing the four `fa_icon*` values into a `menu_link_content`
entity's link `options`. See the [agent docs](../agent/configure/menu-link-icons.md)
for code recipes.
