# Dark Mode Toggle — manual setup guide

**Dark Mode Toggle** (`dark_mode_toggle`) adds a small **Light / Dark / System**
switcher to your site so visitors can flip a theme between its light and dark
colour schemes — and the site remembers their choice the next time they visit.
It ships as a single block you place in any region, so an editor can add the
switcher without a developer once the theme is ready for it.

Under the hood the module keeps two attributes up to date on the page's `<html>`
element: `data-dmt-mode` (either `dark` or `light`) and `data-dmt-source`
(`user` if the visitor chose it, `system` if it is following the operating
system). Clicking **Light** or **Dark** stores the choice in the browser's
`localStorage`; clicking **System** clears it and follows the OS
`prefers-color-scheme` setting, updating live if the OS switches (for example at
sunset). A tiny header script applies the saved preference before the page
paints, so visitors never see a flash of the wrong theme.

The one thing to understand is that **the module does not restyle anything on its
own** — it only manages those attributes. Your active theme's CSS does the actual
recolouring by keying off `[data-dmt-mode="dark"]`. So the module gives you a
reliable, persistent, flash-free toggle and a clean attribute "contract"; you (or
your theme) provide the dark-mode CSS. That is deliberately lightweight: there is
no settings form, no permissions, and no stored configuration beyond where you
place the block.

This guide is written for a **human** clicking through the admin UI and writing a
bit of theme CSS. If you want terse, token-cheap references for an AI coding
agent — the exact attribute names, block plugin id, and template contract — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has no settings form, so there is no separate configuration page —
"setting it up" means placing the block and adding theme CSS, both covered below.

## Where it lives in the admin menu

There is no dedicated settings page. You add the switcher from **Structure →
Block layout** (`/admin/structure/block`) by placing the **Dark Mode Toggle**
block, and you write the matching CSS in your theme.

## How to use it

**1. Place the block.** Go to **Structure → Block layout**
(`/admin/structure/block`), click **Place block** in the region you want (a
header, footer, or sidebar are common choices), pick **Dark Mode Toggle**, and
save. Standard core block visibility settings apply, so you can limit the toggle
to certain pages, roles, or content types.

**2. Add the dark-mode CSS to your theme.** The module flips
`data-dmt-mode="dark"` on the `<html>` element; your theme's CSS reacts to it.
For example:

```css
:root[data-dmt-mode="dark"] {
  --bg: #111;
  --fg: #eee;
}
```

If you use Tailwind, wire up a dark variant that keys off the same attribute:

```
@custom-variant dark (&:where([data-dmt-mode=dark], [data-dmt-mode=dark] *));
```

**3. (Optional) Customise the buttons.** The default block renders three text
buttons (Light, Dark, System). To use icons or a single cycle button instead,
copy `templates/dark-mode-toggle.html.twig` into your theme and edit it — keeping
the `data-dmt-container` attribute on the wrapper and a
`data-dmt-preference="light|dark|system"` attribute on each control, since the
JavaScript relies on those. See the [`agent/`](../agent/start.md) docs for the
full template contract.
