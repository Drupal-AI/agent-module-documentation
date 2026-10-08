<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Translation adds a one-click "Translate" button to content-entity add forms and bulk actions that machine-translate a node (with its Paragraphs), media, block, or taxonomy term into the site's other languages using a configurable provider (Google, DeepL, LibreTranslate, Amazon Translate, or Drupal AI).

---

The module builds on core `content_translation`. Via `hook_form_alter` on node/media/block/taxonomy
add forms it injects a Translate control that, on use, walks the entity's translatable fields (including
nested Paragraphs and entity references), sends each text value to the selected translation provider, and
writes the returned translations back as new entity translations. HTML is preserved by parsing markup and
translating only text nodes; results are cached (24h). Providers, chosen at
`/admin/config/system/auto-translation` (permission `administer auto_translation module`), are: **Google**
free client-side endpoint (`translate.googleapis.com/translate_a/single`), Google **server-side** API
(`google/cloud-translate`), **DeepL** (`api-free`/`api` `deepl.com/v2/translate`), **LibreTranslate**
(`libretranslate.com/translate`), **Amazon Translate**, and **Drupal AI** (via the AI Translate / `ai.provider`
service). All provider endpoints are fixed in code; API keys/secrets are `Html::escape`d and passed through
`encryptApiKey()` before being stored in `auto_translation.settings`. Two bulk **Action** plugins —
*Auto Translate and Publish* and *Auto Translate (save as draft)* — let editors translate many entities at
once from a Views/content listing. A second permission, `auto translation translate content`, gates who may
run translations. You choose which content types are enabled, exclude specific fields, and set whether bulk
output is published or saved as draft.

---

- Translate a new node into all other site languages with one click on the add form.
- Auto-translate nested Paragraphs and referenced entities along with the parent node.
- Bulk-translate many nodes from a content listing and publish them.
- Bulk-translate many nodes and save the translations as drafts for review.
- Translate media entities into the site's other languages.
- Translate custom block content across languages.
- Translate taxonomy terms across languages.
- Use the free client-side Google Translate endpoint without an API key.
- Use the paid Google Cloud Translate server-side API with a key for higher quality/limits.
- Use DeepL (free or Pro) as the translation provider.
- Use a self-hosted or hosted LibreTranslate instance.
- Use Amazon Translate with access key / secret / region.
- Use a Drupal AI provider (via AI Translate) for LLM-based translation.
- Restrict which content types get the auto-translate control.
- Exclude specific fields (e.g. codes, SKUs) from being translated.
- Preserve inline HTML markup while only translating visible text.
- Keep translation output consistent by caching repeated strings for 24h.
- Limit who can run translations via the `auto translation translate content` permission.
- Seed a multilingual site quickly, then have editors post-edit machine output.
- Switch translation providers without changing content or workflow.
- Save DeepL/Google API costs by caching and by excluding non-text fields.
- Translate long fields in chunks to stay within provider length limits.
