<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Page Load Progress

Form `SettingsForm` at route `page_load_progress.admin_settings` →
`/admin/config/user-interface/page-load-progress` (perm `administer page load progress`). Config
object `page_load_progress.settings`.

## Settings keys (defaults from `config/install/page_load_progress.settings.yml`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `page_load_progress_time` | int (ms) | `10` | Delay before the lock overlay appears. Form options: 10 (immediate), 1000, 3000, 5000. |
| `page_load_progress_elements` | string | `.page-load-progress-submit` | Comma-separated CSS selectors; submitting a form containing a match triggers the lock. Not exposed in the settings form UI. |
| `page_load_progress_request_path` | text | `''` | Newline-separated path patterns (wildcards `*`, `<front>`). Empty = all pages. |
| `page_load_progress_request_path_negate_condition` | bool | `true` | `0` = show only on listed paths; `1`/true = hide on listed paths (show everywhere else). |
| `page_load_progress_internal_links` | bool | `false` | Also lock on internal-link clicks (skips external/`use-ajax`/toolbar/modal/new-tab/target links). |
| `page_load_progress_esc_key` | bool | `true` | Allow ESC to remove the overlay. |

## Visibility logic

`evaluate_visibility_conditions()` lowercases the path list and matches the current path AND its alias
via `path.matcher`; the result is inverted when the negate condition is set. Assets also require the
`use page load progress` permission, and any path containing `admin/structure/views/` is always
excluded (so the Views UI is unaffected).

## Runtime

`hook_page_attachments` attaches library `page_load_progress/page_load_progress` and
`drupalSettings.page_load_progress` = `{delay, elements, internal_links, esc_key}`. The behavior
(`js/page_load_progress.js`) binds form-submit / link-click handlers and appends the
`.page-load-progress-lock-screen` overlay after `delay` ms.

## Set with Drush

```bash
drush cset page_load_progress.settings page_load_progress_time 3000 -y
drush cset page_load_progress.settings page_load_progress_internal_links 1 -y
```
