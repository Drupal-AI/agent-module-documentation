# Jumper — manual setup guide

**Jumper** (`jumper`) provides a small, configurable "jump" block that smoothly
scrolls the page — either back to the top or to any element you point it at. It's
the classic "back to top" button, but it can also power "jump anywhere"
navigation: give it a CSS selector such as `#contact` and clicking it glides the
page to that spot, the way anchor links behave on a single‑page site.

Under the hood it's deliberately lean: vanilla JavaScript, no jQuery. It uses the
browser's native smooth scrolling out of the box, and if you install the optional
[Jump.js](https://github.com/callmecavs/jump.js) library it uses that instead
(with a requestAnimationFrame polyfill for older browsers). The button appears once
the visitor has scrolled past a distance you choose, and you can style it with a
provided colour and rounded shape or override everything with your own CSS.

Jumper depends on core's **Block** module (for placing the button) and on
**Blazy** — but only to reuse Blazy's shared JavaScript helper utilities; no
lazy‑load assets are loaded. There are no routes, permissions, or server‑side data
handling: the block is client‑side scrolling driven by trusted block‑admin
settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally add the Jump.js library.
2. [Configuration](configuration/index.md) — place the Jumper block and tune its
   settings, field by field.

## Where it lives in the admin menu

Jumper adds no dedicated settings page. You place its block from **Structure →
Block layout** (`/admin/structure/block`) — look for the **Jumper** block category
— and all of its options live on that block's configuration form.

## How to use it

The common setup is a "jump to top" button in the footer:

1. Place the **Jumper** block into your footer (or any region) from **Structure →
   Block layout**.
2. Adjust its settings — scroll target, animation duration, when the button
   appears, icon and colour (see [Configuration](configuration/index.md)).
3. Save. The button appears once the visitor scrolls past your activation point.

You can also make ordinary links behave as jumpers: add `class="jumper"` to any
link or button that has an `[href="#id"]` or `[data-target="#id"]`, and the
`jumper/load` library (present once the block is placed) handles the smooth scroll.
Menu links work too — add a menu item whose path contains a hash, such as
`/about#block-cta` or `#block-contact`.
