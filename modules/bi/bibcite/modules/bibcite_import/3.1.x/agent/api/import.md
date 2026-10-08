<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import routes, forms & formats

## Routes / forms

| Route | Path | Form | Permission |
|---|---|---|---|
| `bibcite_import.import` | `/admin/content/bibcite/reference/import` | `ImportForm` | `bibcite import`+`administer bibcite` |
| `bibcite_import.populate` | `/admin/content/bibcite/reference/populate` | `PopulateForm` | `bibcite populate`+`administer bibcite` |
| `bibcite_import.settings` | `/admin/config/bibcite/settings/import` | `SettingsForm` | `administer bibcite` |

- **ImportForm** — upload a file, pick its format, batch-create references. Deduplication of
  contributors/keywords follows `bibcite_import.settings`.
- **PopulateForm** — re-populate/normalize existing reference field values (e.g. after changing a
  mapping).
- Import runs as a Drupal **batch** (`bibcite_import.batch.inc`).

## Import formats

Formats available for import are `bibcite_format` plugins whose `encoder` implements Symfony's
`DecoderInterface`:

```bash
drush php:eval 'print implode(",", array_keys(\Drupal::service("plugin.manager.bibcite_format")->getImportDefinitions()));'
```

Each format decodes an uploaded file (by its `extension`, e.g. `.bib`, `.ris`, `.xml`, `.enw`,
`.mrc`) into reference data, which is then mapped to Bibcite fields via that format's
`bibcite_entity.mapping.<format>` config and saved as `bibcite_reference` entities.

## No Drush

bibcite_import adds no Drush commands; import/populate are UI/batch operations. Its only
configuration is `bibcite_import.settings` (see [../configure/settings.md](../configure/settings.md)).
