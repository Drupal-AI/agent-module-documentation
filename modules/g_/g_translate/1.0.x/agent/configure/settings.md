# Configure GTranslate (settings + block placement)

Two steps: set options on the settings form, then place the block. The switcher only appears once
the block is placed.

## Settings form
- Route: `g_translate.settings` → `/admin/config/regional/g-translate`
  (menu: Configuration › Regional and language). Form class
  `Drupal\g_translate\Form\GTranslateSettingsForm` (extends `ConfigFormBase`, form id
  `g_translate_admin`). `validateForm()` is empty.
- Permission required: `g_translate settings`.
- Editable config: `g_translate.settings`. Defaults ship in
  `config/install/g_translate.settings.yml`; **no config schema file is shipped**.

### General configuration keys
| Key | Widget | Values | Meaning |
|---|---|---|---|
| `gtranslate_look` | select | `flags_dropdown`, `flags`, `dropdown`, `dropdown_with_flags` | Switcher appearance. |
| `gtranslate_main_lang` | select | language code (e.g. `en`) | Source language of your content. |
| `gtranslate_flag_size` | radios | `16`, `24`, `32` (px) | Flag sprite size; selects `gtranslate-files/<size>*.png`. |
| `gtranslate_new_window` | checkbox | `0` / `1` | Open the translated page in a new window (redirect method only). |
| `gtranslate_pro` | checkbox | `0` / `1` | Sub-directory URL structure (`/ru/…`). Requires a paid GTranslate plan. |
| `gtranslate_enterprise` | checkbox | `0` / `1` | Sub-domain URL structure (`es.example.com`). Requires a paid GTranslate plan. |
| `gtranslate_method` | (derived) | `onfly` / `redirect` | Not on the form. Set to `redirect` when pro OR enterprise is on, else `onfly`. |

### Per-language visibility keys
One `gtranslate_<langcode>` key per supported language (~100 total; e.g. `gtranslate_fr`,
`gtranslate_es`, `gtranslate_zh-CN`). Radios with three values:
- `0` — do not show the language.
- `1` — show in the dropdown list.
- `2` — show as a flag (and, for `flags`/`flags_dropdown`, as a clickable flag).

The language list is a fixed map hard-coded in both the form and the block (`$languages`); the
map key is the language code used in the config key and in Google's `source|target` pairs.

## The three delivery methods
- **`onfly`** (default; pro and enterprise both off): the block emits an inline `<script>` that
  loads Google's client widget `https://translate.google.com/translate_a/element.js` plus a
  `doGTranslate()` helper; selecting a flag/option triggers Google's in-page translation. This is
  the only mode that needs no paid GTranslate service.
- **`redirect` + `gtranslate_pro`**: links/JS rewrite the URL path to `/<lang>/…`.
- **`redirect` + `gtranslate_enterprise`**: links/JS rewrite the host to `<lang>.<host>/…`.
  The Pro/Enterprise URL rewriting relies on GTranslate's paid hosting/proxy actually serving those
  translated URLs.

## Placing the block
Block plugin id `gtranslate_block` (`Plugin\Block\GTranslateBlock`), admin label **GTranslate**,
block category **Accessibility**. Place it via Block layout (`/admin/structure/block`) or a `block`
config entity in any region. The block is rendered uncacheable (`#cache['max-age'] = 0`) through the
`gtranslate` theme hook (template `templates/gtranslate.html.twig`, variable `gtranslate_html`). The
`dropdown_with_flags` look additionally attaches the `g_translate/jquery-slider` library for its
slide-down animation.

## Programmatic config example
```php
\Drupal::configFactory()->getEditable('g_translate.settings')
  ->set('gtranslate_look', 'dropdown')
  ->set('gtranslate_main_lang', 'en')
  ->set('gtranslate_flag_size', 16)
  ->set('gtranslate_fr', 2)   // French shown as a flag
  ->set('gtranslate_de', 1)   // German shown in the list
  ->save();
```
