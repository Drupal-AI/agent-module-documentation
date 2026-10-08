<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the fullscreen overlay

No templates or theme hooks — this is pure CSS/JS behavior driven by a `data-fullscreen`
attribute. Relevant only if a theme needs to override the overlay's positioning or fix a
z-index conflict with other fixed/sticky UI.

## The attribute contract

When the `Fullscreen` button is clicked, the JS (`fullscreenui.js`) sets:

- `data-fullscreen="fullscreeneditor"` on the CKEditor 5 root element's parent
  (`editor.sourceElement.nextElementSibling`).
- `data-fullscreen="fullscreenoverlay"` on `<body>`.

Both attributes are removed when the button is clicked again to exit fullscreen.

## What the shipped CSS (`css/fullscreen.css`) does with those attributes

- `[data-fullscreen="fullscreeneditor"]` — `position: fixed`, fills the viewport (respecting
  Drupal's `--drupal-displace-offset-*` custom properties), flex column layout so the content
  area (`.ck.ck-editor__main`) scrolls internally.
- `[data-fullscreen="fullscreenoverlay"]` on `<body>` — `overflow: hidden` (locks page scroll),
  and redeclares `--ck-z-default`/`--ck-z-panel`/`--drupal-displace-offset-*` so the editor and
  its floating panels (balloons, dropdowns) sit above everything, including the admin toolbar.
- Elements using `Drupal.displace` (admin toolbar, etc.) are pushed to `z-index: 1` while the
  overlay is active so they don't visually clash with the maximized editor.
- `.vertical-tabs__panes` gets `z-index: auto !important` to stop node-edit vertical tabs from
  poking through the overlay.

## If you need to customize it

- Override `--fullscreen-editor-z` / `--fullscreen-overlay-z` (derived from `--ck-z-panel`) in
  your theme's CSS if another fixed element still overlaps the fullscreen editor.
- Target `[data-fullscreen="fullscreeneditor"]` / `[data-fullscreen="fullscreenoverlay"]`
  directly for any layout tweaks — no Drupal render API involved, just plain selectors.
- The button's two icon states come from `icons/fullscreen-big.svg` (enter) and
  `icons/fullscreen-cancel.svg` (exit); swapping the toolbar icon requires overriding the
  `ckeditor5_fullscreen/fullscreen` library, not a theme function.
