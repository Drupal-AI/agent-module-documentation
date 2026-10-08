<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure preload_font

Settings form: `/admin/config/user-interface/preload-font` (route `preload_font.config`, form
`Drupal\preload_font\Form\PreloadFontSettingsForm`, permission **`administer site configuration`**).
Values persist in config object **`preload_font.settings`**. No schema ships (config is untyped).
A menu link (`preload_font.links.menu.yml`) places the form under
*Configuration → User interface* (`system.admin_config_ui`).

## Settings keys

| Key | Type | Meaning |
|---|---|---|
| `fontPaths` | string (newline-joined) | One font URL/path per line. The only setting. |

Each line must be one of:

- a **root-relative path** starting with `/` (e.g. `/themes/custom/mytheme/fonts/inter.woff2`), or
- an **absolute URL** starting with `http` (e.g. `https://cdn.example.com/inter.woff2`), or
- a **Google Fonts stylesheet URL** containing `fonts.googleapis.com` (must include `display=swap`).

## Validation (`validateForm`)

Lines are deduplicated (`array_unique(array_filter(...))`) and each is `trim()`ed, then rejected if:

- not a valid URL per `UrlHelper::isValid()` **and** not starting with `/` or `http`, or
- it ends with a trailing `/`, or
- it contains `fonts.googleapis.com` but not `display=swap` (guards against FOIT).

`submitForm` re-deduplicates and stores the lines re-joined with `PHP_EOL`.

## Emission — `preload_font_page_attachments_alter()` → `_preload_fonts()`

Runs on every page. Reads `fontPaths`, `explode(PHP_EOL, …)`, and per line:

- **`fonts.googleapis.com`** → two `html_head_link` entries:
  - `{rel: preconnect, href: //fonts.gstatic.com/, crossorigin: TRUE}`
  - `{rel: preload, as: style, href: <line>, crossorigin: TRUE, onload: "this.onload=null;this.rel='stylesheet'"}`
- **starts with `/` or `http`** → one entry `{rel: preload, href: <line>, as: font, crossorigin: TRUE}`,
  plus `type: font/<ext>` when `pathinfo($line, PATHINFO_EXTENSION)` is non-empty.
- anything else → skipped.

Entries land in `$attachments['#attached']['html_head_link'][] = [$link, FALSE]` and are rendered as
`<link>` tags by `HtmlResponseAttachmentsProcessor` via the `html_tag` render element, which escapes
attribute values.

## Notes for agents

- Set programmatically: `drush cset preload_font.settings fontPaths "/path/a.woff2\n/path/b.woff2"`
  or `\Drupal::configFactory()->getEditable('preload_font.settings')->set('fontPaths', $str)->save()`.
  Re-run validation semantics yourself when writing directly — the alter hook does not re-validate.
- The `onload` swap string is a fixed literal; only `href` comes from admin config.
- Form declares `getCacheTags(): ['config:preload_font.settings']`; the hook does not add cache
  metadata of its own, so a `fontPaths` change takes effect on the next page-cache rebuild.
- No `as="font"`/`type` is emitted for the Google Fonts branch (it preloads the stylesheet, not the
  font file — the browser still discovers the actual font files from that CSS).
