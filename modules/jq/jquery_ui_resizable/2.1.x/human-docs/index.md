# jQuery UI Resizable — manual setup guide

**jQuery UI Resizable** (`jquery_ui_resizable`) re-supplies one small piece of the
old jQuery UI toolkit — the **Resizable** interaction, which lets a user drag the
edges or a corner handle of an element to resize it — as a Drupal asset library.
Drupal core used to bundle the jQuery UI widgets, but they were deprecated and
removed, so any contrib module, theme, or custom code that still calls
`.resizable()` needs the library provided some other way. That is this module's
entire job.

Think of it as a compatibility shim, not a feature you turn on and see. It has no
configuration, no settings page, no permissions, no blocks, and no visible UI. It
simply registers the asset library `jquery_ui_resizable/resizable` (sourced
through the `jquery_ui` base module) so other code can depend on it. It is part of
the broader jQuery UI family of modules and depends on the **jQuery UI** base
module (`jquery_ui`, version 8.x‑1.7 or newer).

The module works the moment you enable it — there is nothing to configure. You get
value from it only when some other code attaches the library; on its own it
changes nothing about your site. If you are writing new code, prefer the native
CSS `resize` property or a modern JavaScript approach where you can, and reach for
this shim only when you must keep legacy jQuery UI resizable behavior working.

This guide is written for a **human** clicking through the admin UI (and for the
developer wiring up a library dependency). If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure — the module exists purely to provide a library.
Code that needs resizable behavior declares a dependency on it:

- In a module or theme's `*.libraries.yml`, add `jquery_ui_resizable/resizable`
  to the `dependencies` of your own library, **or** attach it directly from a
  render array via `#attached['library'][] = 'jquery_ui_resizable/resizable'`.
- Then call `.resizable()` on your element in your JavaScript, passing any of the
  standard jQuery UI resizable options (minimum/maximum size, aspect ratio,
  handles, and so on).

If you enabled this module only because another contrib module asked for it as a
dependency, you are already done — that module will attach the library itself.
