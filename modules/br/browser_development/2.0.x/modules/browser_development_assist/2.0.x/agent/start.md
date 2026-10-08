<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Browser Development Assist (browser_development_assist) — agent index

Submodule of **browser_development** (see [../../../../agent/start.md](../../../../agent/start.md)). Package `Browser Development`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0-beta13. No routes, permissions, services, config, plugin types or non-core dependencies.

## Purpose

Re-attaches the CSS file that the parent module compiled to disk, so `browser_development` (the editor) can be uninstalled on production while the generated stylesheet keeps rendering — removing the editor's runtime surface for performance/hardening.

## Mechanism (from source)

- `browser_development_assist.module`:
  - `hook_library_info_build()` → defines library `browser-development-assist` with a single `css.theme` entry keyed by `FileSystemStructure::getCssFilePath()` (default file). No `.libraries.yml`; the library is built dynamically.
  - `hook_page_attachments($page)` → attaches `browser_development_assist/browser-development-assist` **only when** `\Drupal::theme()->getActiveTheme()->getName()` equals `system.theme:default` (i.e. the active theme is the site default).
  - `hook_css_alter(&$css, $assets)` → looks up the library's CSS path via `library.discovery` and sets `$css[$path]['group'] = 300` so the file loads late.
  - `hook_help()` for `help.page.browser_development_assist`.
- `src/Processing/FileSystemStructure.php` — a **static** variant of the parent's path helper. `getCssFilePath($file_name = 'default')` returns `/<site path>/files/browser-development/css/<css_name[$file_name]>` from a hardcoded `$globalFilePathArray` (`uri_path` `files/browser-development/css`, `css_name` `default.css`/`inline.css`/`admin.css`). This is the file the library points at.

## Notes

- The attached CSS file must already exist (compiled by the parent editor) for the library to serve anything meaningful.
- Only the `default` CSS file is wired into the library build; `inline`/`admin` are defined in the path map but not attached.
