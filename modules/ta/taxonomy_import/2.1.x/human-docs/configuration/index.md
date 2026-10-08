# Configuration

Taxonomy Import has two admin pages: the **import** form (where you actually run an
import) and the **settings** form (where you tune the upload rules). This page
covers both, plus the file format the importer expects.

## The import form

Go to **Configuration → Content authoring → Taxonomy Import**
(`/admin/config/content/taxonomy_import/import`). You need the *administer taxonomy
import* permission. The form has three fields:

- **Vocabulary name** — a drop-down of your *existing* vocabularies. The module
  does not create one, so make sure the vocabulary exists first.
- **Force new terms for every record** — controls what happens when a term with
  the same name already exists:
  - *No, allow updating* — for a row whose name matches an existing term, the
    module updates that term (adds the parent, sets the description and any custom
    fields) instead of creating a duplicate.
  - *Yes, create a new term for every record* — always creates a brand-new term,
    even if the name already exists.
- **Import file** — the CSV or XML file to upload. It is validated against the
  extensions and size limits set on the settings form (below).

On success you are redirected to the chosen vocabulary's term overview so you can
see the imported terms.

## The file format

Rows are read into **name, parent, description** in that fixed order:

- **CSV** — the **first row is treated as a header and skipped**. After that,
  column 1 is the name, column 2 is the parent, column 3 is the description. Rows
  with an empty first column are skipped.
- **XML** — each child element of the root becomes a row, so use `<name>`,
  `<parent>`, and `<description>` tags inside each. Rows with no `<name>` are
  skipped. (Unlike CSV, XML does not skip a header.)

Example CSV — list a parent term *before* its children to build the hierarchy:

```csv
name,parent,description
Fruit,,Top level
Apple,Fruit,A pome fruit
Banana,Fruit,A tropical fruit
```

**How parents are matched:** the parent value is matched by *name* against terms
that already exist in the same vocabulary. A parent that does not yet exist resolves
to "no parent," so order matters — put parents ahead of their children.

**Custom fields:** any extra columns (CSV) or tags (XML) beyond name/parent/
description are matched against the vocabulary's own fields. If a field with that
machine name exists on the vocabulary, its value is set on the term; otherwise the
extra column is ignored.

The module ships sample `CSV_Test.csv` and `XML_Test.xml` files in its directory
that you can copy as a starting point.

## The settings form

Go to `/admin/config/content/taxonomy_import/settings_import_taxonomy` (permission
*administer configure taxonomy import*). It controls how uploaded files are
validated, storing its values in the `taxonomy_import.config` config object:

| Setting | Default | What it does |
|---|---|---|
| **File extensions** (`file_extensions`) | `csv xml` | Space-separated list of allowed upload extensions. Add `txt`, for example, to accept plain-text exports. |
| **Maximum file size** (`file_max_size`) | `256000000` | Largest allowed upload, in **bytes** (the default is roughly 256 MB). Lower it to restrict big uploads, or raise it for very large term files. |

You can also read or change these from the command line:

```bash
drush cget taxonomy_import.config file_extensions
drush cset taxonomy_import.config file_extensions 'csv xml txt' -y
drush cset taxonomy_import.config file_max_size 12000000 -y
```
