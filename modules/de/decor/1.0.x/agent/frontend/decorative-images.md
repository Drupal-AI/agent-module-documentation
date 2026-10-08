<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decor — marking decorative images (frontend usage)

## Install & enable
```
composer require drupal/decor
drush en decor -y
```
No further setup. `decor_page_attachments()` (in `decor.module`, implementing
`hook_page_attachments()`) attaches the `decor/decor` library to **every** page, so the
behavior is available site-wide once enabled.

## Library
`decor.libraries.yml`:
```yaml
decor:
  js:
    js/decor.js: {}
  dependencies:
    - core/drupal
    - core/once
```
Pure front-end asset — no CSS ships with the module. `is-decor` is added by JS only (you may
target it in your own theme CSS).

## How to mark images as decorative
Add one of these to a **container** element in your Twig templates (theme layer). Every `<img>`
inside that container is treated as decorative — no per-image markup needed:

- `class="js-decor"` — recommended
- `class="js-decorative-image"` — legacy alias
- `data-decor="img"` — attribute form

Example:
```twig
<div class="js-decor">
  <img src="/themes/custom/x/hero.jpg">
</div>
```

## What the behavior does
`Drupal.behaviors.decor.attach()` in `js/decor.js`:
1. Builds a selector list from the three markers above and runs
   `context.querySelectorAll(selectors.join(','))`.
2. Wraps matched elements in `once('decor-image', elements)` so each is processed a single time
   (also safe under AJAX re-attach).
3. For every `<img>` inside each matched element it:
   - adds class `is-decor`,
   - sets `alt=""`,
   - sets `role="presentation"`,
   - removes any `title` attribute.

This implements [WCAG H67](https://www.w3.org/WAI/WCAG22/Techniques/html/H67) (null alt text and
no title on images assistive tech should ignore) toward SC 1.1.1 Non-text Content (Level A). The
image is removed from the accessibility tree; the DOM/HTML source in the database is unchanged —
the treatment is applied at render time in the browser.

## Notes & extension
- Runs client-side; images are still requested and displayed, only their accessibility semantics
  change. Users with JS disabled keep the original `alt`/`title`.
- Apply the marker to the smallest container that groups only decorative images — any meaningful
  `<img>` inside a marked container will also be silenced.
- Style decorative images by targeting the added `.is-decor` class in your theme.
- No configuration, permissions, routes, or services are provided; behavior is fixed in `js/decor.js`.
