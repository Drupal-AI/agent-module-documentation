<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL glossaries (tmgmt_deepl_glossary) — agent index

Submodule of **DeepL Translator**. Create/manage DeepL **multilingual** glossaries (a glossary with
one or more language-pair dictionaries of source→target term pairs) in Drupal so DeepL translates
terms consistently, and auto-apply a matching glossary to TMGMT jobs. Adds two content entities, a
field type, dedicated permissions, admin Views, CSV import/export, and a DeepL-glossary API service.
Depends on `tmgmt_deepl`. Core `^11.4`, PHP `8.4`.

- **The glossary entities, `deepl_glossary_item` field, admin Views, fetch + CSV, matching/sync** →
  [configure/glossaries.md](configure/glossaries.md)
- **The DeepL glossary API service + helper/batch** → [api/services.md](api/services.md)
- **Permissions & access control** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entities: `deepl_ml_glossary` (base table `tmgmt_deepl_ml_glossary`) and
  `deepl_ml_glossary_dictionary` (base table `tmgmt_deepl_ml_glossary_dictionary`). Both use
  `AccessControlHandler`, `AdminHtmlRouteProvider`, `DeeplMultilingualGlossaryViewsData`,
  `admin_permission: 'administer deepl_glossary entities'`. Field type `deepl_glossary_item`
  (`subject`/`definition`; widget `deepl_glossary_item_widget`, formatter
  `deepl_glossary_item_formatter`). (The classic `deepl_glossary` entity of 2.2.x was removed.)
- Configure route `entity.deepl_ml_glossary.collection` = `/admin/tmgmt/deepl_glossaries`.
  Fetch form `/admin/tmgmt/deepl_glossaries/fetch`. CSV upload
  `/admin/tmgmt/deepl_glossaries/{deepl_ml_glossary}/csv-upload`; CSV download
  `/admin/tmgmt/deepl_glossaries/dictionary/{deepl_ml_glossary_dictionary}/csv`.
- Services: `tmgmt_deepl_glossary.ml.api` (`DeeplMultilingualGlossaryApi`), `.ml.helper`
  (`DeeplMultilingualGlossaryHelper`), `.ml.batch` (`DeeplMultilingualGlossaryBatch`). Uses the
  parent's `tmgmt_deepl.client_factory` + `tmgmt_deepl.language_support`.
- Hooks (`Hook/TmgmtDeeplGlossaryHooks`): implements the parent's checkout/has-checkout/translate-
  options alters to inject `$options['glossary']`, plus `entity_operation` (CSV download op) and a
  menu-local-action preprocess. Provides `hook_tmgmt_deepl_glossary_allowed_languages_alter`.
- 6 permissions (see permissions doc). Config schema for the field value + two Views plugins.
  Parent docs: `modules/tmgmt_deepl/2.4.x/`.
