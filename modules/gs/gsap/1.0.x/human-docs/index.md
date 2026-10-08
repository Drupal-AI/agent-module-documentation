# GSAP — manual setup guide

**GSAP** (`gsap`) connects your Drupal site to the GreenSock Animation
Platform, the widely used JavaScript library for high‑performance web
animation. What makes this module unusual is that it treats animations as
*content*: instead of writing JavaScript in a theme, a site builder creates each
animation as a configuration entity through the admin UI — targeting a CSS
selector and describing a `to`, `from`, or `scrollTrigger` animation — and the
module applies it on the front end.

Under the hood the module declares GSAP's core library plus each of its plugins
(ScrollTrigger, Flip, Draggable, MotionPath, MorphSVG, SplitText, DrawSVG and
more) as individual Drupal libraries, so a theme or module can attach exactly
the plugins a page needs and nothing more. Scroll‑driven animation is the
assumed default: the bundled `animations.js` reads your configured animation
entities and applies them with ScrollTrigger already attached.

One thing to know before you deploy: out of the box every GSAP library loads
from a third‑party CDN (`cdn.jsdelivr.net`), not from a local file. That has
consequences for Content‑Security‑Policy, offline/air‑gapped sites, and visitor
privacy. A `composer.libraries.json` is shipped that can install GSAP locally,
but the library definitions do not point at it by default — see
[Installation](installation/index.md) for how to go local. Note too that some
GreenSock plugins (MorphSVG, SplitText, DrawSVG, ScrambleText, Inertia,
GSDevTools) are GreenSock's paid "Club" plugins — check their licensing before
relying on them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide between CDN and local library delivery.
2. [Configuration](configuration/index.md) — the settings form and the animation
   entity CRUD, field by field.

## Where it lives in the admin menu

GSAP adds two admin areas, both behind the single **Administer GSAP**
(`administer gsap`) permission:

- The **settings form** at **Configuration → Content authoring → GSAP**
  (`/admin/config/content/gsap`).
- The **animation entity collection** at **Structure → GSAP**
  (`/admin/structure/gsap`), where you add, edit, and delete individual
  animations.
