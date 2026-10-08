<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cyrillic to Latin transliterates Serbian text from Cyrillic to Latin script at display time, so one set of content serves readers of both alphabets.

---

Serbian is written in two official alphabets with a one-to-one mapping, so converting is mechanical rather than a translation — nothing is reviewed and content stays single-sourced. Install with `composer require drupal/cyrillic_to_latin` and enable with `drush en cyrillic_to_latin -y` (it requires core's **Locale** module), then configure at **admin/config/regional/cyrillic-to-latin**: set **Enabled** to *Yes* and tick the **Languages** the conversion should apply to (default **sr**). The module works three ways. It replaces core's `string_translation` service, so every interface string that passes through Drupal's `t()` function — menu labels, field labels, messages, UI text — is converted for the selected language. It preprocesses rendered field output for `string`, `string_long`, `text`, `text_long`, `text_with_summary`, and `list_string` fields, and (when the **Address** module is used) the country name of address fields, including a views field named `address`. And with the optional **Transliterate strings on .po file import** checkbox it permanently rewrites stored locale translations to Latin as they are imported. Conversion runs only when the module is enabled **and** the current interface language is one you selected, and because the service swap and rendered output are cached you must **clear the cache** after changing any setting for it to take effect. Note the conversion is one-way — Cyrillic to Latin is deterministic, the reverse is not — and it replaces every mapped character, so proper nouns, URLs, and Latin substrings embedded in Cyrillic text are converted too.

---

- Serve Serbian content in Latin script from Cyrillic source.
- Convert interface strings passed through `t()` to Latin.
- Convert menu labels and field labels to Latin.
- Convert string and text field values on display.
- Convert list (select) field displayed values to Latin.
- Convert an Address field's country name to Latin.
- Convert a views field named `address` to Latin.
- Transliterate `.po` locale imports to Latin permanently.
- Apply conversion only to selected languages (default `sr`).
- Keep content single-sourced instead of maintaining two scripts.
- Serve younger / online readers who prefer Latin.
- Serve a Serbian diaspora audience in Latin.
- Support a Serbian news or government site's script policy.
- Enable or disable conversion from one settings form.
- Offer Latin output without duplicating pages.
- Reuse the static converter from custom code.
- Avoid editing content twice for two alphabets.
- Support Serbian digraphia with a deterministic mapping.
