# Route Title Updater — manual setup guide

**Route Title Updater** (`route_title_updater`) lets you change the page title of
almost any route on your site — including titles defined by core, contributed
modules, or your theme — **without patching core, hacking contrib, or overriding
templates**. It's aimed at SEO optimization, UX refinement, and the kind of
title governance larger sites need when the default route titles are too limited.

The workflow is simple: after enabling the module you click **Configure**, and you
get a listing of the routes on your site that have a title (from both custom and
contributed modules). Pick a route, override its title to whatever you want, and
save. As you edit, built‑in SEO validation runs automatically to flag titles that
won't serve you well (for example ones that are too long or too short).

It builds only on core's **System** module and leaves no code footprint behind —
no core hacks, no template overrides, no code changes required. The overrides are
stored as configuration and applied dynamically at render time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone settings page** to describe separately — you work
entirely from the route listing reached via the **Configure** link, as described
below.

## How to use it

1. After enabling the module, click its **Configure** link (on the
   **Extend / Modules** list, or from the module's admin action).
2. You'll see a listing of the available routes that carry a route title, drawn
   from your custom and contributed modules.
3. Select a route whose title you want to change.
4. Enter your new title. The built‑in SEO validation runs as you type, warning you
   about title lengths and other SEO concerns.
5. Save. The new title is applied to that route's pages dynamically — no template
   or code changes needed.
