<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VVJC JavaScript API — `Drupal.vvjc.*`

Front-end behavior attaches under `Drupal.behaviors.VVJCarousel` and runs inside the
`<vvjc-carousel>` custom element (extends `vvj_core`'s `VvjElementBase`; lazy IntersectionObserver
hydration, AbortController-tracked listeners, resize/orientation throttling, reduced-motion and
Page-Visibility awareness). Shipped by the `vvjc` library (`js/vvjc-carousel-element.js`,
`js/vvjc.js`). In v2 these methods delegate to methods on the element instance; the public surface
is unchanged from v1.

## Selecting a carousel

Every method that targets one carousel accepts a **deeplink identifier**, a **CSS selector**, or an
**`Element`** reference.

```js
Drupal.vvjc.goToSlide('gallery', 3);      // jump to slide 3 (1-based)
Drupal.vvjc.nextSlide('gallery');         // advance one slide
Drupal.vvjc.prevSlide('gallery');         // back one slide
Drupal.vvjc.pause('gallery');             // pause autoplay
Drupal.vvjc.resume('gallery');            // resume autoplay
Drupal.vvjc.getCurrentSlide('gallery');   // -> number (1-based)
Drupal.vvjc.getTotalSlides('gallery');    // -> number
Drupal.vvjc.getInstance('#vvjc-12345');   // -> the <vvjc-carousel> element
```

## Page-wide

```js
Drupal.vvjc.pauseAll();          // pause every carousel on the page
Drupal.vvjc.resumeAll();         // resume every carousel on the page
Drupal.vvjc.getAllInstances();   // -> array of <vvjc-carousel> elements
```

## Deep linking

When *Enable deep linking* is on **and** dots navigation is on, each slide gets a shareable
fragment `#carousel3d-<identifier>-<n>` (n is 1-based). The `<vvjc-carousel>` reads
`data-deeplink-id` / `data-deeplink-enabled` (emitted by the template) and syncs the URL fragment
with the active slide via `vvj_core`'s deeplink bridge. Identifiers are cleaned to
`^[a-z][a-z0-9-]*[a-z0-9]$` (max 20) and must avoid the reserved words `carousel3d, carousel,
slide, vvjc, vvj`.
