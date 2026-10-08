GTranslate adds a Google-powered language switcher block that machine-translates the whole site into up to 103 languages on the fly, no per-string Drupal translation required.

---

GTranslate provides a single block plugin ("GTranslate", category *Accessibility*) that renders a JavaScript language switcher widget powered by Google Translate. Once you place the block and pick the languages to expose, visitors can translate the current page client-side into any of ~103 languages — this is automatic machine translation, not Drupal's core i18n/Content Translation, so no source strings are stored or human-reviewed. A single settings form at **Admin → Configuration → Regional and language → GTranslate** (`/admin/config/regional/gtranslate`, route `gtranslate.settings`) controls the widget's appearance: choose from twelve widget looks (float, nice dropdown with flags, flags + dropdown, plain flags, dropdown, flags with name/code, language names, language codes, globe, popup, popup with search), the source ("translate from") language, flag size/style (2D SVG or 3D PNG), globe size, light/dark color scheme, floating position and open direction, a custom wrapper CSS selector, native language names, browser-language auto-detection, and custom CSS. The list of offered languages is chosen and reordered (drag-and-drop weights) in the form's Languages table. Settings persist in the `gtranslate.settings` config object (defaults shipped in `config/install`). The free mode uses `url_structure: none` — translations happen in-page via JavaScript and are **not** indexed by search engines; paid GTranslate plans unlock sub-directory (`example.com/fr`) or sub-domain (`fr.example.com`) URL structures that are indexable, plus custom-domain hosting synced from the GTranslate dashboard. Widget assets load from the GTranslate CDN by default (`enable_cdn`), or locally from the module's `js/` and `flags/` folders when the CDN is disabled. Access to the settings form is gated by the `gtranslate settings` permission.

---

- Make an English-only site instantly readable in ~103 languages without translating any content.
- Add a floating language switcher in a screen corner via the "Float" widget look.
- Place a compact flag dropdown in the header region for language selection.
- Offer a globe-style widget that expands to a language list.
- Show a popup (optionally with search) language chooser for sites with many languages.
- Let visitors auto-switch to their browser language on first visit (`detect_browser_language`).
- Restrict the switcher to a curated set of languages instead of all 103.
- Reorder the offered languages via drag-and-drop weights so priority markets appear first.
- Display language names in their native alphabet (e.g. "Deutsch", "日本語") with `native_language_names`.
- Set the site's source language so Google knows what it is translating from.
- Choose 2D SVG or 3D PNG flag icons and a flag size (16/24/32/48px).
- Match a dark theme using the dropdown-with-flags dark color scheme.
- Brand or restyle the widget with custom CSS in the settings form.
- Render the switcher inside a specific element using a custom wrapper CSS selector.
- Serve widget images/JS from the GTranslate CDN, or locally by disabling CDN for privacy/offline.
- Add a quick "translate this page" affordance to a marketing or documentation site cheaply.
- Provide machine translation as a fallback where full human Content Translation is not worth it.
- Show alternative country flags (USA/Canada for English, Mexico/Argentina/Colombia for Spanish, Brazil for Portuguese, Quebec for French).
- Upgrade to indexable sub-directory URLs (`example.com/fr`) with a paid GTranslate plan for multilingual SEO.
- Use indexable sub-domain URLs (`fr.example.com`) on a paid plan.
- Connect custom per-language domains (e.g. `example.fr`) synced from the GTranslate dashboard.
- Position the floating widget in any corner and control which direction it opens.
- Add a language switcher without enabling Drupal's core Content Translation stack.
- Gate who may change the widget configuration with the `gtranslate settings` permission.
- Deploy the widget configuration between environments as exported Drupal config.
