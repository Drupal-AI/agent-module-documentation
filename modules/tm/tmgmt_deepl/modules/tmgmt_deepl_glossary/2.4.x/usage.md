<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeepL glossaries (tmgmt_deepl_glossary) is a submodule of DeepL Translator that lets you create and manage DeepL **multilingual glossaries** in Drupal — glossaries made of one or more language-pair dictionaries of source→target term pairs — so DeepL translates those terms consistently, and automatically applies a matching glossary to TMGMT jobs.

---

The submodule models glossaries with two content entities: **`deepl_ml_glossary`** (base table
`tmgmt_deepl_ml_glossary`; fields `label`, `tmgmt_translator`, remote `glossary_id`, `uid`,
`created`) and **`deepl_ml_glossary_dictionary`** (base table `tmgmt_deepl_ml_glossary_dictionary`;
`glossary_id` reference, `source_lang`, `target_lang`, `entry_count`, `entries_format` = `tsv`, and
an `entries` field of the module's own field type **`deepl_glossary_item`** whose items hold a
`subject`/`definition` term pair). Admin listings are Views
(`tmgmt_deepl_ml_glossary`, `tmgmt_deepl_ml_glossary_dictionary`), reached via the glossary
collection route `entity.deepl_ml_glossary.collection` (`/admin/tmgmt/deepl_glossaries`, the
`configure` route). A fetch form (`/admin/tmgmt/deepl_glossaries/fetch`) imports existing
multilingual glossaries from DeepL, and dictionary entries can be imported/exported as CSV. The
service `DeeplMultilingualGlossaryApi` (`tmgmt_deepl_glossary.ml.api`) wraps DeepL's multilingual
glossary endpoints (create/update/replace/list/get/delete glossaries and dictionaries) via the
parent module's `DeepLClientFactory`; `DeeplMultilingualGlossaryHelper`
(`tmgmt_deepl_glossary.ml.helper`) resolves allowed languages (from the DeepL glossary language
resource, alterable via `hook_tmgmt_deepl_glossary_allowed_languages_alter`), validates language
pairs, and finds the glossary matching a job's source/target. Hook implementations add a glossary
selector to the DeepL checkout form and inject the chosen (or auto-matched) glossary id into the
translate options. Access is governed by dedicated permissions; deleting a glossary cascades to its
dictionaries and removes the remote DeepL glossary. Talking to DeepL needs the parent module's Key,
but the glossary entities, field type, permissions and views are ordinary local Drupal constructs.

---

- Enforce consistent translation of brand names and jargon across DeepL translations.
- Create a DeepL multilingual glossary holding several language-pair dictionaries.
- Add a dictionary (source→target term pairs) for a specific language pair.
- Store term pairs (subject/definition) using the `deepl_glossary_item` field type.
- Import an existing multilingual glossary from DeepL via the fetch form.
- Upload dictionary entries from a CSV file (`/admin/tmgmt/deepl_glossaries/{glossary}/csv-upload`).
- Download a dictionary's entries as CSV for editing or backup.
- Attach a glossary to a DeepL translator so matching jobs use it automatically.
- Auto-select the glossary matching a job's source and target language at checkout.
- Let editors pick among multiple matching glossaries at job checkout.
- Restrict who can add/edit/delete glossaries with dedicated permissions.
- Let translators edit glossary entries without full admin rights.
- Restrict which glossary languages editors may choose per site via the allowed-languages hook.
- Translate legal or medical content with mandated terminology.
- Maintain per-project glossaries for different clients or brands.
- Keep the remote DeepL glossary id mapped to a Drupal glossary entity.
- Delete a glossary in Drupal and have its remote DeepL glossary and dictionaries removed.
- Browse all glossaries and their related dictionaries from the admin overview Views.
- Search or filter the overview by the DeepL translator a glossary belongs to.
- Combine with the parent tmgmt_deepl translator for glossary-aware machine translation.
