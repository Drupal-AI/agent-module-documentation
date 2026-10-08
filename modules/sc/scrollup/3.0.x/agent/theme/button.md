# How the button is attached and rendered

There is no block, no Twig template, and no theme hook. The button is injected client-side.

## Attachment — `scrollup_preprocess_page(&$variables)`

`hook_preprocess_page` in `scrollup.module`:

1. Reads `scrollup.settings` and the active theme name (`theme.manager` → `getActiveTheme()->getName()`).
2. If the active theme is in `scrollup_themename`, attaches library `scrollup/scrollup` and pushes
   every setting into `drupalSettings`:
   `scrollup_position`, `scrollup_button_bg_color`, `scrollup_button_hover_bg_color`,
   `scrollup_title` (wrapped in `t()`), `scrollup_window_position`, `scrollup_speed`,
   `scrollup_themename`.

So the button loads sitewide on any page rendered with a selected theme; there is no per-page or
per-route control and no admin-route exclusion.

## Library — `scrollup/scrollup`

Defined in `scrollup.libraries.yml`:
- `js/scrollup_top.js`
- `css/scrollup_top.css` (theme group)
- dependencies: `core/drupalSettings`, `core/drupal`, `core/once`

## JS behavior — `Drupal.behaviors.scrollup` (`js/scrollup_top.js`)

`attach()` runs once per page via `once('scrollup', document.querySelector('body'))`:

- Appends `<a href="#" class="scrollup" title="…">Scroll<span class="scroll-title">…</span></a>` to
  `<body>` with `insertAdjacentHTML`. The `title`/visible text come from
  `drupalSettings.scrollup_title` (empty → title falls back to `Scroll to the top of the page.`).
- Horizontal side: `scrollup_position === 1` → right in LTR, left in RTL; otherwise left. Sets
  inline `style.right`/`style.left = '0px'`.
- Sets inline `backgroundColor` from `scrollup_button_bg_color`; swaps to
  `scrollup_button_hover_bg_color` on `mouseover`, restores on `mouseleave`.
- On `window` `scroll`: shows the button (`display:block`) when
  `window.pageYOffset > parseInt(scrollup_window_position)`, hides it otherwise.
- On `click`: `preventDefault()` then `html, body`.`scrollTo({top:0, behavior:'smooth', duration:scrollSpeed})`.

## CSS — `css/scrollup_top.css`

`.scrollup` is `position:fixed; bottom:50px; width:80px; height:100px; display:none;` with a
background arrow image (`images/arrow.png`) and `text-indent:-9999px`. `.scroll-title` is the visible
label span; `a.scrollup` sets `z-index:10`. Override these in your theme to restyle.
