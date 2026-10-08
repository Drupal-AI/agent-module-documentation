# jQuery Dollar — manual setup guide

**jQuery Dollar** (`jquery_dollar`) restores the global `$` alias for jQuery. By
default Drupal calls `jQuery.noConflict()`, which frees up `$` so it can't be
assumed to mean jQuery in the global namespace. That's a sensible convention, but
it also means most jQuery snippets you find in documentation or on the web won't
run in Drupal as‑is — you have to call `jQuery` explicitly, or wrap your code in
a closure that passes `$` in. This module undoes that, so plain `$(...)` works
globally again.

How it works is deliberately tiny: the module injects a one‑line script that
re‑assigns the global `$` to point at jQuery, loaded immediately after core's
`drupal.js` (where `noConflict()` is called). Because it runs right after that
point, any other script on the site — even ones added later — can use `$`.

This is a convenience shim, and it goes against Drupal's now well‑established
JavaScript conventions. It has **no settings** — enabling it is the whole setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form.
Enabling it is all there is to do.

## Should you use it?

It's a good fit only if:

- You don't use any other JavaScript library that also claims the global `$`
  (Prototype, MooTools, and a few others do). Defining `$` globally is exactly
  what no‑conflict mode prevents, so any other library grabbing `$` will collide
  silently, in asset‑load order.
- You don't need different versions of jQuery per page or across the site.

For your own new code, the recommended pattern is still to wrap it in a closure —
`(function ($) { … })(jQuery)` — rather than relying on the global. jQuery Dollar
is best treated as a targeted compatibility aid for a specific third‑party
script, not a site‑wide habit.
