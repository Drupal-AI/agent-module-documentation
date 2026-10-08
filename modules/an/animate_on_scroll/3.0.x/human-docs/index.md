# Animate On Scroll — manual setup guide

**Animate On Scroll** (`animate_on_scroll`) is a thin Drupal wrapper around the
popular third‑party [AOS](https://github.com/michalsnik/aos) ("Animate On
Scroll") JavaScript library. Once enabled, it loads AOS on every page and
initializes it, so you can make elements fade, zoom, slide, or flip into view as
the visitor scrolls — just by adding `data-aos` HTML attributes to your markup.

There is no settings form, no permissions, no services, and no Drupal
dependencies. All of the tuning happens through per‑element data attributes
(`data-aos`, `data-aos-duration`, `data-aos-delay`, `data-aos-offset`,
`data-aos-easing`, `data-aos-once`, and so on), which you can place in a Twig
template, a block body, a field template, or even the CKEditor source view. It's
purely a presentational front‑end enhancement — it stores nothing and has no
server‑side logic.

One important catch: the AOS library itself is **not bundled** with the module.
You must download it and place it in `/libraries/aos` in your Drupal root (see
[Installation](installation/index.md)). Until you do, the status report will warn
you that it's missing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the AOS library into `/libraries/aos`, and enable it.

## Where it lives in the admin menu

Nowhere — there is no configuration page. The only place the module surfaces in
the admin UI is the **Reports → Status report** (`/admin/reports/status`), which
warns you if the AOS library files are missing.

## How to use it

Once the module is enabled and the AOS library is in place, add a `data-aos`
attribute to any element you want to animate:

```html
<div data-aos="fade-up"
     data-aos-duration="600"
     data-aos-delay="100"
     data-aos-once="true">
  ...
</div>
```

Common values for `data-aos` include `fade-up`, `fade-left`, `zoom-in`,
`zoom-out`, `slide-up`, `slide-right`, and `flip-left`. Useful modifiers:

- **`data-aos-duration`** — how long the animation runs (milliseconds).
- **`data-aos-delay`** — stagger sibling items (e.g. cards in a grid) by giving
  each a different delay.
- **`data-aos-offset`** — trigger earlier or later (pixels before the element
  enters view).
- **`data-aos-easing`** — the easing curve, e.g. `ease-in-sine`.
- **`data-aos-once`** — set to `true` to animate only the first time.
- **`data-aos-anchor` / `data-aos-anchor-placement`** — sync an element's
  animation to another element's scroll position.

The full list of animations, easings, and attributes is documented by the
upstream AOS project.

**Customizing the init.** The module calls `AOS.init()` with no options. If you
need global AOS options (like `disable` on mobile, or a site‑wide default
`duration`), attach your own JavaScript after the module's library and call
`AOS.init({...})` yourself. If you add content dynamically, call `AOS.refresh()`
or `AOS.refreshHard()` afterward so the new elements are picked up.
