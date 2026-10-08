# jQuery Deprecated functions — restored JS APIs & attachment

Everything lives in one file, `js/jquery.deprecated.functions.js`, wrapped in
`(function ($) { … })(jQuery)`. It re-adds APIs removed in jQuery 4 onto `$` / `jQuery`.

## Attachment (no config)

- Library id: **`jquery_deprecated_functions/global-scripts`** — defined in
  `jquery_deprecated_functions.libraries.yml`: `header: true`, JS weight `-20`, `preprocess: false`,
  `dependencies: [core/jquery]`.
- Loaded on **every page** two independent ways:
  1. `libraries:` list in `jquery_deprecated_functions.info.yml` (global asset attachment).
  2. `hook_page_attachments()` — implemented as `\Drupal\jquery_deprecated_functions\Hook\JqueryDeprecatedFunctionsHooks::jqueryDeprecatedFunctionsPageAttachments()` (registered via `#[Hook('page_attachments')]`; the `.module` keeps a `#[LegacyHook]` wrapper).
- There is no way (or need) to configure which functions load — it is all-or-nothing per page.

## Functions restored

| API | Replaces / behaves like |
|---|---|
| `$.isFunction(obj)`, `$.fn.isFunction(fn)` | `typeof x === 'function'` |
| `$.type(obj)` | old `jQuery.type` (uses an internal `class2type` map) |
| `$.trim(text)` | `String.prototype.trim` (also strips BOM/NBSP) |
| `$.isArray(obj)` | `Array.isArray` |
| `$.camelCase(string)`, `$.fcamelCase(all, letter)` | hyphen → camelCase conversion |
| `$.isWindow(obj)` | window-object check |
| `$.nodeName(elem, name)` | case-insensitive nodeName compare |
| `$.isNumeric(obj)` | numeric check |
| `jQuery.now()` | `Date.now()` |
| `jQuery.parseJSON(data)` | `JSON.parse` (with legacy validation) |
| `$.unique(...)`, `$.fn.unique()` | aliases of `uniqueSort` (only set if missing) |

## Objects / properties restored

- `jQuery.fx.interval = 13`
- `jQuery.cssNumber` — map of unitless CSS properties (so `.css()` does not append `px`).
- `jQuery.cssProps` — `{ float: 'styleFloat' }` float normalization.

## Using it

Just enable the module (`drush en jquery_deprecated_functions`). To confirm on a running site, inspect
the library registry rather than the file:
`\Drupal::service('library.discovery')->getLibraryByName('jquery_deprecated_functions','global-scripts')`.
