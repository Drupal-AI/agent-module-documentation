# jQuery Deprecated functions — agent index

Front-end shim that re-adds jQuery utility APIs removed in jQuery 4 (Drupal 11) so legacy JS keeps
working. **No config, no routes, no permissions, no PHP API, no Drush.** Enable it and it applies
site-wide.

- **What JS APIs it restores + how the library is attached** → [api/restored-functions.md](api/restored-functions.md)

Key facts:
- One asset library: `jquery_deprecated_functions/global-scripts` (depends on `core/jquery`),
  loaded in the page **header**, JS weight **-20**.
- Attached to every page two ways: the `libraries:` key in `jquery_deprecated_functions.info.yml`
  **and** `hook_page_attachments()` (OOP hook class `JqueryDeprecatedFunctionsHooks`).
- The whole payload is `js/jquery.deprecated.functions.js`; there is nothing to configure.
