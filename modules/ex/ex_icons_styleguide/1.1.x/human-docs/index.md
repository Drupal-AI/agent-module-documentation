# EX Icons Styleguide — manual setup guide

**EX Icons Styleguide** (`ex_icons_styleguide`) is a small bridge module that connects
the [External-use icons](https://www.drupal.org/project/ex_icons) (`ex_icons`) module
with the [Styleguide](https://www.drupal.org/project/styleguide) module. Once enabled,
it gathers all the icons that ex_icons exposes on your site and adds them as an entry
in your themes' living styleguide — so every available icon (and its ID) is visible on
a single page.

That single page is useful to several people at once:

- **Developers** get one place to browse, troubleshoot, and test the icon libraries.
- **Automated visual-regression tests** can watch it — the icons are output using the
  exact same render arrays as the real ex_icons module, so it catches genuine
  regressions and changes.
- **Content editors, product owners, and site builders** get self-documentation of the
  available options, handy for training, deliverables, and client QA.
- **Designers** can use it for design reviews and to communicate clearly with
  front-end developers.

The origin of the icons can be an SVG spritesheet or any other implementation that
ex_icons supports — see the External-use icons module for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it alongside ex_icons and Styleguide.

There is **nothing to configure** — this is a bridge that works as soon as it is
enabled. See "How to use it" below.

## Where it lives in the admin menu

EX Icons Styleguide adds no settings page of its own. It contributes to the existing
Styleguide pages, which live under **Appearance → Styleguide**. Each theme's styleguide
is at `/admin/appearance/styleguide/MY_THEME_NAME`.

## How to use it

1. Make sure you have some icons set up in the **External-use icons** (`ex_icons`)
   module.
2. Enable this module (Styleguide is enabled as a dependency).
3. Visit your theme's styleguide at
   **`/admin/appearance/styleguide/MY_THEME_NAME`** (replace `MY_THEME_NAME` with your
   theme's machine name). The available ex_icons icons appear there, each shown with its
   ID, so you can copy the ID you need for your templates.
