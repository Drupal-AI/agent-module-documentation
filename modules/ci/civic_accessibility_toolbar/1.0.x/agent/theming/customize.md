<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS classes, cookies, and restyling

Sources: `assets/js/accessibility_toolbar.js`, `assets/css/accessibility_toolbar.css`,
`templates/block--accessibility_toolbar.html.twig`, `civic_accessibility_toolbar_theme()`.

## What the JS does on click

Each button carries `data-accessibility-feature` + `data-accessibility-unit`. On click:

- **Font size** (`feature = fontSize`): removes `font__1 font__125 font__15` from `<html>`, then adds
  `font__<unit-without-dot>` — units `1`, `1.25`, `1.5` → classes `font__1`, `font__125`, `font__15`.
- **Contrast** (`feature = colorContrast`): removes `theme__soft theme__blue theme__hivis` from
  `<body>`, then adds `theme__<unit>` — units `blue`, `hivis`, `soft` (the "normal" button uses unit
  `color`, which adds no theme class, i.e. resets to default).

The choice is saved to a cookie and re-applied on the next page's `attach`.

## Cookies

| Cookie | Value | Attributes |
|---|---|---|
| `fontSize` | `1` / `1.25` / `1.5` | `SameSite=Strict; path=/; expires` +365 days |
| `colorContrast` | `blue` / `hivis` / `soft` | same |

These store only the UI preference (no personal data) — classify them as functional/necessary in any
cookie-consent tool so they are not blocked.

## The rem/em requirement

The shipped CSS scales fonts via the `font__*` classes on `<html>`. Text resizing therefore only affects
text whose size is declared in `rem`/`em`. If your theme uses `px` font sizes, add rem/em-based rules or
override the `font__1 / font__125 / font__15` selectors in your theme's CSS.

## Restyling

- **Markup:** copy `block--accessibility_toolbar.html.twig` into your theme's `templates/` and adjust.
  The template exposes `text_resize`, `color_contrast`, `text_resize_label`, `color_contrast_label`
  (registered by `civic_accessibility_toolbar_theme()`), and derives the icon path from `_self`.
- **Contrast themes:** define/override the `body.theme__blue`, `body.theme__hivis`, `body.theme__soft`
  rules in your theme to control the actual colors.
- **Icons:** the contrast buttons reference SVGs under the module's `assets/icons/`; swap them by
  overriding the template.
