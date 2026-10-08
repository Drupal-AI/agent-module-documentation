Taxonomy Import bulk-creates taxonomy terms in an existing vocabulary from an uploaded CSV or XML file, mapping the first column/tag to the term name, the second to a parent term (matched by name for hierarchy), and the third to a description.

---

The module adds an admin import form at `/admin/config/content/taxonomy_import/import` (route `taxonomy_import.import`) where you pick an existing vocabulary, choose an import behaviour, and upload a CSV or XML file. On submit, `ImportForm` reads the file — CSV via `fgetcsv` (skipping the header row), XML via `simplexml_load_string` (iterating child elements) — into rows of `name`, `parent`, and `description`, then hands them to the `taxonomy_import.term_utils` service (`TaxonomyUtils::saveTerms($vid, $rows, $forceNewTerms)`). Parents are resolved by looking up an existing term with the parent's name in the same vocabulary, so listing a parent term earlier in the file builds a hierarchy. The **import behaviour** select controls updates: `0` updates an existing same-named term (adds the parent, updates description/custom fields), while `1` forces a brand-new term for every row. Any extra columns/tags beyond name/parent/description are matched against the vocabulary's own custom fields and set on the term when a field of that machine name exists. A separate settings form at `/admin/config/content/taxonomy_import/settings_import_taxonomy` (route `taxonomy_import.config`, config object `taxonomy_import.config`) governs the upload validators — `file_extensions` (default `csv xml`) and `file_max_size` (default `256000000` bytes). Two permissions gate the pages: `administer taxonomy import` (the import form) and `administer configure taxonomy import` (the settings form). The module does not create the vocabulary for you — it must already exist — and ships sample `CSV_Test.csv` / `XML_Test.xml` files.

---

- Bulk-load hundreds of taxonomy terms into a vocabulary from a spreadsheet export (CSV).
- Import a category tree from an XML feed into an existing vocabulary.
- Build a hierarchical vocabulary by listing parent terms before their children in the file.
- Populate a "Countries" or "Tags" vocabulary from a downloaded reference list.
- Add descriptions to terms in bulk via the third CSV column / XML tag.
- Update existing terms' parents and descriptions by re-importing with the "update" behaviour.
- Force-create duplicate terms for every row when duplicates are intended (behaviour = Yes).
- Migrate taxonomy from another CMS by exporting to CSV and importing here.
- Seed a fresh site's vocabularies with a standard term set during setup.
- Set custom term fields during import by adding extra columns whose headers match field names.
- Re-run an import against the same vocabulary to top up new terms without touching existing ones.
- Restrict who can run imports using the `administer taxonomy import` permission.
- Restrict who can change upload limits using the `administer configure taxonomy import` permission.
- Raise or lower the allowed upload size for large term files (`file_max_size`).
- Allow additional upload extensions (e.g. add `txt`) via `file_extensions`.
- Import terms programmatically by calling the `taxonomy_import.term_utils` service.
- Create a category hierarchy for an e-commerce catalogue from supplier data.
- Load geographic hierarchies (region → country → city) as nested terms.
- Import a controlled vocabulary / thesaurus supplied as XML.
- Keep a vocabulary in sync with an external source by periodic CSV re-imports.
- Prototype content models quickly by importing sample term sets from the shipped example files.
- Give non-developers a UI to add many terms at once instead of one-by-one term forms.
