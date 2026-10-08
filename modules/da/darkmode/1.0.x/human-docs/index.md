# Darkmode — manual setup guide

**Darkmode** (`darkmode`) integrates the **Darkmode.js** JavaScript library to add
a floating light/dark theme toggle button to your site. The button appears (by
default in the bottom‑left corner) and, when clicked, inverts the page colors
client‑side. It's a lightweight, visitor‑facing switcher rather than a full
theming system.

The module ships a single **"Darkmode Switcher" block**. Placing that block in any
region loads the Darkmode.js library and a small initiator script, then hands the
block's configuration to the browser — so the button only shows up once you place
the block. Everything is client‑side: there's no server‑side rendering, no stored
user data, and no security‑sensitive endpoints.

All of its options are **per‑block**: the toggle's position (bottom/right/left
offsets), transition time, the mix and background colors, the dark and light button
colors, whether to remember the choice in a cookie, and a default theme mode
(auto/light/dark). Because the settings live on the block, you can even place
multiple switchers with different styling. It supports Drupal 9.2 through 11.

One installation wrinkle to know up front: **Darkmode.js is a front‑end library**
that Composer installs as an npm‑asset, which needs a little Composer setup the
first time — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — set up the npm‑asset library, install
   with Composer, and enable the module.

There is **no central configuration page** — all settings are on the switcher
block itself, described in "How to use it" below.

## Where it lives in the admin menu

Darkmode adds no admin settings page. You place and configure its switcher from
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Install the Darkmode.js library and the module (see
   [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and place the **Darkmode Switcher** block in
   a region.
3. In the block's configuration, style the toggle:
   - **Bottom / right / left offsets** — where the button sits (e.g. `64px`,
     `32px`, or `unset`).
   - **Transition time** — how long the fade takes (e.g. `0.5s`).
   - **Mix color** used when inverting, and the widget **background color**.
   - **Dark button color** and **light button color**.
   - **Save in Cookies** — persist a visitor's choice across page loads.
   - **Theme mode** — default to **Auto** (match the OS), **Light**, or **Dark**.
4. Use the block's normal **visibility conditions** to limit it to certain pages
   or roles, and save.

To remove the switcher, unplace or disable the block. You can add multiple
switcher blocks in different regions if you need different styling per theme.
