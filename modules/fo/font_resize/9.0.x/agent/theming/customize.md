<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming & customization

## Requirement: relative font units
The default block resizes the `<html>` element's `font-size`. This only visibly changes page text
if the active theme sizes text in **relative units (em / rem)** rather than fixed px. This is the
module's stated prerequisite ("the theme uses relative font sizing"). On a px-based theme the
`<html>` size changes but individual elements keep their absolute sizes, so the widget appears to
do nothing.

## Styling the control
The block markup exposes stable hooks for CSS (add rules in your theme):
- `.box` — wrapper `<div>`.
- `a.font_resize-button` — the three links; ids `#font_resize-minus`, `#font_resize-default`,
  `#font_resize-plus`.
- `.font_resize-disabled` — added by the JS to A- or A+ when the −10 / +10 step limit is reached;
  style this (e.g. dimmed / `pointer-events:none`) to signal the limit. The module ships no CSS,
  so all visual styling is up to your theme.

## Resizing only part of the page (custom target)
Per the module README, to resize a specific region/class/id instead of the whole document:
1. Copy `js/example-font_resize.js` into your theme/module as a new JS file and change the target
   selector from `$('html')` to your element, e.g. `$('.main-content')` or `$('#content')`. You
   may also override the option values (`btnMinusMaxHits`, `btnPlusMaxHits`, `sizeChange`, and the
   three button ids) in the object passed to `.font_resize({...})`.
2. Define a library that loads `core/jquery`, then `font_resize/font_resize` (the plugin), then
   your new initializer file — order matters, the plugin must load before the initializer.
3. Attach that library from your own block/render array (the three button ids must exist in the
   DOM). You can reuse Font Resize's "Resize block" for the markup, but then attach your library
   instead of relying on the shipped `font_resize/font_resize_example` initializer to avoid also
   binding to `<html>`.

Because the button ids are fixed, a custom initializer and the shipped one target the same three
controls; run only one initializer per page to avoid double-binding the click handlers.
