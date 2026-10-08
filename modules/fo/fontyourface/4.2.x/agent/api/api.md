# Entity & helper API

## `font` content entity — `Drupal\fontyourface\Entity\Font`
Base table `fontyourface_font`, entity keys `id=fid`, `label=name`, plus custom keys
`pid`, `url`. Not a bundle entity. `render_cache = FALSE`. Base fields: `pid`, `url`
(unique, max 191), `name`, `css_family`, `css_style`, `css_weight`, `foundry`,
`foundry_url`, `license`, `license_url`, `designer`, `designer_url`, `metadata`
(string_long, serialized), `created`, `changed`, `status`. Configurable fields added by
config/install: `field_tags`, `field_classification`, `field_supported_languages` (taxonomy
term refs to vocabularies `font_foundry`/`font_designer`, `font_classification`,
`languages_supported`; there is also a `font_tags` vocabulary).

Notable methods (see `FontInterface`):
- `getProvider()` / `setProvider($provider)` — the `pid`.
- `getMetadata()` / `setMetadata($array)` — serialize/unserialize the metadata blob.
- `isActivated()` / `isDeactivated()` — checks membership of `url` in
  `fontyourface.settings:enabled_fonts`.
- `activate()` / `deactivate()` — add/remove `url` from `enabled_fonts` and save `status`.
- static `loadByUrl($url)` — load a font by its unique URL.
- static `loadActivatedFonts()` — all currently enabled fonts, keyed by URL.

## `font_display` config entity — `Drupal\fontyourface\Entity\FontDisplay`
`config_prefix = font_display`. Exported: `id, label, uuid, font_url, style, weight,
fallback, selectors, theme`. `getFont()`, `getSelectors()`, `getFallback()`, `loadByTheme($theme)`.

## Procedural helpers (in `fontyourface.module`)
| Function | Purpose |
|---|---|
| `fontyourface_save_font($font_data)` | Create/update a `font` from a stdClass (matches by `url`); resolves taxonomy terms for classification/language/foundry/designer; returns the saved `Font`. Primary entry point for provider imports. |
| `fontyourface_font_css($font, $font_style = NULL, $separator = ' ')` | Build the `font-family/font-style/font-weight` CSS for a font; first calls `hook_fontyourface_font_css` and uses that if any provider returns CSS. |
| `fontyourface_delete($provider)` | Delete every font whose `pid` == `$provider`, 50 at a time (use when disabling a provider). |
| `fontyourface_save_and_generate_font_display_css($style)` | Write `public://fontyourface/font_display/{id}.css` for a Font display rule. |
| `fontyourface_log($message, $arguments)` | Log to channel `@font-your-face` only if `fontyourface.settings:fontyourface_detailed_logging` is on. |

No services (`*.services.yml`), no plugin managers, no Drush commands. Views integration:
`FontYourFaceProviderFilter`, `FontYourFaceWeightFilter`, `FontYourFaceStyleFilter` Views
filter plugins power the font manager View (`views.view.fontyourface_font_manager`).
