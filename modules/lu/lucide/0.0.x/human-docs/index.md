# Lucide — manual setup guide

**Lucide** (`lucide`) makes the [Lucide](https://lucide.dev) open‑source icon
library available inside Drupal as an **icon pack** for Drupal 11's Icon API.
Once it is installed, Lucide's 1,900+ clean, consistent, hand‑crafted SVG icons
are auto‑discovered and registered, so you can pick them anywhere Drupal's Icon
API is offered — in themes, in components, and in modules that build on the icon
system.

There is nothing to configure in an admin form: the module simply registers the
icon pack. The one setup step that matters is getting the Lucide JavaScript
library onto disk, because the icons render client‑side from lightweight
`<i data-lucide="icon-name">` markers via the Lucide runtime. The module ships a
Drush command (`drush lucide:download`) to fetch that library for you, and also
supports installing it through Composer.

Because the icons are static front‑end assets, Lucide has no content model and no
access‑control role — it is purely a theming/media feature. It requires
**Drupal 11.1+** and **PHP 8.3+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, then fetch the
   Lucide JavaScript library so the icons render.

There is **no configuration page** for this module — it registers the Lucide icon
pack automatically and has no settings form.

## Where it lives in the admin menu

Lucide adds no admin page of its own. After installation the Lucide icons appear
in Drupal's icon picker wherever the Icon API is used (for example when choosing
an icon for a menu link, a component, or a block, depending on your theme and the
other modules you have enabled).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the Lucide JavaScript library is present in `/libraries/lucide/` —
   run `drush lucide:download`, or install it via Composer's libraries
   mechanism.
3. Attach the icon library where you need it — the module exposes a
   `lucide/lucide` asset library you can attach from a theme or component — and
   reference an icon through the Icon API, or place a marker such as
   `<i data-lucide="camera"></i>` in your markup and let the Lucide runtime
   render it.
4. Browse the full catalogue of icon names at
   [lucide.dev/icons](https://lucide.dev/icons).
