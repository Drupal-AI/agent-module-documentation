# Import Maps — manual setup guide

**Import Maps** (`importmaps`) provides an **API for modules to declare JavaScript
import maps** in Drupal. An import map lets you ship bundled front‑end code while
leaving third‑party dependencies as "naked" imports — for example
`import React from 'react';` — that the browser can resolve on its own. A page can
only carry one `<script type="importmap">`, and this module is what assembles it:
it adds that single element to the page and lets any module declare how its module
specifiers should resolve to URLs.

You use it as a **developer API**, not through an admin form. When your module needs
to contribute import‑map entries, you add a `yourmodule.importmaps.yml` file to your
module's root that lists each specifier and the path it resolves to. Your bundled
code can then import those specifiers by name, and the browser resolves them through
the generated map. The React module for Drupal uses this functionality.

A security note worth repeating: import maps define exactly what JavaScript the
browser loads for a given specifier, so make sure every mapped source is trusted.
The module has no content or access role of its own.

> **Heads‑up on overlap and status.** There is a similar module, **Import Map**
> (`importmap`), which adds some features this one does not (scoped imports, cache
> invalidation when JS files change, optional preload tags). This module is marked
> *No further development*, and it is hoped Drupal core will eventually provide this
> capability — at which point the core API will likely differ. Weigh that before
> adopting it on a new project.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Import maps are declared by
modules through a `*.importmaps.yml` file, as described in "How to use it" below.

## Where it lives in the admin menu

Import Maps adds no admin page. Once enabled, it emits the single
`<script type="importmap">` element into the page, built from the `*.importmaps.yml`
declarations that installed modules provide.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In the module that needs to contribute entries, add a `*.importmaps.yml` file at
   the module root:

   ```yaml
   someRelativeEsModule:
     path: relative/path/to/your/file.js
   someAbsoluteEsModule:
     path: /some/path/from/the/drupal/root/to/your/file.js
   ```
3. Your bundled code can then import those specifiers by name:

   ```js
   import Something from "someRelativeEsModule";
   import AnotherThing from "someAbsoluteEsModule";
   ```

If you bundle your front end with a tool like Vite/Rollup or Webpack, mark the
mapped dependencies as externals so they stay as bare imports in your output.
