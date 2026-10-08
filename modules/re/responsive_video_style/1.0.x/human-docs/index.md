# Responsive video style — manual setup guide

**Responsive video style** (`responsive_video_style`) brings **breakpoint‑based
responsive delivery to video**, the way core's Responsive Image does for
pictures. It adds a configuration entity that maps **breakpoints to Video
styles**, plus a field formatter that renders responsive video output for
single‑file media video source fields — so a video can be delivered with the most
appropriate rendition for mobile, tablet, or desktop instead of one size for
everyone.

It sits on top of the **Video Style** module: that base module defines the
reusable video styles and provider APIs, while Responsive video style decides
*which* video style is used *at which breakpoint*. It ships a bundled breakpoint
group named **Responsive Video** (with Mobile, Tablet, and Desktop) so you have
sensible breakpoints to start from, and supports fallback styles and optional
poster images for native HTML5 video output.

There are two responsive **strategies** to choose between when you create a
responsive video style — *source* (providers contribute alternative sources
inside a single tag) and *variant* (separate video variants, one shown at a time
by the front end). All video styles used within one responsive video style must
share the same strategy and render mode. The current scope focuses on file‑backed
video on single‑file media video source fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Video Style and this module
   with Composer, and enable them.

The responsive video styles are managed through their own admin listing (see
"Where it lives in the admin menu"), and the field‑level setup happens on a media
video source field's display — described in "How to use it" below.

## Where it lives in the admin menu

Responsive video styles are managed at **Configuration → Media → Video styles →
Responsive** (`/admin/config/media/video-styles/responsive`), where you create
and edit the breakpoint‑to‑Video‑style mappings.

## How to use it

1. In the base **Video Style** module, create one or more **Video styles**.
2. Go to **Configuration → Media → Video styles → Responsive** and create a
   **Responsive video style** — choose a **breakpoint group** (the bundled
   *Responsive Video* group is a good start) and a **responsive strategy**
   (*source* or *variant*).
3. **Map** one or more Video styles to the relevant breakpoints, and set the
   fallback style(s). Remember all mapped styles must share the chosen strategy
   and render mode.
4. On your **media video source field's** display (**Manage display**), select the
   **Responsive video style** formatter, then pick the responsive video style you
   created.

Video is now delivered per breakpoint according to your mapping and the provider's
capabilities.
