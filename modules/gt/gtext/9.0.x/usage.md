gText is a locale string-translation utility that gives site builders a page to browse and translate the site's interface strings, plus a Twig helper and optional Google Translate machine-translation to speed up filling in translations.

---

Built on core `locale`, gText adds a "Translating texts" admin area at `/admin/config/texts`
(configure route `gtext.translate`) where you can list translatable source strings (grouped by
context, derived from the `locales_source` table) and edit their translations per language. It
provides a Twig extension exposing a `gtext()` translation helper (and a `gtext` service /
`TextTranslationFactory` for code), so themes/templates can emit translatable, context-aware
strings. To accelerate translation it integrates machine translation: if a **Google Cloud
Translate API key** is stored in `gtext.settings.google_api_key`, it uses the official
`google/cloud-translate` client; if no key is set it falls back to a free (unofficial)
translate.google.com endpoint capped at 1000 characters per request. It also alters config- and
entity-translation forms (for users with `access gtext translate`) to add inline "translate"
buttons that call its `gtext.translate.google` endpoint via JavaScript. Two permissions gate it:
`access gtext translate strings` (the string-translation UI, marked restricted) and
`access gtext translate` (the inline translate buttons). Saving/reloading translations refreshes
the locale caches and dispatches core's `locale.save_translation` event. This module is about
**text/string translation**, not fonts or typography.

---

- Browse the site's translatable interface strings grouped by context.
- Translate a specific source string into one or more languages from `/admin/config/texts`.
- Reload/refresh a single string's translation from the list.
- Export translations for a language and group from the UI.
- Add a `gtext()` Twig helper to templates for context-aware translatable text.
- Emit translatable strings from custom code via the `gtext` service.
- Machine-translate a string with Google Cloud Translate when an API key is configured.
- Translate strings for free (no key) via the fallback translate endpoint (≤1000 chars).
- Store and validate a Google Translate API key on the settings page.
- Add inline "translate" buttons to core config-translation forms.
- Add inline "translate" buttons to entity-translation (content) forms.
- Speed up manual translation by pre-filling suggestions from Google Translate.
- Restrict access to the string-translation UI with `access gtext translate strings`.
- Restrict the inline translate buttons with `access gtext translate`.
- Group translatable strings by their locale context for easier navigation.
- Keep JavaScript and render caches in sync after saving translations.
- Dispatch the locale `save_translation` event so other modules react to updates.
- Provide translators a lighter-weight workflow than the full locale UI for common strings.
- Whitelist `t`/`plural` for the Twig sandbox so translation helpers work in templates.
- Translate short UI labels quickly during site building.
- Fall back gracefully to free translation when no paid Google key is available.
- Delete an unwanted translation via the module's API route.
