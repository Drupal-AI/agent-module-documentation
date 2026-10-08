<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Internationalization adds Twig helpers for multilingual sites: the current language code, i18n-aware date formatting, and fetching the correct entity translation.

---

This submodule of Bamboo Twig registers, on service `bamboo_twig_i18n.twig.i18n`, the function `bamboo_i18n_current_lang()` (the current language id), the filter `bamboo_i18n_format_date` (formats a date via Drupal's date formatter using the current language for text, supporting built-in types, date-format config ids, or a custom PHP format), and the filter `bamboo_i18n_get_translation` (returns an entity's translation for the current or a given language through the entity repository). These let themers build language-correct output without preprocess code.

---

- Set the `<html lang>` attribute from `bamboo_i18n_current_lang()`.
- Show the active language code in a language switcher template.
- Conditionally render markup for a specific language in an `{% if %}`.
- Format a node's creation date in the current UI language (`| bamboo_i18n_format_date('long')`).
- Render a localized short/medium/long date in a template.
- Apply a named date-format config entity to a timestamp in Twig.
- Use a custom PHP date pattern (`| bamboo_i18n_format_date('custom', 'd/m/Y')`).
- Format an event date honouring the visitor's language for month names.
- Display a translated timezone-aware datetime.
- Fetch the French translation of an entity (`node | bamboo_i18n_get_translation('fr')`).
- Render an entity in the current context language automatically.
- Show a referenced entity's label in the correct translation.
- Build hreflang links using the current language code.
- Localize dates in a listing across many languages.
- Avoid a preprocess hook to get the current langcode.
- Present translated titles in a block built from Twig.
- Combine translation lookup with field rendering in one template.
- Keep multilingual presentation logic inside `.html.twig` files.
