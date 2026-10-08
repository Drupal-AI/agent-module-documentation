# Confetti — manual setup guide

**Confetti** (`confetti`) adds a celebratory confetti animation to your site — a
cheerful on-screen burst shown on the pages you choose. The burst plays
automatically when a visitor **loads** one of those pages (about half a second
after it appears, for roughly six seconds); there is no form-submission or event
to configure. It is a small, purely front-end touch built on the well-known
[canvas-confetti](https://github.com/catdad/canvas-confetti) JavaScript library,
which the module loads from a public CDN at runtime.

The module has no other modules as dependencies and works once enabled and
pointed at a page. A small settings form lets you specify the URL sub-path(s)
where the confetti effect should appear. The colours and timing are set in the
module's JavaScript file (`js/confetti.js`) and can be changed by editing it —
that is what the project means by optional "customisation". The effect is
decorative and has no content or access-control role beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no full configuration page to walk through — setup is a single small
form, covered in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the module's settings form (available to users with the module's
   configuration permission, from the site's **Configuration** area).
3. Enter the **URL sub-path** of the page (or pages) where you want the confetti
   burst to appear.
4. Save, and clear the cache if needed. Visit the configured page — you should see
   the confetti animation play.

Because the effect is purely client-side, it adds no meaningful server load and
creates no content. To remove it, clear the configured path or uninstall the
module.
