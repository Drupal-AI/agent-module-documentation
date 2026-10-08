# Configure GTranslate (widget + languages)

## What it is (and is not)

GTranslate provides **one block plugin** — id `gtranslate_block`, admin label "GTranslate",
category *Accessibility* — that outputs a Google Translate JavaScript widget. Translation is
**client-side machine translation** performed by Google in the browser. It is **not** Drupal
core Content Translation / Locale: there are no translated entities, no per-string interface
translation, and (in free mode) translated pages are **not** indexed by search engines. Use
it when you want cheap "translate this page into many languages" coverage, not editorial
multilingual content.

## Turn it on

1. Enable the module (depends on core `block`).
2. Place the block: **Admin → Structure → Block layout**, place **GTranslate** in a region
   (or add it via Layout Builder). The widget renders wherever the block is placed, unless a
   custom `wrapper_selector` targets a different element.
3. Configure the widget at **Admin → Configuration → Regional and language → GTranslate**
   (`/admin/config/regional/gtranslate`, route `gtranslate.settings`). Requires the
   `gtranslate settings` permission.

## Widget look (`widget_look`)

Twelve styles: `float`, `dropdown_with_flags` (nice dropdown with flags), `flags_dropdown`
(flags + dropdown), `flags`, `dropdown`, `flags_name` (flags with language name),
`flags_code` (flags with language code), `lang_names`, `lang_codes`, `globe`, `popup`,
`popup_search` (popup with search). Each look loads a matching JS file (e.g. `float.js`)
from the GTranslate CDN, or from the module's local `js/` folder when CDN is off.

## Settings keys (`gtranslate.settings` config object)

Defaults ship in `config/install/gtranslate.settings.yml`. There is **no config schema**
(`provides_config_schema` false). Relevant keys and their defaults:

| Key | Default | Meaning |
|---|---|---|
| `widget_look` | `float` | Which widget style to render (see list above) |
| `source_lang` | `en` | "Translate from" — the site's source language |
| `url_structure` | `none` | `none` = free on-the-fly JS translation (not indexed); `sub_directory` (`example.com/fr`) and `sub_domain` (`fr.example.com`) are **paid** and indexable |
| `languages` | `['en','es','de','it','fr']` | Which languages the switcher offers (enabled in the Languages table) |
| `language_weights` | `{}` | Drag-and-drop ordering of offered languages |
| `native_language_names` | `1` | Show language names in their native alphabet |
| `detect_browser_language` | `0` | Auto-switch to the visitor's browser language on first visit |
| `enable_cdn` | `1` | Load widget JS/flag images from GTranslate CDN (else locally from the module) |
| `flag_size` | `32` | Flag size in px (16/24/32/48) — flag-based looks only |
| `flag_style` | `2d` | `2d` (.svg) or `3d` (.png) flags |
| `globe_size` | `60` | Globe px (20/40/60) — `globe` look only |
| `color_scheme` | `light` | `light`/`dark` — `dropdown_with_flags` look only |
| `float_position` | `bottom-left` | Corner (or `inline`) for `float`/`dropdown_with_flags` |
| `float_switcher_open_direction` | `top` | Open direction for the `float` look |
| `position` | `inline` | Corner/inline for non-float looks |
| `switcher_open_direction` | `bottom` | Open direction for `dropdown_with_flags` |
| `add_new_line` | `1` | Line break between flags and dropdown (`flags_dropdown` look) |
| `select_language_label` | `Select Language` | Placeholder text in the dropdown looks |
| `wrapper_selector` | `.gtranslate_wrapper` | CSS selector of the element to render the switcher into |
| `alt_flags` | `''` | Alternative country flags (USA/Canada→English, Mexico/Argentina/Colombia→Spanish, Brazil→Portuguese, Quebec→French) |
| `custom_domains` | `0` | Enable custom per-language domains (paid; sub_domain structure) |
| `custom_domains_config` | `''` | Custom-domain mapping synced from the GTranslate dashboard |
| `custom_css` | `''` | Extra CSS injected with the widget |

The settings form shows/hides fields per `widget_look` via `#states`, so only the options
that apply to the chosen look are editable.

## Free vs paid

- **Free:** `url_structure: none`. Google translates the current page in-place via
  JavaScript. Fast to set up, but translated pages share the original URL and are **not
  crawlable/indexable** by search engines.
- **Paid (GTranslate subscription):** `sub_directory` or `sub_domain` URL structures give
  each language its own indexable URL for multilingual SEO, plus optional custom domains
  (configured in the GTranslate dashboard and synced into `custom_domains_config`).

## Languages

The offered language list (~103 available) is chosen in the form's **Languages** details
table: tick "Enabled" per language and drag rows to set weight/order. On save, enabled
languages are stored in `languages` and their order in `language_weights`; the `source_lang`
is always force-added to the enabled set.

## Permission

`gtranslate settings` (title "Configure GTranslate") gates the settings form. That is the
only permission the module defines.

## Caching / rendering

The block renders via the `gtranslate` theme hook (template `gtranslate.html.twig`, prints
`gtranslate_html` raw). Output is cached `PERMANENT` with cache tag
`config:gtranslate.settings` and contexts `url`, `url.query_args`, so editing the settings
form invalidates the widget automatically.
