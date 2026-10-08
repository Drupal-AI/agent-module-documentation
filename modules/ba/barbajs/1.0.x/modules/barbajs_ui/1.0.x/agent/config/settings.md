<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Barba JS UI — settings form, config & attachment rules

The whole submodule: one settings form, one config object, and the `hook_page_attachments` logic that
uses it. Cited from `barbajs_ui.module` and `src/Form/BarbaSettings.php`.

## Install / enable / access

- `drush en barbajs_ui` (pulls in `barbajs`). `barbajs_ui_install()` shows a status message linking to
  the settings form. Enabling it makes the base module's `barbajs_page_attachments` go dormant — this
  submodule owns attachment from then on.
- Route `barba.settings` → `/admin/config/user-interface/barba/settings`, gated by permission
  **`administer barba`** (`barbajs_ui.permissions.yml`), `_admin_route: TRUE`. Standard `ConfigFormBase`
  (form id `barba_settings_form`) — CSRF/token handling is core's.

## Config object `barbajs_ui.settings`

Schema `config/schema/barbajs_ui.schema.yml`; install defaults `config/install/barbajs_ui.settings.yml`.

| key | type | default | meaning |
|---|---|---|---|
| `load` | boolean | `true` | Global on/off for auto-attaching Barba. |
| `version` | string | `2.10.3` | Informational library version (not used by attach logic). |
| `method` | string | `local` | `local` or `cdn` delivery. |
| `build.variant` | integer | `1` | `0` = non-minified (dev), `1` = minified (deploy). |
| `file_types.core` | boolean | `true` | Attach Barba core (`barbajs/barba`). |
| `file_types.css` | boolean | `false` | Attach CSS plugin (`barbajs/barba_css`). |
| `file_types.prefetch` | boolean | `false` | Attach Prefetch plugin. |
| `file_types.router` | boolean | `false` | Attach Router plugin. |
| `theme_groups.negate` | integer | `1` | `1` = only selected themes, `0` = all except selected. |
| `theme_groups.themes` | sequence | `[]` | Machine names of themes. |
| `request_path.negate` | integer | `0` | `0` = all pages except listed, `1` = only listed pages. |
| `request_path.pages` | sequence | see below | Path patterns (`*` wildcard, `<front>` token). |

Default `request_path.pages` excludes admin/edit/system paths: `/admin*`, `/imagebrowser*`,
`/img_assist*`, `/imce*`, `/node/add*`, `/node/*/edit`, `/user/*/edit`, `/print/*`, `/printpdf/*`,
`/system/ajax`, `/system/ajax/*`, `/batch*` (with `negate = 0`, i.e. load everywhere *except* these).

## Form (`BarbaSettings::buildForm`)

Fields: `load` checkbox; `method` select (Local/CDN); `build.variant` radios; a `usability` vertical-tabs
group holding three details panes — **Files** (`file_types`: core checkbox + a plugins container hidden
via `#states` when core is unchecked, css/prefetch/router checkboxes, each tagged with a
`BarbaConstants::*_VERSION` data attribute; plus a `file_warning` shown when all four are unchecked),
**Themes** (`theme_groups.themes` multi-select built from `themeHandler->listInfo()` enabled themes +
`theme_negate` radios), **Pages** (`request_path.pages` textarea + `page_negate` radios). Attaches
`barbajs_ui/barba.settings`.

## Save (`BarbaSettings::submitForm`)

- Computes `$no_files` = all four file checkboxes empty. If so, `file_types` is **reset to defaults**
  (`core => TRUE`, plugins FALSE) and `load` is forced FALSE, with a warning message — the deliberate
  guard so the site never has loading on with nothing to attach.
- Otherwise saves each value; `request_path.pages` is stored via `_barbajs_ui_string_to_array()`
  (splits the textarea on newlines, trims, drops blanks). Calls `drupal_flush_all_caches()` after save.

## Attachment enforcement (`barbajs_ui_page_attachments`)

1. Skip during installation.
2. Bail if `!load`, or `!_barbajs_ui_check_theme()`, or `!_barbajs_ui_check_path()`.
3. `method` = configured value, but forced to `cdn` when `barbajs_check_installed()` (from the base
   module) is FALSE — i.e. Local silently falls back to CDN when no local build exists.
4. `variant` suffix = `.min` when `build.variant` is truthy, else ``.
5. For each enabled `file_types` entry, maps `core → barba`, others → `barba_<name>`, appends
   `.cdn<variant>` for CDN or `<variant>` for local, and attaches `barbajs/<lib>`.

### `_barbajs_ui_check_path()`

- Honours `?barba=no` (query `barba == 'no'` → not active).
- Empty `request_path.pages` → active everywhere.
- Otherwise lowercases the pages, resolves the current path and its alias
  (`path.current`, `path_alias.manager`), and matches with `path.matcher` against both alias and internal
  path. Result is negated per `request_path.negate` (`0` → active on all *except* matches).

### `_barbajs_ui_check_theme()`

- Empty `theme_groups.themes` → active on all themes.
- Otherwise compares the active theme (`\Drupal::theme()->getActiveTheme()->getName()`) against the list
  and applies `theme_groups.negate` via XOR (`return !($visibility xor $theme_match)`): `negate = 1`
  means active only on the selected themes; `negate = 0` means active on all except them.

## Helpers (`barbajs_ui.module`)

`_barbajs_ui_string_to_array` / `_barbajs_ui_array_to_string` convert between the textarea and the stored
sequence; `_barbajs_ui_array_flatten` / `_barbajs_ui_object_to_array` are small array utilities. All
inputs handled here are admin-supplied config used for path/theme matching only (not rendered as markup).
