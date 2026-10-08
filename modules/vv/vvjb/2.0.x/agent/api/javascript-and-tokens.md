<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public JS API and Views tokens

## JavaScript API — `Drupal.vvjb.*`
Exposed by `js/vvjb.js` (behavior `Drupal.behaviors.vvjbCarousel`). Each method accepts
a target that is the deep-link identifier, a CSS selector, or an `Element` reference,
resolving to a `<vvjb-carousel>` custom element (defined in
`js/vvjb-carousel-element.js`, extending `Drupal.Vvj.ElementBase` from `vvj_core`).

```js
Drupal.vvjb.goToSlide('products', 3);   // jump to page 3 (1-indexed) → boolean
Drupal.vvjb.nextSlide('products');      // advance one page → boolean
Drupal.vvjb.prevSlide('products');      // back one page → boolean
Drupal.vvjb.pause('products');          // pause autoplay → boolean
Drupal.vvjb.resume('products');         // resume autoplay → boolean
Drupal.vvjb.getCurrentSlide('products'); // → number (1-indexed)
Drupal.vvjb.getTotalSlides('products');  // → number
Drupal.vvjb.getInstance('#vvjb-12345');  // → <vvjb-carousel> element
```

The element's own public methods (`goToSlide`, `nextSlide`, `prevSlide`, `pause`,
`resume`, `getCurrentSlide`, `getTotalSlides`) mirror these. The API surface, plugin id
`views_vvjb`, theme hook `views_view_vvjb`, library names, behavior key, and all CSS
class names are preserved verbatim from 1.x (the outer tag changed `<div>` →
`<vvjb-carousel>`; `.vvjb` selectors still match).

## Views tokens — `[vvjb:FIELD]`
Provided by `Drupal\vvjb\Hook\VvjbTokenHooks` (`hook_token_info` / `hook_tokens`),
delegating to the shared `vvj_core.token_resolver` service. Usable in a View's header,
footer, or empty text **only** when *Use replacement tokens from the first row* is on.
Standard Twig tokens (`{{ title }}`) do not work in those areas — use VVJB tokens:

- `[vvjb:FIELD_NAME]` — rendered HTML of that field from the **first row**.
- `[vvjb:FIELD_NAME:plain]` — plain-text variant.

Example: `{{ title }}` → `[vvjb:title]`; `{{ field_image }}` → `[vvjb:field_image]`.
Values are read from the first rendered row only; complex field rewrites are unsupported.
The token type declares `needs-data: view`; the `vvjb` hook returns nothing (and safely
no-ops) if `vvj_core` is not yet enabled (nullable service, upgrade window).
