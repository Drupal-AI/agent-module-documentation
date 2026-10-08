<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure DeepL translation

Two admin forms, both gated by `administer site configuration`.

## API key + glossary — `/admin/config/regional/deepl`

Route `auto_node_translate_deepl.settings`, form `Form\SettingsForm`, config object
`auto_node_translate_deepl.settings`:

| Key | Field | Notes |
|---|---|---|
| `apikey` | textfield (required, maxlength 256) | DeepL API key (free or pro). |
| `glossary_id` | textfield | Optional DeepL glossary id; leave empty for none. |

No config schema is shipped, so these are stored untyped. Set via Drush:
`ddev drush config:set auto_node_translate_deepl.settings apikey <KEY>`.

## Language mapping — `/admin/config/regional/deepl/mapping`

Route `auto_node_translate_deepl.mapping`, form `Form\LanguageMapping`, config object
`auto_node_translate_deepl.language_mapping`. For every Drupal language it renders a source and a
target select whose options come from DeepL's live `getSourceLanguages()` / `getTargetLanguages()`
(so the API key must be valid to open this form). Values are stored per language id as:

- `source_<langcode>` → DeepL source code
- `target_<langcode>` → DeepL target code

## Provider plugin (grounding)

`Plugin/AutoNodeTranslateProvider/DeeplTranslator::translate($text, $from, $to)`:
1. Reads `apikey` and constructs `new DeepL\Translator($apiKey)`.
2. Resolves `$from`/`$to` through the mapping config (`source_<from>` / `target_<to>`); if unmapped,
   the raw Drupal langcode is passed to DeepL unchanged.
3. Calls `translateText($text, $from, $to, [TAG_HANDLING => 'html', PRESERVE_FORMATTING => 1])`,
   adding `GLOSSARY => glossary_id` when set.
4. On any exception it shows the error via messenger and returns the **original** `$text` untouched.

This module only provides the backend; the parent `auto_node_translate` module owns the UI,
permissions, and decision of which nodes/fields get translated and when.
