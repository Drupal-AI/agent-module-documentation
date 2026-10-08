jQuery Deprecated Functions re-implements jQuery helper functions, objects and constants that jQuery 4 removed (such as `$.trim`, `$.isFunction`, `$.camelCase`, `$.parseJSON`), so older contrib/library code keeps working on Drupal 11.

---

Drupal 11 ships jQuery 4 (`4.0.0-beta`), which dropped many utility methods that older jQuery plugins and modules still call, causing JavaScript errors. This module is a pure front-end shim: it defines a single asset library, `jquery_deprecated_functions/global-scripts`, whose one JS file re-adds the removed APIs onto the global `jQuery`/`$`. The library is attached to **every page** — both by being listed under `libraries:` in the module's `.info.yml` and by `hook_page_attachments()` (implemented as an OOP hook class, `JqueryDeprecatedFunctionsHooks`) — and it loads in the page `header` with a low weight (`-20`) so the shims exist before other scripts run. It depends on `core/jquery`. There is no configuration, no admin UI, no routes, no permissions, and no PHP API to call; you install it and it works. It restores functions like `$.isFunction`/`$.fn.isFunction`, `$.type`, `$.trim`, `$.isArray`, `$.camelCase`/`$.fcamelCase`, `$.isWindow`, `$.nodeName`, `$.isNumeric`, `jQuery.now`, `jQuery.parseJSON`, and `$.unique`/`$.fn.unique` (aliased to `uniqueSort`), plus objects/props `jQuery.fx.interval`, `jQuery.cssNumber` and `jQuery.cssProps`.

---

- Keep a contrib module that calls `$.trim()` from breaking after upgrading a site to Drupal 11.
- Restore `jQuery.isFunction()` for an old slider/gallery plugin that still uses it.
- Provide `$.parseJSON()` to legacy AJAX code that has not migrated to `JSON.parse`.
- Re-add `$.camelCase()` used by older UI widgets.
- Supply `$.isArray()` to code written before `Array.isArray` was adopted.
- Fix jQuery 4 JavaScript console errors coming from third-party libraries on the site.
- Bridge a site while you wait for upstream modules to fix their jQuery 4 incompatibilities.
- Keep `jQuery.now()` available for timing code in a legacy theme.
- Provide `$.isNumeric()` to form-validation scripts that depend on it.
- Restore `$.type()` type-detection used by older plugins.
- Re-enable `$.fn.unique()` / `$.unique()` as aliases of `uniqueSort` for legacy DOM code.
- Keep `$.nodeName()` working for scripts that inspect element node names.
- Provide `$.isWindow()` for plugins checking whether an object is the window.
- Re-expose the `jQuery.cssNumber` map so `.css()` handles unitless values like older code expects.
- Restore `jQuery.cssProps` float normalization for legacy CSS-manipulation code.
- Unblock a Drupal 11 upgrade where a critical JS widget relies on removed jQuery utilities.
- Load the shims early (header, weight -20) so they are defined before dependent scripts execute.
- Use it site-wide with zero configuration — enable the module and every page gets the polyfills.
- Avoid patching many individual contrib modules just to replace a couple of removed jQuery calls.
- Give a JavaScript library that expects jQuery 3 behavior a compatible environment on jQuery 4.
- Temporarily support a slick/simple_sitemap-style plugin whose jQuery 4 fix is not yet released.
- Test whether a JS breakage is caused by a removed jQuery function by toggling this module on/off.
