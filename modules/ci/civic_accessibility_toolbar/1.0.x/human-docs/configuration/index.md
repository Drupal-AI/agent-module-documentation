# Configuration

Civic Accessibility Toolbar has **no global settings page** — all configuration
lives on the block instance. You place the block, choose which control groups it
shows, and (if you want) restyle it in your theme.

## Place the toolbar block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** for the region you want (header, sidebar, footer, …).
3. Choose **Accessibility Toolbar** (plugin `accessibility_toolbar_block`).
4. Use the standard core **Visibility** conditions to control where it appears
   (pages, roles, content types).

## Block settings

When you place or edit the block, its settings form offers four options:

- **Show text resize** (`text_resize`, default on) — show the text-resize button
  group (100% / 125% / 150%).
- **Text resize label** (`text_resize_label`, default "Text") — a label shown
  before the resize group; leave it empty for no label.
- **Show color contrast** (`color_contrast`, default on) — show the contrast
  button group (normal, blue, high-visibility, soft).
- **Color contrast label** (`color_contrast_label`, default "Color") — a label
  shown before the contrast group; leave it empty for no label.

Turn one group off to make a simpler widget — for example, show only the
text-resize controls, or only the contrast controls.

## How choices are remembered

When a visitor clicks a button:

- **Text size** toggles a class on the `<html>` element and saves the choice to a
  `fontSize` cookie.
- **Contrast** toggles a theme class on the `<body>` element and saves the choice
  to a `colorContrast` cookie.

Both cookies are set with `SameSite=Strict`, path `/`, and a 365-day lifetime, and
the selection is re-applied on the next page load. They store only the UI
preference (no personal data), so if you use a cookie-consent tool, classify them
as **functional/necessary** so they aren't blocked.

## The rem/em requirement (important)

The shipped CSS resizes text by scaling `rem`/`em`-based font sizes. **Text
resizing therefore only affects text whose size is declared in `rem` or `em`.** If
your theme uses `px` font sizes, the resize buttons won't visibly change the text
until you add `rem`/`em`-based rules or override the module's font-scaling
selectors in your theme's CSS.

## Restyling

Because there's no settings page, you customise the look in your theme:

- **Markup / button order:** copy the module's block template
  (`block--accessibility_toolbar.html.twig`) into your theme's `templates/` folder
  and adjust it. The template exposes the `text_resize`, `color_contrast`,
  `text_resize_label`, and `color_contrast_label` values.
- **Contrast colours:** define or override the contrast theme rules (the
  `theme__blue`, `theme__hivis`, and `theme__soft` body classes) in your theme's
  CSS to match your brand.
- **Icons:** the contrast buttons use SVG icons from the module; swap them by
  overriding the template.
