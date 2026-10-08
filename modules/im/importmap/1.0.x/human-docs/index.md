# Import Map — manual setup guide

**Import Map** (`importmap`) manages the browser **import map** for ES modules on
your Drupal site — the `<script type="importmap">` block that maps bare JavaScript
module specifiers (like `import x from 'lodash'`) to real URLs. Modern front‑end
code often imports dependencies by bare name; browsers don't know where those names
point unless an import map tells them. This module generates that map for you, so
your library and front‑end code can use bare‑specifier imports on a Drupal site.

The nice part is that you don't configure it through an admin form. You annotate a
library's JavaScript in your module or theme's `*.libraries.yml` file with a
`data-importmap-name` attribute, and Import Map builds the corresponding import map
automatically. For example, giving `js/foo.js` the attribute
`data-importmap-name: 'foo'` produces a map entry so that `import { foo } from
"foo";` resolves — and you don't even have to attach the library, because the
browser downloads it on demand when the import runs. You can also mark a module for
preloading with `data-importmap-preload: true` so it's ready before the import
executes.

Note that JavaScript that uses `import` must carry the `type="module"` attribute.
And a small security point: anything you map can be imported and executed, so point
your entries at trusted, same‑origin or trusted‑CDN scripts. This is a
theming/JavaScript integration utility with no content or access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Import maps are declared in your
module/theme `*.libraries.yml` files via the `data-importmap-name` (and optional
`data-importmap-preload`) attributes, as described above and in "How to use it"
below.

## Where it lives in the admin menu

Import Map adds no admin page. Once enabled, it inspects your libraries for the
`data-importmap-name` attribute and emits the `<script type="importmap">` element
into the page automatically.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In a module or theme `*.libraries.yml` file, annotate the JS you want mapped:

   ```yaml
   foo:
     js:
       js/foo.js: { attributes: { data-importmap-name: 'foo' } }
   ```

   To have the browser preload the module, add `data-importmap-preload: true` to the
   same attributes.
3. In your front‑end code, import by the bare specifier and mark the script as a
   module:

   ```js
   import { foo } from "foo";
   ```

   Make sure the consuming `<script>` uses `type="module"`. You do not need to
   attach the mapped library yourself — the browser fetches it when the import runs.
