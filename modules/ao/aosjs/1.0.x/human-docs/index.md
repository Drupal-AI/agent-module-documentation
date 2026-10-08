# AOS JS — manual setup guide

**AOS JS** (`aosjs`) integrates the [AOS](https://github.com/michalsnik/aos) ("Animate On
Scroll") JavaScript library with Drupal, so page elements can fade, slide, zoom, or flip
into view as the visitor scrolls down (and up) the page. It's the quickest way to add
subtle scroll-driven motion to a landing page, gallery, or call-to-action without writing
any JavaScript yourself.

The base module does two things: it registers AOS as Drupal asset libraries (both the v2
and v3-beta releases, each available from a local copy or a CDN), and — as long as you
haven't enabled one of the submodules that takes over — it automatically attaches AOS to
every non-admin page and runs `AOS.init()`. That means once the module is on, you animate
an element simply by adding `data-aos` attributes to its markup. The module prefers a
self-hosted copy of AOS placed at `libraries/aos` and falls back to a CDN when the local
files aren't present.

The base module has **no settings page, no permissions, and no configuration** of its own.
For a point-and-click experience, two submodules extend it: **AOS JS UI**
(`aosjs_ui`) adds an admin UI for attaching animations to CSS selectors without editing any
markup, and **AOS JS Animate.css** (`aosjs_animatecss`) swaps AOS's built-in animation set
for the Animate.css library.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   pick the submodules (and optional self-hosted library) you need.

## Where it lives in the admin menu

The base module adds **no admin page** — it works purely by attaching the AOS library and
reading `data-aos` attributes from your markup. If you enable the **AOS JS UI** submodule,
it adds its own settings/selector screens; see that submodule's own documentation.

## How to use it

### Animate an element with markup

Add `data-aos` attributes to any element — a block, a Twig template, field markup, anything:

```html
<div data-aos="fade-up"
     data-aos-offset="200"
     data-aos-easing="ease-in-sine"
     data-aos-duration="600"
     data-aos-delay="100">…</div>
```

The main attributes are:

- **`data-aos`** — the animation to play. Names come in groups: `fade-*`, `flip-*`,
  `slide-*`, and `zoom-*` (for example `fade-up`, `zoom-in`, `slide-left`).
- **`data-aos-duration`** — how long the animation runs, in milliseconds.
- **`data-aos-delay`** — a delay before it starts; use different delays on sibling elements
  for a staggered "reveal" effect.
- **`data-aos-easing`** — the easing curve (for example `ease-in-sine`).
- **`data-aos-offset`** — how far into the viewport the element must scroll before the
  animation triggers.
- **`data-aos-anchor`** / anchor placement — tie one element's animation to the position of
  another.

That's all it takes on a standard install — the base module has already loaded and
initialized AOS for you.

### Prefer no markup edits?

Enable the **AOS JS UI** submodule to attach animations to CSS selectors from an admin
screen instead of adding attributes by hand (it also exposes AOS's `disable` option so you
can switch animations off on phone/tablet/mobile breakpoints).

### For developers

The base module ships PHP option helpers (animation names, easing functions, anchor
placements, disable options) that mirror the lists AOS supports — handy if you build your
own form. You can also add custom animation groups by implementing
`hook_aos_animation_names()`.
