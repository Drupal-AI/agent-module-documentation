<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preload Font (preload_font) — agent index

Emits `<link rel="preload">` resource hints for web fonts in the page head. Configure at
`/admin/config/user-interface/preload-font` behind `administer site configuration`.
Version **3.0.1**. Core `^10 || ^11`. No dependencies, permissions, services, plugins, or Drush.

## Mechanism (the whole module)

- **Config form** `Drupal\preload_font\Form\PreloadFontSettingsForm` (`ConfigFormBase`, route
  `preload_font.config`): a single `fontPaths` textarea, one URL per line, saved as a newline-joined
  string in config object **`preload_font.settings`** (key `fontPaths`). No config schema ships.
- **`preload_font_page_attachments_alter()`** (`preload_font.module`) reads `fontPaths`, splits on
  `PHP_EOL`, and calls `_preload_fonts()` per line. Output goes to
  `$attachments['#attached']['html_head_link']` (rendered as `<link>` via Drupal's `html_tag`
  element, which HTML-escapes attributes).

## Three branches in `_preload_fonts()`

1. **Contains `fonts.googleapis.com`** → a `<link rel="preconnect" href="//fonts.gstatic.com/" crossorigin>`
   plus `<link rel="preload" as="style" href="…" crossorigin onload="this.onload=null;this.rel='stylesheet'">`
   (load-then-swap CSS trick). The `onload` string is hardcoded, not user input.
2. **Starts with `/` or `http`** → `<link rel="preload" as="font" href="…" crossorigin>`; if
   `pathinfo()` finds an extension, adds `type="font/{ext}"` (e.g. `font/woff2`).
3. **Otherwise** → ignored.

Every hint carries **`crossorigin`** unconditionally (required for CORS-mode font fetches).

## Validation (`validateForm`)

Deduplicates lines; rejects a path that is not a valid URL, does not start with `/` or `http`, or
ends with `/`; rejects a `fonts.googleapis.com` URL missing `display=swap`.

## Why fonts need this

Browsers discover fonts late: parse HTML → request CSS → parse CSS → find `@font-face` → find it
applies → *then* request the font. A preload hint moves the request to the top of the document,
cutting FOUT and font-driven layout shift. Value over a theme change: hints live in exportable
configuration, not a template.

See `agent/configure/settings.md` for the settings/emission detail. See `../usage.md` for use cases.
