@font-your-face (fontyourface) provides an administrative interface for browsing, importing and applying web fonts (via CSS `@font-face`) from a variety of providers such as Google Fonts, Adobe/Typekit, Fonts.com, Font Squirrel and locally hosted files.

---

The core module defines a `font` content entity (one row per imported font-variant, keyed by URL and a provider id `pid`) and a `font_display` config entity that binds an enabled font to CSS selectors + a theme so the right `@font-face` CSS is attached on render. It ships no fonts itself: each provider is a submodule that implements three hooks — `hook_fontyourface_api()` (announce the provider), `hook_fontyourface_import()` (batch-import fonts into `font` entities), and optionally `hook_fontyourface_font_css()` (emit custom loading CSS/markup). Fonts are imported from the settings form at `/admin/appearance/font/settings`, then individually enabled/disabled at `/admin/appearance/font` (which toggles their URL in `fontyourface.settings:enabled_fonts`). At render time `hook_page_attachments()` loads all enabled fonts (optionally scoped to selected themes) or just the fonts referenced by the active theme's font-display rules. It requires `taxonomy` (fonts are tagged by foundry, designer, classification and supported language) and `views` (the font manager admin listing is a View). Configuration lives in `fontyourface.settings`; a single permission, `administer font entities`, gates all admin routes.

---

- Browse and apply free web fonts from Google Fonts across a whole Drupal site
- Self-host font files with the Local Fonts submodule instead of calling a third-party CDN
- Import a commercial Typekit / Adobe Fonts kit and apply its fonts by kit id
- Serve Fonts.com (Monotype) subscription fonts via their API token/project
- Pull Font Squirrel's free-for-commercial-use font catalog into the site
- Import Adobe Edge Fonts without needing an account or API key
- Assign a specific web font to CSS selectors (e.g. `h1, h2`) for one theme via a Font display rule
- Set a fallback font stack per Font display so text still renders while the web font loads
- Enable "load all enabled fonts" to make every activated font available site-wide
- Restrict font loading to specific themes to avoid bloating admin or other themes
- Keep front-end and admin typography consistent by enabling the same fonts on both themes
- Preview a font on its canonical page (`/admin/appearance/font/{font}`) before enabling it
- Filter/sort the font manager View by provider, weight or style using the bundled Views filters
- Tag and organize fonts by foundry, designer, classification and supported language (taxonomy)
- Toggle a font on/off with AJAX enable/disable links without leaving the font listing
- Add or edit a font entity manually when a provider does not import exactly what you need
- Store per-font metadata (subset, variant path, kit id) used by providers to build load URLs
- Programmatically save fonts from custom code with `fontyourface_save_font($font_data)`
- Bulk-delete every font from one provider with `fontyourface_delete($provider)` when disabling it
- Generate `font-family/style/weight` CSS for a font with `fontyourface_font_css()`
- Turn on detailed import logging (`fontyourface_detailed_logging`) to debug provider imports
- Write a custom provider submodule to integrate any other web-font service
- Override how a font's `@font-face`/link markup is produced via `hook_fontyourface_font_css()`
- Aggregate many enabled fonts into a single Google Fonts request URL to reduce HTTP calls
- Manage typography centrally so editors/themers pick from a curated, enabled font set
- Migrate a site off inline theme `@font-face` rules into managed, swappable font entities
