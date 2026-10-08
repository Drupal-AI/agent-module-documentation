# Debug Pause — manual setup guide

**Debug Pause** (`debugpause`) adds a one-click button to the admin toolbar that
pauses your page's JavaScript after a short, configurable delay — giving you a
breakpoint without having to hunt through script files or type `debugger` into the
browser console.

It solves a genuinely fiddly debugging problem. Sometimes you need to freeze a page
mid-interaction to inspect it — for example, a dropdown menu that only gets its
classes while the mouse is hovering, which the browser's Inspect tool disrupts the
moment you reach for it. Debug Pause wraps the JavaScript `debugger` statement in a
`setTimeout`: you click the toolbar button, do whatever interaction you want to
capture, and after the delay the browser's debugger kicks in and halts all
JavaScript execution so you can inspect the frozen DOM. **It only works with your
browser's DevTools open** — that's what makes a `debugger` statement actually
pause.

The button's visibility is controlled by a **Use debug pause** (`use debug pause`)
permission, so it's hidden from users who don't have it. The module requires the
**Admin Toolbar** module (that's where the button lives) and supports Drupal 9 and
10. It's a small developer utility with no server-side data handling.

> **Development only.** This module's whole purpose is to invoke the JS debugger,
> which is a development activity. Restrict the permission to a dedicated developer
> role and don't rely on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and Admin Toolbar, and grant the permission.
2. [Configuration](configuration/index.md) — set the pause delay and the button
   title display.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Debug Pause**
(`/admin/config/development/debugpause`, config `debugpause.settings`), gated by
the **Use debug pause** permission. The button itself appears in the **admin
toolbar** once the module is enabled and you hold that permission.
