# SVG.js — manual setup guide

**SVG.js** (`svgjs`) integrates the lightweight
[SVG.js](https://svgjs.dev/) JavaScript library into Drupal, giving site builders
and front‑end developers a clean, dependency‑free way to create, manipulate, and
animate SVG graphics from their own JavaScript — dashboards, icons, maps, charts,
and small micro‑interactions. It renders no markup and defines no routes of its
own; it simply makes the `SVG()` global available on the page so your theme or
module code can use it.

The problem it solves is loading and wiring up SVG.js consistently. Enable the
module and, on every page (outside the installer), it attaches the SVG.js library:
it uses a local copy at `/libraries/svgjs/svg.min.js` when one is present,
otherwise it falls back automatically to loading SVG.js from the jsDelivr CDN
(`@svgdotjs/svg.js@3.2.0`). It also ships a few small PHP helper functions
(element types, easing, transform, fill‑rule option lists) intended for building
SVG‑related admin forms.

Setup is minimal and zero‑config: enable it and it works immediately via the CDN.
There is no settings page. For production you will usually want to download SVG.js
into `/libraries/svgjs/` so it is served locally rather than from the CDN — see
Installation. It has no module dependencies and supports Drupal 8.8 through 11.
Because the library is global, attach your drawing code with `Drupal.behaviors`
and `once()`.

Two things worth knowing. First, the module does **not** accept or render
user‑supplied SVG, so it adds no SVG‑sanitisation or stored‑XSS surface of its
own — it only loads a JavaScript asset. Second, until you install the library
locally it loads a third‑party asset from the jsDelivr CDN on every page; if your
site must avoid external requests (for privacy, offline, or content‑security
reasons), install the local copy so nothing is fetched from the CDN. Note also
that this project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally add a local copy of the SVG.js library.

## How to use it

There is no admin page. Once enabled, the `SVG()` API is available globally. Attach
the library and write your drawing code from a theme or module. For example, from
a module you can attach the library:

```php
// mymodule.module
function mymodule_page_attachments(array &$attachments) {
  $attachments['#attached']['library'][] = 'svgjs/svgjs.js';
}
```

and drive it from a Drupal behavior:

```javascript
(function (Drupal, once) {
  Drupal.behaviors.exampleSvg = {
    attach: function (context) {
      once('example-svg', '.svg-target', context).forEach(function (el) {
        var draw = SVG().addTo(el).size(300, 300);
        draw.rect(100, 100).fill('#f06').animate(800).move(150, 150);
      });
    }
  };
})(Drupal, once);
```
