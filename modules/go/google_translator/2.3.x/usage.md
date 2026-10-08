<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Translator provides a placeable block that embeds Google Translate's client-side "Website Translator" widget, letting anonymous visitors machine-translate the current page into a curated list of languages without any server-side Drupal translation.

---

The module ships a single Block plugin (`id: google_translator`, category "Google Translator") plus one settings form at `/admin/config/regional/google-translator` (route `google_translator.config`). All behaviour is driven by the `google_translator.settings` config object, whose keys are `google_translator_active_languages_display_mode` (`SIMPLE`, `HORIZONTAL`, or `VERTICAL`), `google_translator_active_languages` (an array of Google language short codes such as `pt`, `es`, `fr`), `google_translator_disclaimer_title`, and `google_translator_disclaimer`. When the block renders it attaches the Google Translate `element.js` script and the module's own JS libraries, exposing the active languages and display mode through `drupalSettings`. An optional disclaimer, if text is supplied, pops up a jQuery UI modal (Accept / Do Not Accept) the first time a visitor clicks the selector, warning that translations come from a third-party service. Because translation happens entirely in the visitor's browser via Google's script, the module needs no API key and stores no translated content; it depends only on core's Block module and defines the granular permission `administer google_translator settings`.

---

- Add a "Translate this page" language selector block to a header, sidebar, or footer region.
- Offer machine translation of an English-only site into a handful of chosen languages.
- Curate exactly which target languages appear in the selector (e.g. only `pt`, `es`, `fr`).
- Present the widget compactly with the `SIMPLE` display mode.
- Show a "Powered by Google" label beside the selector using the `HORIZONTAL` display mode.
- Show the "Powered by Google" label beneath the selector using the `VERTICAL` display mode.
- Require visitors to accept a legal disclaimer modal before the page is translated.
- Customise the disclaimer modal's title and body text (admin-filtered HTML allowed).
- Provide a quick translation affordance on a marketing site without building full multilingual content.
- Let non-technical editors change available languages from a single admin form.
- Grant a restricted role rights to manage the widget via the `administer google_translator settings` permission.
- Deploy widget configuration through exported config (`google_translator.settings.yml`).
- Add translation to a decoupled-lite page where full content translation is overkill.
- Give international visitors a self-service way to read content in their own language.
- Place multiple instances of the block scoped to different regions or visibility conditions.
- Style the translate modal by overriding `core/drupal.dialog` in a theme.
- Offer translation on legal/support pages while keeping the disclaimer front and centre.
- Add language coverage (e.g. Japanese `ja`, German `de`) without translating source content.
- Roll out a consistent translate widget across many pages via block placement.
- Supplement Drupal's own interface translation with on-page browser translation for visitors.
- Provide an accessibility-friendly "read this in my language" option for public content.
- Keep translation off the server so no third-party API credentials need managing.
