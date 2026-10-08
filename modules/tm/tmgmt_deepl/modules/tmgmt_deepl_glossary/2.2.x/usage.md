<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeepL glossaries (tmgmt_deepl_glossary) is a submodule of DeepL Translator that lets you create and manage DeepL glossaries in Drupal — lists of source→target term pairs — so DeepL translates those terms consistently, supporting both the classic per-language-pair glossaries and DeepL's newer multilingual glossaries.

---

The submodule adds content entities to model glossaries: **`deepl_glossary`** (a classic
single-language-pair glossary, base table `tmgmt_deepl_glossary`, with fields `label`,
`source_lang`, `target_lang`, `tmgmt_translator`, remote `glossary_id`, `ready`, `entry_count`,
and an `entries` field of the module's own field type **`deepl_glossary_item`** whose items hold a
`subject`/`definition` term pair), plus **`deepl_ml_glossary`** and
**`deepl_ml_glossary_dictionary`** for DeepL's multilingual glossaries (a glossary with multiple
language-pair dictionaries). Admin listing is a View (`configure` route
`view.tmgmt_deepl_glossary.page_1`); a fetch form (`/admin/tmgmt/deepl_glossaries/fetch`) pulls
existing multilingual glossaries from DeepL. Service classes `DeeplGlossaryApi` and
`DeeplMultilingualGlossaryApi` (with batch variants) call the DeepL glossary REST API to create,
list, sync and delete glossaries, and the created glossary id is stored back on the entity so the
parent module's translator uses it. Access is governed by a set of dedicated permissions
(`administer/add/edit/delete deepl_glossary entities`, `edit deepl_glossary glossary entries`,
`access deepl_glossary overview`). Custom Views field/filter plugins power the overview and entry
search. Talking to DeepL needs the parent module's auth key, but the glossary entities, field
type, permissions and views are ordinary local Drupal constructs.

---

- Enforce consistent translation of brand names and jargon across DeepL translations.
- Create a DeepL glossary of source→target term pairs for a specific language pair.
- Manage multilingual DeepL glossaries with multiple language-pair dictionaries.
- Store glossary term pairs (subject/definition) using the deepl_glossary_item field.
- Fetch existing multilingual glossaries from DeepL into Drupal.
- Attach a glossary to a DeepL translator so jobs use it automatically.
- Keep an editable local copy of glossary entries and sync them to DeepL.
- Browse all glossaries from the admin overview View.
- Search within a glossary's entries via the custom views filter.
- Restrict who can create/edit/delete glossaries with dedicated permissions.
- Let translators edit glossary entries without full admin rights.
- Translate legal or medical content with mandated terminology.
- Maintain per-project glossaries for different clients or brands.
- Bulk-create glossary entries through the batch API service.
- Track which remote DeepL glossary id maps to a Drupal glossary entity.
- Mark a glossary "ready" once it is synced to DeepL.
- Provide language-specific terminology for German/French/etc. DeepL output.
- Delete a DeepL glossary from Drupal and remove it remotely.
- Support editorial teams needing controlled vocabulary in translations.
- Combine with the parent tmgmt_deepl translator for glossary-aware machine translation.
