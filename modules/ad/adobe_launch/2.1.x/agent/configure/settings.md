# Configure Adobe Launch

Route `adobe_launch.config` → `/admin/config/services/adobe_launch/configure`
(permission `administer site configuration`, `no_cache: TRUE`). Config object `adobe_launch.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `adobe-launch-enable` | bool | `false` | Master switch. Nothing injects unless this is on. |
| `target-adobe-launch-environment` | string | `staging` | Which URL to inject: `dev` / `staging` / `prod`. |
| `adobe-launch-async` | bool | `true` | Add `async` to the script tag. |
| `init-js-array` | bool | `true` | Attach the `adobe_launch/adobe_launch` library that initializes `window.digitalData` / `window.DTM_DATA`. |
| `adobe-launch-prod-url` | string | `''` | Protocol-relative prod Launch script URL (e.g. `//assets.adobedtm.com/launch-xxxx.min.js`). |
| `adobe-launch-staging-url` | string | `''` | Staging URL. |
| `adobe-launch-dev-url` | string | `''` | Dev URL. |
| `adobe-launch-registrant` | string | `''` | Subscription registrant email (informational). |
| `paths` | string | `/admin`, `/admin/*`, `/node/*/edit` (CR/LF separated) | Path patterns, one per line, `*` wildcard. |
| `paths_negate` | string | `'1'` | `1` = exclude on these paths, `0` = include only on these paths. |

The settings form (`src/Form/AdobeLaunchConfigForm.php`) validates each of the three URL fields by prefixing
`https:` and running the core path validator (`getUrlIfValidWithoutAccessCheck`), requiring an **external**
URL and trimming a trailing slash.

## Injection logic (source map)

`adobe_launch.module`:
- `adobe_launch_preprocess_html()` — if enabled and `_adobe_launch_path_check()` passes, picks the URL for
  the target environment and appends a `script` render element to `html_head` (with `async` when set).
- `adobe_launch_preprocess_page()` — attaches the data-layer library when `init-js-array` is on.
- `_adobe_launch_path_check()` — matches the current path (alias and internal) against `paths`, applying the
  include/exclude semantics of `paths_negate`, then invokes
  `hook_adobe_launch_path_check_alter(&$result)` so other modules can override the decision.

## Alter hook

```php
/** Implements hook_adobe_launch_path_check_alter(). */
function MYMODULE_adobe_launch_path_check_alter(&$result) {
  // $result is bool/int: whether the snippet loads on this request.
}
```
