# AnimateCSS — manual setup guide

**AnimateCSS** (`animatecss`) brings the popular
[Animate.css](https://animate.style/) library (v4.1.1) — a collection of around 90
ready-to-use, cross-browser CSS animations — into Drupal. The base module's job is
simple: it loads the Animate.css stylesheet on every page so you can animate any
element just by adding a couple of CSS classes in your templates or markup.

To animate an element, give it the base class `animate__animated` plus an animation
name class (note the `animate__` prefix), for example:

```html
<h1 class="animate__animated animate__bounce">An animated element</h1>
```

The catalogue covers attention-seekers (bounce, flash, pulse, shakeX, tada…),
entrances (fadeIn, slideInUp, zoomIn, backInDown…) and exits (fadeOut,
slideOutDown, hinge…), plus modifier classes for delay (`animate__delay-1s` …
`-5s`), speed (`animate__slow`/`animate__fast`), and repetition
(`animate__infinite`, `animate__repeat-1` … `-3`).

The base module has no settings page, no permissions, and no configuration of its
own. If you would rather bind animations to CSS selectors from an admin UI — without
touching templates — enable the optional **AnimateCSS UI** submodule
(`animatecss_ui`), which adds a full configuration interface. This guide covers the
base module.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and (optionally) self-host the Animate.css library or enable the UI submodule.

## How to use it

With the base module enabled, the Animate.css library is attached to every page
automatically, so you can add animation classes anywhere:

- **In a Twig template or block markup** — add `animate__animated` and an
  `animate__<name>` class to the element you want to animate.
- **From JavaScript** — toggle the same classes to trigger an animation on demand:

  ```js
  const el = document.querySelector('.my-element');
  el.classList.add('animate__animated', 'animate__bounceOutLeft');
  ```

- **In a specific render array only** — if you would rather not load the library
  site-wide, you can attach it to a single render array in custom code:

  ```php
  $build['#attached']['library'][] = 'animatecss/animate.css'; // or 'animatecss/animate.cdn'
  ```

### Where the stylesheet comes from

The base module attaches the library on every page **only when the AnimateCSS UI
submodule is not enabled**. It uses a self-hosted copy at
`/libraries/animate.css/animate.min.css` if one is present, and otherwise falls back
to the Cloudflare CDN. The status report (**Reports → Status report**) shows whether
the local copy or the CDN is in use. See [Installation](installation/index.md) for
how to self-host the library.
