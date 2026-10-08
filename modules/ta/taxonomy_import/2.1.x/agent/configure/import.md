# Import terms & settings

## Import form (`taxonomy_import.import`)

Path `/admin/config/content/taxonomy_import/import` (permission `administer taxonomy import`).
Fields:

- **Vocabulary name** — a select of *existing* vocabularies (the module does **not** create one).
- **Force new terms for every record** (`import_behavior`):
  - `0` — *No, allow updating*: for a row whose `name` matches an existing term in the vocabulary,
    update it (add the parent, set description and any custom fields) instead of duplicating.
  - `1` — *Yes, create a new term for every record*: always create, never update.
- **Import file** (`managed_file`, required) — a CSV or XML file, validated against the settings
  `file_extensions` / `file_max_size`, uploaded to `public://taxonomy_files/`.

Accepted MIME types: `text/plain`, `application/csv`, `text/csv`, `text/xml`, `application/xml`.
On success it redirects to the vocabulary's term overview.

## File format

Rows are read into `name`, `parent`, `description` (in that order):

- **CSV** — the **first row is treated as a header and skipped**; then column 1 = name,
  column 2 = parent, column 3 = description. Rows with an empty first column are skipped.
- **XML** — each child element of the root becomes a row; its child tags are cast to an
  associative array, so use `<name>`, `<parent>`, `<description>` tags. Rows without a `name`
  are skipped. (XML does not skip a "header".)

Example CSV (build hierarchy by listing a parent term before its children):

```csv
name,parent,description
Fruit,,Top level
Apple,Fruit,A pome fruit
Banana,Fruit,A tropical fruit
```

**Parent matching:** the parent value is matched by *name* against existing terms in the same
vocabulary (the most recently keyed match wins). A parent that does not yet exist as a term
resolves to no parent (`0`), so order matters. Sample files ship as `CSV_Test.csv` /
`XML_Test.xml` in the module directory.

**Custom fields:** any extra columns/tags beyond name/parent/description are matched against the
vocabulary's field definitions (`entity_field.manager`); those that correspond to a real term
field on that vocabulary are set on the term, the rest are ignored.

## Settings form (`taxonomy_import.config`)

Path `/admin/config/content/taxonomy_import/settings_import_taxonomy`
(permission `administer configure taxonomy import`). Config object `taxonomy_import.config`
(no schema file is shipped; values are read with code-level defaults):

| Key | Default | Meaning |
|---|---|---|
| `file_extensions` | `csv xml` | Space-separated allowed upload extensions. |
| `file_max_size` | `256000000` | Max upload size in **bytes**. |

```bash
drush cget taxonomy_import.config file_extensions
drush cset taxonomy_import.config file_extensions 'csv xml txt' -y
drush cset taxonomy_import.config file_max_size 12000000 -y
```
