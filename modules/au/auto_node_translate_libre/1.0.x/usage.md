<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Node Translate Libre registers LibreTranslate as a translation-provider plugin for Auto Node Translate, so node content can be machine-translated through a self-hostable LibreTranslate server.

---

Auto Node Translate Libre is a small backend/provider add-on for the Auto Node Translate module. Auto Node Translate owns the workflow of creating and populating a node's translations; this module plugs in one provider, `LibreTranslator` (plugin id `auto_node_translate_libre`, label "Libre"), that fulfils each field's `translate($text, $from, $to)` call by talking to a LibreTranslate HTTP API. It first calls the server's `/languages` endpoint to confirm the source/target pair is supported, then POSTs the text to `/translate` and returns the `translatedText` from the JSON response. The LibreTranslate base URL and API key are set on a dedicated settings form at `/admin/config/regional/libre` (route `auto_node_translate_libre.settings`, gated by `administer site configuration`), stored in the config object `auto_node_translate_libre.settings`. Because LibreTranslate is free and self-hostable, this provider suits sites that want machine translation without a commercial API, or that must keep content on their own infrastructure. It has no routes, permissions, entities, services, or Drush commands of its own beyond the settings form and the provider plugin, and requires `auto_node_translate` to be installed.

---

- Machine-translate node content with LibreTranslate instead of a commercial API.
- Register LibreTranslate as a selectable provider inside Auto Node Translate.
- Point the site at a self-hosted LibreTranslate instance for translations.
- Point the site at the public libretranslate.com endpoint instead.
- Configure the LibreTranslate base URL at `/admin/config/regional/libre`.
- Store a LibreTranslate API key for authenticated endpoints.
- Translate node fields between two language codes on demand.
- Let Auto Node Translate drive which node and which languages get translated.
- Auto-detect whether text is HTML or plain and pass the right `format` to LibreTranslate.
- Skip unsupported language pairs by checking `/languages` before translating.
- Fall back to the original text when a pair is unavailable or the API errors.
- Reduce translation cost by using an open-source engine.
- Keep translated content on infrastructure you control.
- Support multilingual editorial workflows built on Auto Node Translate.
- Swap LibreTranslate in for (or alongside) the MyMemory provider that ships with the parent module.
- Trim regional language subtags (e.g. `en-US` to `en`) before sending to LibreTranslate.
- Surface translation errors to editors via the Drupal messenger.
- Provide translations for content-heavy sites in many target languages.
- Integrate a Docker/self-run LibreTranslate container behind Drupal.
- Migrate off a paid translation service to a free engine.
