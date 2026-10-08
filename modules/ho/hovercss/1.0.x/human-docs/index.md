# HoverCSS — manual setup guide

**HoverCSS** (`hovercss`) brings the popular
[Hover.css](https://ianlunn.github.io/Hover/) library into Drupal — a ready‑made
collection of CSS3‑powered hover effects you can apply to links, buttons, logos,
SVGs, featured images, and just about any other element. Instead of hand‑writing
transitions and keyframes, you attach one of Hover.css's effect classes and get a
polished animation on hover: grows and shrinks, pulses, floats, underline slides,
icon spins, and many more.

It's a front‑end/theming helper — it changes presentation only and has no content
or access‑control role. The module ships an optional **`hovercss_ui`** submodule
that adds a user interface for applying effects, so you don't have to add the
classes by hand.

One thing to know up front: like many library‑integration modules, HoverCSS
expects the **Hover.css library files** themselves to be present. You download the
library from its GitHub project and place it where the module can find it (the
module's `README.md` gives the exact path). Once the library is in place, the
effect classes are available to use.

> A gentle reminder from the module's own notes: animations can improve the feel of
> an interface, but overused they get in the way — apply them with restraint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the Hover.css library, and (optionally) enable the UI submodule.

There is **no central settings page** for this module — you apply effects either by
adding Hover.css classes to your markup/theme, or through the optional
`hovercss_ui` submodule.

## Where it lives in the admin menu

The base module adds no admin settings page. If you enable the **`hovercss_ui`**
submodule, it provides an interface for applying the hover effects; otherwise you
add the Hover.css effect classes directly in your theme or content markup.

## How to use it

- **By hand:** add the relevant Hover.css class (for example `hvr-grow`,
  `hvr-float`, `hvr-underline-from-left`) to the element you want to animate on
  hover, in your Twig template, block, or markup.
- **With the UI:** enable the `hovercss_ui` submodule and use its interface to apply
  effects without editing markup directly.
