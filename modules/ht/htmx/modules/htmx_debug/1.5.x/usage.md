<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTMX Debugging is a developer-only submodule of htmx that swaps the minified HTMX library for a readable, unminified build and turns on the HTMX `debug` extension so every HTMX event is logged to the browser console.

---

The submodule is pure glue with no configuration, no permissions, and no services. `htmx_debug_library_info_alter()` removes core's minified `assets/vendor/htmx/htmx.min.js` from the `core/htmx` library and substitutes the unminified `htmx.js` (marked `minified: false`), so you can read and step through the actual library source. `htmx_debug_page_attachments_alter()` attaches the `htmx_debug/debug` library (which loads `js/htmx/debug.js`, the HTMX debug extension), and `htmx_debug_preprocess_html()` adds `data-hx-ext="debug"` to the `<html>` element so the extension is active page-wide, logging every htmx event to the console. Both skip responses to an actual HTMX request (`HX-Request` header present) so partial swaps aren't cluttered. Enable it only in development (`drush en htmx_debug`) and uninstall it in production — it depends on the htmx module. Note the submodule's own `htmx_debug/debug` library is the debug extension it attaches; htmx core's older debug library is deprecated in favour of this flow.

---

- Read and step through the unminified HTMX library while developing.
- Log every HTMX event (requests, swaps, triggers, errors) to the browser console.
- Debug why an `hx-get`/`hx-swap` isn't behaving as expected.
- Inspect the sequence of htmx lifecycle events on a page.
- Verify which elements are issuing HTMX requests and when.
- Diagnose out-of-band swap or targeting problems.
- Confirm an `hx-trigger` (including polling/timing) is firing.
- Trace HTMX behavior on a specific admin or content page during development.
- Temporarily enable rich HTMX logging on a staging environment.
- Turn off minification to set breakpoints in htmx.js from browser devtools.
- Validate custom event names used by the HTMX Loader block.
- Check that response headers (HX-Trigger, HX-Retarget) take effect client-side.
- Teach/learn how HTMX processes attributes by watching the console.
- Reproduce and report an HTMX bug with full event logs.
- Enable the `debug` htmx extension site-wide without editing templates.
- Quickly toggle debug logging by enabling/disabling one module.
