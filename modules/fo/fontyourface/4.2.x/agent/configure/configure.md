# Configure: import, enable and apply fonts

## Admin routes (all gated by `administer font entities`)
| Route | Path | Purpose |
|---|---|---|
| `font.settings` | `/admin/appearance/font/settings` | Settings form + per-provider Import buttons (the `configure` route) |
| `entity.font.collection` | `/admin/appearance/font` | Font manager (a View); enable/disable fonts |
| `entity.font.canonical` | `/admin/appearance/font/{font}` | Preview a single font |
| `entity.font.activate` | `/admin/appearance/font/{font}/{js}/activate` | Enable link (`nojs`/`ajax`) |
| `entity.font.deactivate` | `/admin/appearance/font/{font}/{js}/deactivate` | Disable link |
| `entity.font_display.collection` | `/admin/appearance/font/font_display` | List Font display rules |
| `entity.font_display.add_form` | `/admin/appearance/font/font_display/add` | Add a Font display rule |

## Config object: `fontyourface.settings`
| Key | Default | Meaning |
|---|---|---|
| `enabled_fonts` | `[]` | Array of font **URLs** that are activated. Enabling a font appends its `url`; disabling removes it. |
| `load_all_enabled_fonts` | `1` | If true, every enabled font is attached on every page (optionally theme-scoped). |
| `load_on_themes` | `[]` | Machine names of themes to load fonts on; empty = all themes. Only used when `load_all_enabled_fonts` is on. |

Provider submodules add their own config (e.g. `google_fonts_api.settings:google_api_key`,
`typekit_api.settings:token`, `fontscom_api.settings:token`/`project`).

## Typical flow
1. Enable core + one or more provider submodules: `drush en fontyourface google_fonts_api -y`.
2. Import: visit `font.settings` and click **Import from <provider>** / **Import all fonts**
   (a batch that calls each provider's `hook_fontyourface_import`). Some providers (Google,
   Typekit) require an API key/token entered on this same form first.
3. Enable fonts on the manager at `/admin/appearance/font` (AJAX enable/disable links).
4. Apply either globally (leave `load_all_enabled_fonts` on) or precisely by adding a
   **Font display** rule.

## Font display (config entity `font_display`)
Binds one enabled font to CSS. Exported keys: `id`, `label`, `font_url`, `style`, `weight`,
`fallback`, `selectors`, `theme`. On save, `fontyourface_save_and_generate_font_display_css()`
writes `public://fontyourface/font_display/{id}.css` containing
`{selectors} { font-family: '<family>', <fallback>; font-style: …; font-weight: …; }`, and
`hook_library_info_build()` exposes it as library `fontyourface/font_display_{theme}`, attached
on pages using that theme.

## Drush-only setup (no dedicated commands; use core `config:set`)
```
drush config:set fontyourface.settings load_all_enabled_fonts 1 -y
drush config:set fontyourface.settings load_on_themes.0 olivero -y
```
Importing fonts is batch-driven and normally done from the settings form UI.
