<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Plugin View Builder (block_plugin_view_builder) — agent index

Renders a **block plugin** from code, without a placement. No dependencies, no UI.
Version **1.0.6**. Core requirement `^10 || ^11`.

**The distinction Drupal conflates:**
- a **block plugin** is code producing a render array;
- a **block placement** is a configuration entity saying that plugin appears in a region under
  conditions.

Most of the time both are wanted. Sometimes only the first: a controller needing the search form, a
custom page assembling several plugins, a mail template wanting a rendered component, a test.

**Doing it by hand is five steps, and two of them are the ones people skip** — fetch the block
manager, instantiate with configuration, **check access**, call `build()`, **attach the cache
metadata**. The output looks correct without those two, which is why a helper is worth having.

**Two things worth attaching:**
1. **Rendering a plugin bypasses the placement's visibility conditions** — the point, but those
   conditions are sometimes where a site expressed *"this block is only for administrators"*. A
   directly rendered plugin may appear where configuration said it should not.
2. **A plugin's cache metadata belongs to whatever renders it.** A plugin varying by user renders
   differently per user — code that **drops its cacheability** produces a fragment **cached for
   everyone**. The standard way this becomes a disclosure rather than a bug. This module attaches it
   for you: cache keys, contexts, tags (`block_view` + the plugin's own), max-age, and the access
   result's cacheable metadata.

**It handles access correctly:** `viewPlugin()` calls `$plugin->access(current_user, TRUE)` before
building; disallowed → nothing is built. It checks the **plugin's own** access, not any placed-block
**visibility conditions** (there is no block config entity) — supply the plugin id accordingly.

**Details:**
- [`agent/api/service.md`](api/service.md) — the `block_plugin.view_builder` service: `view()` /
  `viewPlugin()`, the returned render array (cache keys, lazy builder vs. eager title blocks, block
  alters), access handling, and how entity/scalar contexts are JSON round-tripped through the lazy
  builder.
