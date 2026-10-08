<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap UI — settings, config keys, and loading logic

## Install / enable

- `drush en bootstrap_ui -y`. No composer requirements beyond core. `hook_install()`
  (`bootstrap_ui.install`) adds a status message linking to the settings page and, if no local
  Bootstrap library is found, a warning to download it into `/libraries/bootstrap`.
- The external Bootstrap library is **not** shipped. Provide it one of three ways:
  - **CDN** — nothing to install; assets come from `//cdn.jsdelivr.net/npm/bootstrap@<version>/`
    (or `//cdnjs.cloudflare.com/.../twitter-bootstrap/<version>` for v2).
  - **Local (compiled `dist` download)** — files at `/libraries/bootstrap/css/bootstrap.min.css`,
    `/libraries/bootstrap/js/bootstrap.bundle.min.js`. `check_installed()` returns `'dist'`.
  - **Local (source download)** — files under `/libraries/bootstrap/dist/...`.
    `check_installed()` returns `'code'`.
- `bootstrap_ui_find_library()` searches via core `LibrariesDirectoryFileFinder`
  (`sites/<site>/libraries`, root `libraries`, profile `libraries`).

## Route / permission

- Route `bootstrap.settings` → `/admin/config/user-interface/bootstrap`, requires permission
  **`administer bootstrap ui`** (`bootstrap_ui.routing.yml`, `bootstrap_ui.permissions.yml`).
- Form class `\Drupal\bootstrap_ui\Form\BootstrapSettings` extends `ConfigFormBase`; form id
  `bootstrap_admin_settings`; editable config `bootstrap_ui.settings`. Injects `theme_handler` to
  list installed themes. Two AJAX callbacks rebuild version/file options: `bootstrapAjaxCallback`
  (library switch) and `bootstrapFilesAjaxCallback` (version/release change). These callbacks
  **write config immediately** as you change the selects (not only on submit).

## Config object `bootstrap_ui.settings`

Schema: `config/schema/bootstrap_ui.schema.yml`. Install defaults: `config/install/`. Keys:

- `load` (bool, default `true`) — master switch; if false the module attaches nothing.
- `rtl` (bool, default `false`) — serve the RTL build / patch on RTL pages.
- `hide` (bool, default `false`) — suppress the "library missing" status-report warning (for CDN-only).
- `library` (string, default `'bootstrap'`) — which UI kit; other modules add options via the
  `bootstrap_ui_library_name` hook (e.g. `'mdbootstrap'`). When not `'bootstrap'`,
  `page_attachments` attaches nothing (the other module loads it).
- `version` (string, default `''`) — Bootstrap version. For **local**, auto-detected by
  `detect_version()` (regex over the library CSS header) and re-saved on the fly; for **CDN** it is
  the admin-chosen release. `BootstrapConstants::LATEST_VERSION` (`5.3.7`) is the fallback.
- `method` (string, default `local`) — `local` or `cdn`. Forced to `cdn` and locked in the form when
  no local library is found.
- `build.variant` (int, default `1`/true) — `1` = minified (deployment), `0` = unminified (development).
- `file_types.js` (string, default `'bundle'`) — `none`, `bootstrap` (standalone), or `bundle`
  (includes Popper; only offered for v4+).
- `file_types.css` (bool, default `true`) — attach full Bootstrap CSS. When false, individual
  particle files below apply.
- `file_types.reboot` / `.grid` (bool) — v4/v5 partial CSS files.
- `file_types.utilities` (bool) — v5 partial CSS.
- `file_types.theme` (bool) — v3 theme CSS. `file_types.responsive` (bool) — v2 responsive CSS.
  `file_types.fonts` (bool, in schema) — v3 Glyphicons.
- `theme_groups.themes` (array) + `theme_groups.negate` (int, default `1`) — theme allow/deny list.
  `negate` `1` = only selected themes, `0` = all except selected. Empty list = all themes.
- `request_path.pages` (array) + `request_path.negate` (int, default `0`) — path list (one glob per
  line, `*` wildcard, `<front>` token). `negate` `0` = all pages **except** listed, `1` = only listed.
  Default list excludes `/admin*`, node add/edit, `/user/*/edit`, IMCE, print, `/system/ajax*`,
  `/batch*`.

Submit handler (`submitForm`) normalizes the version (local → detected; CDN → chosen version or the
`release` value when "other" is selected), and if **all** JS and CSS files end up disabled it resets
files to defaults and turns `load` off so an empty library can't be attached. It calls
`drupal_flush_all_caches()` after saving.

## Loading logic (runtime)

`bootstrap_ui_page_attachments(&$attachments)` (in `bootstrap_ui.module`):

1. Skips during installation; returns early if `load` is off or `library` isn't `bootstrap`.
2. Returns early unless `_bootstrap_ui_check_theme()` **and** `_bootstrap_ui_check_path()` both pass.
   - `_check_theme()` compares the active theme against `theme_groups` (with `negate` via XOR).
   - `_check_path()` honors `?bootstrap=no`, then matches the current path/alias against
     `request_path.pages` with core `path.matcher`, applying `negate`.
3. Chooses CDN vs. local (local downgrades to CDN if no library present), computes `.min` suffix from
   `build.variant`, and adds RTL only when page direction is `rtl` **and** `rtl` is on.
4. Attaches the matching `bootstrap_ui/bootstrap*` library name; for v<5 with RTL it adds the RTL
   patch library and, for v4, `bootstrap.patch` (JS).

`bootstrap_ui_library_info_alter(&$libraries, $extension)` rewrites the `bootstrap_ui` library
definitions from config: sets remote/download URLs, the jsDelivr CDN base for the chosen `version`,
selects full-CSS vs. particle files, sets JS bundle/standalone/none, adds `core/jquery`, and swaps in
the bundled RTL patch CSS (`css/patch/<major>.x/bootstrap.rtl[.min].css`) for Bootstrap < 5.

## `hook_requirements()` (status report)

Reports Bootstrap library presence and version: OK when found locally (shows `Distribution`/`Source
code` + detected version) or when on CDN with `hide` set; ERROR when `load` is on but no library and
the warning isn't hidden.

## Extending with other UI kits

Implement `hook_bootstrap_ui_library_name($library_name)` to add entries (e.g. `mdbootstrap`) to the
Library select. The form's `bootstrapAjaxCallback` already special-cases `mdbootstrap` (reads
`mdbootstrap_version_options()` / `mdbootstrap_detect_version()` and writes `mdbootstrap.settings`),
so that companion module supplies its own version data and the module's own `page_attachments` bows
out for non-`bootstrap` libraries.

## Ad-hoc control

- Append `?bootstrap=no` to any URL to disable Bootstrap for that request (`_check_path`).
