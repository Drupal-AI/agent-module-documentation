Auto Block Translation adds an "Automatic Translation" tab and operation to custom content blocks that machine-translates their text fields into chosen languages using the translation provider configured in the parent Auto Node Translate module.

---

Auto Block Translation is a small sub-module of Auto Node Translate that extends the same auto-translation workflow to `block_content` (custom/content block) entities. It requires core `content_translation` and `auto_node_translate` (`^3`). It defines no config of its own — the translation provider (e.g. MyMemory, Amazon Translate, IBM Watson, Google Cloud Translation) and which field types/fields are translated are all configured in `auto_node_translate.settings` at `/admin/config/auto_node_translate/config`. The module registers a per-block route `block/{block_content}/auto-translate-form` (route name `entity.block_content.auto_translation_add`), exposes it as a local task tab and as an entity operation/link on the block's translation overview, and gates it with an access check that honors core content-translation access plus the parent module's "auto translate block_content" permission. On submit, its `TranslationForm` iterates the block's fields, calls the parent `Translator` service to translate text, link, and paragraph (entity_reference_revisions) fields into each selected language, copies non-text fields as-is, and saves the block as a new revision with a "Automatic translation" revision log. Because block content is sent to the configured translation service (often an external machine-translation API) and auto-created translations are machine output, treat the results as drafts to review and be deliberate about what content is auto-translated.

---

- Add an "Automatic Translation" tab to custom content blocks.
- Machine-translate a custom block's text fields into one or more languages.
- Create new block translations automatically for selected languages.
- Overwrite (update) existing block translations from the source language.
- Reuse the same translation provider configured for Auto Node Translate.
- Translate a block using MyMemory without leaving the block UI.
- Translate a block using Amazon Translate, IBM Watson, or Google Cloud Translation (via the parent provider).
- Bulk-translate a block into every configured site language in one submit.
- Translate long-form block body/text fields alongside plain string fields.
- Translate link field text/URIs on a block via the parent Translator.
- Translate referenced Paragraphs (entity_reference_revisions) inside a block.
- Copy non-text fields unchanged into the translated block revision.
- Respect a configured exclude-fields list so certain fields are left untouched.
- Restrict who can auto-translate via the "auto translate block_content" permission.
- Trigger auto-translation from the block's translation-overview operations dropdown.
- Keep a revision history of automatic translations with an identifying revision log.
- Record the current user and request time on each auto-translation revision.
- Enforce that a translation API is configured before allowing a translation run.
- Seed multilingual site building where custom blocks must exist in many languages.
- Speed up first-draft translations of marketing/promo blocks for editor review.
- Extend the Auto Node Translate workflow from nodes to custom blocks.
- Avoid manual copy/paste translation of repeated block content.
