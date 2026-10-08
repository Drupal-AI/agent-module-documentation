# Container Query Images — manual setup guide

**Container Query Images** (`container_query_images`) extends Drupal's core
**Responsive Image** module so that images size themselves to the width of their
**container** rather than the width of the browser **viewport** — using modern CSS
**container queries**. It depends on core's Image, Responsive Image, and Breakpoint
modules.

This solves a problem that viewport‑based responsive images handle badly:
component‑ and layout‑driven designs where the *same* component appears in
different‑width regions. A card shown in a narrow sidebar and the same card shown in
a wide main column should load different image sizes — but classic responsive images
only know the viewport width, not how much room the component actually has. Container
Query Images lets the image respond to its container, so each instance gets a
correctly sized variant.

There is **no settings screen** of its own. You use it entirely through the standard
Responsive Image workflow: you define breakpoints whose group name contains
"container", build a Responsive Image Style on that group, and the module
automatically detects and switches on container‑query mode. It governs image
*variant selection* for display only — it has no content or access‑control role. One
thing to keep in mind: CSS container queries require a **modern browser** to work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Responsive Image dependencies.

There is **no configuration page** for this module. Setup happens on your
breakpoints and Responsive Image Styles — see "How to use it" below.

## How to use it

1. **Define container breakpoints.** In your theme's `*.breakpoints.yml`, create
   breakpoints whose **group name contains `container`** — for example a group like
   `MYTHEME.container` with entries such as "Container SM (240px)" using a
   `min-width` media query. The module recognises "container" in the group name and
   enables container‑query mode.
2. **Create a Responsive Image Style.** Go to **Configuration → Media → Responsive
   image styles** (`/admin/config/media/responsive-image-style`), add a style, and
   pick your **container** breakpoint group.
3. **Map your image styles** to each breakpoint in that style, as you would for any
   responsive image style.
4. **Use the standard Responsive Image formatter.** On the relevant field's *Manage
   display*, format the image field with the core Responsive Image formatter and
   select the style you just created. Images will now size to their container.
