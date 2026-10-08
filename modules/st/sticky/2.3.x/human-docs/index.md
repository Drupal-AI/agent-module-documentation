# Sticky — manual setup guide

**Sticky** (`sticky`) lets you make any element on your site stay visible as the
page scrolls — a header, a footer, the main menu, a sidebar block, a promotional
banner — without writing any JavaScript. You point it at an element with a CSS
selector, and it "pins" that element so it follows the viewport.

Under the hood it's a thin Drupal wrapper around the third-party **garand/sticky**
jQuery plugin (stickyjs.com). The module doesn't reinvent the behavior; it gives
you a single admin form where you set the target selector and the plugin's
options, then attaches the library and passes your settings to it on every page.

Two things are worth knowing before you start. First, this is a **global,
single-selector** configuration — you set one selector site-wide, not per page or
per block. Second, the actual sticking is done by the JavaScript library, which
is **not on Packagist**, so its Composer install needs a small addition to your
project's `composer.json` (or you place the library manually). Both are covered in
[Installation](installation/index.md). The element you target must, of course,
exist in the rendered markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, get
   the Sticky JS library into `/libraries`, and enable the module.
2. [Configuration](configuration/index.md) — set the DOM selector and tune the
   spacing, classes, width, and z-index options.

## Where it lives in the admin menu

After enabling the module and clearing the cache, its settings form is at
**Configuration → System → Sticky** (`/admin/config/system/sticky`), gated by the
**administer sticky** permission. There is no per-page or per-block UI — the one
selector you configure here applies everywhere the targeted element appears.

## How to use it

Enable the module, install the JS library, then open the settings form and enter
the **DOM selector** of the element you want to pin (the default is `.menu--main`,
the main menu). Adjust the optional settings (spacing, stuck-state class, width
behavior, z-index) if needed, save, and the targeted element will stay visible as
visitors scroll. Because the settings are stored as configuration
(`sticky.settings`), you can export them and deploy the same behavior across
environments — or override the selector per environment.
