<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attaching fonts + the CSS template

## Dynamic asset libraries

The module has no static `*.libraries.yml`. `hook_library_info_build()`
(`google_webfonts_helper.module`) builds **one library per `google_webfont` entity**, keyed
by the entity id, so you attach a font with:

```
google_webfonts_helper/<entity_id>
```

- In a render array: `$build['#attached']['library'][] = 'google_webfonts_helper/body_font';`
- In a `*.libraries.yml` dependency, a `{{ attach_library('google_webfonts_helper/body_font') }}`
  in Twig, or copy-paste the exact id shown in the "Library" column of the admin list.

Each generated library adds the font's CSS file (`<fonts_path>/<id>/<id>.css`) under the CSS
bucket chosen in the entity's `css_weight` field (`base`/`layout`/`component`/`state`/`theme`).

**Rebuild note:** `hook_library_info_build()` iterates all fonts and calls
`$font->validateFiles(TRUE)` — i.e. `FontManager::prepare($id, force: TRUE)` — so **every time
library info is (re)built (e.g. a cache rebuild / `drush cr`) it re-downloads the fonts and
regenerates the CSS** for all entities, calling the external service each time. Expect a
network round-trip to `gwfh.mranftl.com` on cache clears; if the service is unreachable the
existing files are removed first (force delete) and may not be replaced.

## Theme hook / template

`hook_theme()` registers `google_webfonts_helper_style` →
`templates/google-webfonts-helper-style.html.twig`, used by `StyleGenerator` to render the
CSS that is written to disk (not rendered per-request).

Template variables:

| Variable | Default | Notes |
|---|---|---|
| `mode` | `legacy` | `legacy` emits eot/svg/ttf + woff/woff2 `src` rules; `modern` emits only woff2/woff. Comes from the entity's `css_target`. |
| `font_display` | `swap` | Emitted as the `font-display` descriptor. |
| `font_variants` | `[]` | Per-variant array: `font_family`, `font_style`, `font_weight`, optional `local[]`, and file URLs keyed by extension (`eot`/`ttf`/`svg`/`woff`/`woff2`). |

`StyleGenerator::generate()` disables Twig debug while rendering so no HTML debug comments
leak into the `.css`. To override the emitted `@font-face` markup, override the
`google_webfonts_helper_style` template in your theme, then re-save the font (or rebuild
libraries) to regenerate the file.
