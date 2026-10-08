<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CSV import form and file format

Form `Drupal\lupus_taxonomy_import\Form\ImportForm` (`getFormId()` →
`lupus_taxonomy_import_import_form`), at `/admin/config/content/taxonomy/csv_import`. Three inputs:

- `vocabulary_id` — required select, options are every `taxonomy_vocabulary` (`Vocabulary::loadMultiple()`), keyed by machine id, labelled by name.
- `csv_file` — `#type => file`, upload validators `FileExtension => csv` and `FileSizeLimit => Environment::getUploadMaxSize()`. The description links the two example downloads.
- `purge_vocabulary` — checkbox, off by default. If ticked, **all** existing terms of the chosen vocabulary are `delete()`d before the import, which drops every entity reference to them.

`validateForm()` calls `file_save_upload('csv_file', …, FALSE, 0)` (unmanaged temp file), errors if
empty, then runs `Importer::validate()` and reports each returned message as a warning. `submitForm()`
calls `Importer::importFromCsv($file, $vid, $purge)`, then deletes the temp file (`file.usage`
delete + `$file->delete()`), and on success redirects to
`/admin/structure/taxonomy/manage/{vid}/overview`. The run is synchronous — no Batch API.

## The file format

The header row defines columns of two kinds:

- **Level columns** — header cells whose value is numeric: `0, 1, 2, …`. `0` is the top of the tree.
  They must appear in ascending order starting at 0.
- **Field columns** — header cells whose value is not numeric. Each is treated as a term field
  machine name and its cell value is written to that field on the created term.

Each data row names **one** term: `Importer::getTermItem()` scans the numeric-keyed columns left to
right and takes the first non-empty one as the term name, its column index as the term's **level**.
So you place a term's name in the numbered column that matches its depth and leave the other numbered
columns blank. Non-numeric columns on that row become the term's field values.

`Importer::mapRows()` then walks the rows top-to-bottom building parent/child pairs: a row is a child
of the last row exactly one level shallower. Parent linkage is tracked by a synthetic id
(`md5(parent_id . print_r(row))`) mapped to the real term id after each `save()`, so `parent` is set
correctly as terms are created in document order.

### Field handling on import
For each field column, the importer sets the value only if `$term->hasField($fieldname)` is true and
the field is not protected; if the field does not exist on the vocabulary it is silently skipped, and
`EntityReferenceFieldItemList` fields are skipped too. Protected fields, rejected at header validation
and never written: `changed`, `parent`, `tid`, `uuid`, `vid`, `metatag`.

### Validation rules (`Importer::validate()`)
- A protected field name in the header → error.
- Numeric level columns out of order (e.g. header `0, 2`) → "Header term keys are in the wrong order".
- More than one term populated on a single row → "Multiple entries on a single row. Row N".
- First data row does not start with a level-0 term → "First row does not begin with a term."
- Any term name used more than once anywhere in the file → "Multiple terms not allowed, `X` was used N times". Term names must be globally unique across the file.

## Example: hierarchical (`example_with_hierarchy.csv`)

```
0,1,2,status,field_seo_title,weight,description
Garten,,,1,Der Garten,100,"Ein Garten ist ..."
,Pflanzen,,1,Die Pflanzen,120,"Als Pflanzen ..."
,,Agave,0,Die Agave,121,Die Agaven ...
,,Ahorn,0,Der Ahorn,122,Die Ahorne ...
,Tiere,,1,Die Tiere,110,"Als Tiere ..."
...
Wohnen,,,1,Das Wohnen,200,"Eine Wohnung ..."
```

`Garten` (col 0) is a root; `Pflanzen` (col 1) is its child; `Agave`, `Ahorn` (col 2) are children of
`Pflanzen`; `Tiere` (col 1) is another child of `Garten`; `Wohnen` (col 0) starts a new root. `status`,
`weight`, `description` are core term fields; `field_seo_title` is a custom field that must already
exist on the vocabulary or it is ignored.

## Example: flat (`example_ingredients.csv`)

```
0,field_seo_title,field_plural_name,field_link
Ei,Ei,Eier,https://de.wikipedia.org/wiki/Ei_(Lebensmittel)
Mehl,Mehl,Mehl,https://de.wikipedia.org/wiki/Mehl
```

A single level column `0` — every term is a root — plus three custom field columns.

## Create-only, no update
There is no lookup of existing terms by name: every data row produces a new `create()`d term. Running
a file twice without `purge_vocabulary` yields duplicates. To reload a corrected file, use Purge (and
accept that references to the old terms break) or clear the vocabulary yourself first.
