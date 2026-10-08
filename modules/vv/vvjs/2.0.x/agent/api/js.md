# VVJS JavaScript API and Views tokens

## `Drupal.vvjs.*` — drive a slideshow from external JS

Each method takes a **target**: the deeplink identifier, a CSS selector, or an `Element` reference.

```js
Drupal.vvjs.goToSlide('gallery', 3);   // jump to slide 3 (1-based)
Drupal.vvjs.nextSlide('gallery');      // advance one
Drupal.vvjs.prevSlide('gallery');      // back one
Drupal.vvjs.pause('gallery');          // pause autoplay
Drupal.vvjs.resume('gallery');         // resume autoplay
Drupal.vvjs.isPaused('gallery');       // → boolean | null
Drupal.vvjs.isInitialized('gallery');  // → boolean | null
Drupal.vvjs.pauseAll();                // pause every slideshow on the page
Drupal.vvjs.resumeAll();               // resume every slideshow on the page
Drupal.vvjs.getCurrentSlide('gallery');// → number (1-based)
Drupal.vvjs.getTotalSlides('gallery'); // → number
Drupal.vvjs.getInstance('#vvjs-12345');// → <vvjs-slideshow> element
Drupal.vvjs.getAllInstances();         // → array of <vvjs-slideshow> elements
```

Behavior key: `Drupal.behaviors.VVJSlideshow`. The rendered element is a `<vvjs-slideshow>` custom
element (v1 was a `<div>`; `.vvjs` selectors still match). This API surface is preserved from v1.

## `[vvjs:…]` Views tokens

In Views **header / footer / empty** text areas with *Use replacement tokens from the first row* enabled,
core Twig tokens (`{{ title }}`) are not available. Use VVJS tokens, resolved by the shared
`vvj_core.token_resolver` service (`src/Hook/VvjsTokenHooks.php`, wired with the nullable
`@?vvj_core.token_resolver`):

| Twig token | VVJS token |
|---|---|
| `{{ title }}` | `[vvjs:title]` |
| `{{ field_image }}` | `[vvjs:field_image]` |
| plain-text variant | append `:plain` → `[vvjs:title:plain]` |

Tokens read the **first row** of rendered View fields only; complex field rewrites are not supported.
`:plain` emits the plain-text value — apply your own escaping expectations accordingly when theming.

## Notes for integrators / upgraders

- Public API, plugin id (`views_vvjs`), theme hook (`views_view_vvjs`), all option keys, library names,
  and CSS class names are unchanged from 1.x — a `composer update drupal/vvjs && drush updb && drush cr`
  is a drop-in upgrade. The only rendered change is the outer tag (`<div>` → `<vvjs-slideshow>`).
- Runtime lifecycle (single web-component class, lazy IntersectionObserver hydration,
  AbortController-tracked listeners, ARIA live-region announcer) lives in `js/vvjs-slideshow-element.js`
  + `js/vvjs.js` and the `vvj_core` element-base/a11y/keyboard-nav/deeplink-bridge libraries.
