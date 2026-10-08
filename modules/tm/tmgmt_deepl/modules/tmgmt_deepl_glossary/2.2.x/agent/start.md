<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL glossaries (tmgmt_deepl_glossary) — agent index

Submodule of **DeepL Translator**. Create/manage DeepL glossaries (source→target term pairs) in
Drupal so DeepL translates terms consistently. Adds content entities + a field type + dedicated
permissions + a Views overview. Sync/create/delete call the DeepL API (needs the parent key);
the entities themselves are local content.

- **The glossary entities, the deepl_glossary_item field, admin overview + fetch, sync** →
  [configure/glossaries.md](configure/glossaries.md)
- **The DeepL glossary API service classes** → [api/services.md](api/services.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entities: `deepl_glossary` (classic, base table `tmgmt_deepl_glossary`), `deepl_ml_glossary` +
  `deepl_ml_glossary_dictionary` (multilingual). Field type `deepl_glossary_item`
  (`subject`/`definition`).
- Configure route `view.tmgmt_deepl_glossary.page_1` (admin overview View). Fetch form
  `/admin/tmgmt/deepl_glossaries/fetch`.
- Services `tmgmt_deepl_glossary.api` / `.ml.api` (+ batch). Permissions listed in the
  permissions doc. Depends on `tmgmt_deepl`. Parent docs: `modules/tmgmt_deepl/2.2.x/`.
