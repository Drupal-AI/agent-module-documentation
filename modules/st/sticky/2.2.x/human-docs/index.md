# Sticky — manual setup guide

**Sticky** (`sticky`) lets you make any element on your site stay visible while the
page scrolls — a header, a footer, the main menu, a sidebar block, a
call-to-action bar. You point it at a CSS/DOM selector on one settings form, and it
applies the third-party **Sticky JS** library (stickyjs.com) to that element so it
"sticks" in place as visitors scroll.

It's a thin, no-code-for-editors wrapper: one global settings form chooses the
target element and mirrors the JS plugin's options (top/bottom spacing, the class
added when the element is stuck, centering, width behavior, z-index). The
configuration is site-wide and single-selector — there's no per-page or per-block
UI — so the usual pattern is a developer setting the selector once for the theme.

One thing to know up front: Sticky doesn't bundle the JavaScript library. It
expects the **garand/sticky** library file to be present at
`/libraries/sticky/jquery.sticky.js`, which you download and place yourself. Until
that file exists and your selector matches a real element in the rendered page,
nothing will stick. The module has no other Drupal module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   download the required JavaScript library.
2. [Configuration](configuration/index.md) — the settings form field by field:
   selector, spacing, classes, width and z-index options.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Sticky**
(`/admin/config/system/sticky`), gated by the **Administer sticky** permission —
the only permission the module defines.

## How to use it

1. Install the module **and** the garand/sticky library (see
   [Installation](installation/index.md)).
2. Go to **Configuration → System → Sticky** and set the **DOM Selector** to the
   element you want pinned (e.g. `.menu--main`, `.header-wrapper`, `#footer`).
3. Adjust the other options if needed — top/bottom spacing, the "stuck" class,
   centering, z-index — then **Save**.
4. Reload a page with that element and scroll: the element should now stay in view.

If nothing happens, the two usual culprits are: the library file isn't installed at
`/libraries/sticky/jquery.sticky.js`, or the selector doesn't match an element in
the rendered markup.
