# Global settings (configure)

Route `printjs.settings` → `/admin/config/printjs/settings`, form
`Drupal\printjs\Form\PrintjsSettingsForm` (form id `printjs_admin_settings`), requires
`administer site configuration`. Also reachable from the module's `configure` link (info.yml
`configure: printjs.settings`). Writes the config object **`printjs.settings`**.

These are **site-wide defaults**. A Block instance ([plugins/block.md](../plugins/block.md)) and a
Views-area instance ([views/area.md](../views/area.md)) each store their own copy of the same keys
and override them per instance — the Views area even seeds its defaults from this object in
`PrintjsViewsBtn::defineOptions()`.

## Config keys written by the form (`PrintjsSettingsForm.php`)

| Key | Type | Meaning |
|-----|------|---------|
| `printjs_id` | textfield | Selector of the content to print. Default target is `#print`; you may give an id (`#foo`), a class (`.foo`), or plain text. Empty = fall back to `#print`, else `main`/`body`. |
| `btn_selector_print` | textfield | Extra CSS selector(s) that also trigger printing, comma-separated (e.g. `#printJS-form, #printjs`). Appended to the default `.btn-print` in the wrapper JS. |
| `print_parent_selector` | checkbox | Print the **parent** of the matched element (wrapped/ided as `#wrapper-print`) rather than the element itself. |
| `local` | checkbox | Load Print.js from `/libraries/Print.js/` (library `printjs/printjs.local`) instead of the CDN (`printjs/printjs`). Download the library yourself; see [api/service.md](../api/service.md). |

Note: the form does **not** expose `auto_print` or `printText` (those exist only on the Block and
Views-area instances). The `printjs.settings` object has **no config schema** (the only schema
shipped is `block.settings.printjs_block`), so these keys are stored untyped.

## How the values reach the button

`Printjs::getBtnPrintjs()` reads `printjs.settings` when no per-instance config is passed. It maps
`printjs_id` → the button's `data-printable` (default `print`) and `auto_print` →
`data-autoprint`, and echoes the whole config object to `drupalSettings.printjs`, which the wrapper
JS consumes to apply `btn_selector_print` and `print_parent_selector`.
