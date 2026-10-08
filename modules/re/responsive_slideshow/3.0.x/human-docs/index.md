# Responsive Slideshow — manual setup guide

**Responsive Slideshow** (`responsive_slideshow`) provides an image slideshow
built directly on **Bootstrap's own carousel component**, for sites running a
**Bootstrap‑based theme**. On installation it creates a **Responsive Slideshow**
content type and a matching **block**; you add slideshow content, place the block
in a theme region, and it renders as a responsive Bootstrap carousel with the
framework's standard indicators and controls.

The whole value of this module is in the qualifier: *for a Bootstrap site.*
Because a Bootstrap theme already loads the framework's JavaScript and CSS,
driving its built‑in carousel adds **no extra slider library, no extra page
weight, and no styling you have to override** — the slideshow simply looks like
part of the theme. On a site that is **not** using Bootstrap, this is the wrong
choice; you'd be better served by a self‑contained slideshow module. So the first
thing to establish is whether your theme is Bootstrap‑based (the module targets
**Bootstrap 5**).

Two caveats worth knowing before you commit to a carousel at all:

- **Accessibility.** Bootstrap's carousel has accessibility limitations that
  Bootstrap's own documentation acknowledges — auto‑advance without an accessible
  pause control, and slide transitions that aren't announced to assistive tech.
  If you have a conformance obligation, disable auto‑advance and verify keyboard
  operation rather than assuming the framework handled it.
- **Effectiveness.** Content past the first slide is largely unseen by visitors.
  Build a slideshow because it genuinely serves the content, not just because a
  design template had one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (on a Bootstrap‑themed site).
2. [Configuration](configuration/index.md) — add slideshow content, tune the
   carousel settings, and place the block.

## Where it lives in the admin menu

The module's user‑interface settings form is registered as
`responsive_slideshow.settings` and is protected by the **Administer responsive
slideshow** permission. Slideshow content is created via the **Responsive
Slideshow** content type, and the slideshow appears on the site through the
**Responsive Slideshow** block placed at **Structure → Block layout**. See
[Configuration](configuration/index.md) for the full flow.
