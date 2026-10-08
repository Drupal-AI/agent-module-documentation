# Scene — manual setup guide

**Scene** (`scene`) integrates the **Scene.js** library into Drupal — a JavaScript
and CSS timeline‑based animation library for building animated, sequenced effects
on a website. It gives your theme and components access to Scene.js so you can
create timeline‑driven animations with a declarative syntax, precise timing
control, easing functions, keyframes, playback control (play, pause, reverse,
seek) and responsive behaviour.

It solves the "I want polished, sequenced animations without hand‑rolling the
tooling" problem for front‑end and theming work. Scene.js supports animating both
CSS properties and SVG elements, and the module simply makes the library available
to your Drupal site so you can use it from your theme or custom components.

This is a front‑end/theming building block. It provides the Scene.js library and
has no content model or access‑control role beyond the permission it defines —
enabling it makes the library available, and the actual animations are something
you build in your theme. It has no module dependencies and no submodules.

Note that, as the project describes, you download the Scene.js library from GitHub
as part of setup; see the project's own README for the exact library‑placement
steps for your build.

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the Scene.js library, and enable it.

## How to use it

Once the module is enabled and the Scene.js library is in place, use Scene.js from
your theme or components to build timeline animations — declaring scenes,
keyframes and easing, and controlling playback. The module's job is simply to make
the library available; the animations themselves live in your front‑end code.
