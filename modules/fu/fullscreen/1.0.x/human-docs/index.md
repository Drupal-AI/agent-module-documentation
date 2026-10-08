# Fullscreen — manual setup guide

**Fullscreen** (`fullscreen`) integrates **FullscreenX.js**, a tiny, zero-dependency,
promise-based fullscreen library, into Drupal. It gives your JavaScript a clean,
cross-browser way to trigger the browser's native fullscreen mode on any HTML
element — useful for video players, image galleries and lightboxes, presentations,
dashboards, and any content that benefits from a distraction-free view.

This is a developer-oriented module: it loads the library on every page and exposes
it as a global `FullscreenX` object, but it does not add any buttons or UI of its
own. You call the API from your own module or theme JavaScript. It works with no
configuration at all — enable it and start using the API.

A nice touch is its **dual loading strategy**: if the FullscreenX.js library is
present locally it uses that, and if not it automatically falls back to loading it
from the jsDelivr CDN. That means it works out of the box, though sites with a strict
Content Security Policy or an offline requirement will want to install the library
locally (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally install the library locally.

This module has **no configuration page** — it works out of the box with zero
configuration.

## How to use it

Once enabled, the `FullscreenX` global object is available on every page. Call it
from your JavaScript, for example:

```javascript
// Enter, exit, or toggle fullscreen on an element (by CSS selector or DOM node)
FullscreenX.request('#my-element');
FullscreenX.exit();
FullscreenX.toggle('#video-player');

// Listen to fullscreen state changes
FullscreenX.on('enter', () => console.log('Entered fullscreen'));
FullscreenX.on('exit', () => console.log('Exited fullscreen'));
```

For AJAX-friendly, reusable behaviour, wire it into a Drupal behavior in a custom
module or your theme:

```javascript
(function (Drupal, FullscreenX) {
  'use strict';
  Drupal.behaviors.myFullscreen = {
    attach: function (context, settings) {
      once('fullscreen-video', '.video-wrapper', context).forEach(function (element) {
        element.addEventListener('dblclick', function () {
          FullscreenX.toggle(element);
        });
      });
    }
  };
})(Drupal, FullscreenX);
```
