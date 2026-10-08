<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The BibTeX format

## `bibcite_format` plugin(s)

Declared in `bibcite_bibtex.bibcite_format.yml` (YAML plugin discovery). Plugin id(s): **bibtex**.
Each definition includes `id`, `label`, `extension` (bib), `encoder`
(`\Drupal\bibcite_bibtex\Encoder\BibtexEncoder`), optional `normalizer`, and `types` / `fields` lists (the BibTeX record types
and field names this format understands).

Because `BibtexEncoder` implements both Symfony `EncoderInterface` and `DecoderInterface`, the
format is available for **import** (`getImportDefinitions()`) and **export**
(`getExportDefinitions()`).

Inspect live:

```bash
drush php:eval '$p = \Drupal::service("plugin.manager.bibcite_format")->createInstance("bibtex");
print $p->getExtension()." import=".(int) $p->isImportFormat()." export=".(int) $p->isExportFormat();'
```

## Type/field mapping — `bibcite_entity.mapping.bibtex`

A config object mapping BibTeX record types and fields to Bibcite reference types and
`bibcite_*` fields. Shape:

```yaml
format: bibtex
types:
  article: journal_article      # a BibTeX type -> a bibcite_reference_type
  # ...
fields:
  # <format field>: <bibcite field>
```

The importer uses `types`/`fields` to turn a decoded BibTeX record into a
`bibcite_reference`; the exporter uses them in reverse. To change how a BibTeX type is
imported, edit its entry in this config:

```php
$c = \Drupal::configFactory()->getEditable("bibcite_entity.mapping.bibtex");
$types = $c->get("types"); $types["article"] = "journal_article"; $c->set("types", $types)->save();
```

## What the submodule does *not* add

No configuration UI, no permissions, no routes, no Drush, no plugin types. Import/export UI and
the `access bibcite export` / `bibcite import` permissions come from `bibcite_export` /
`bibcite_import`; citation rendering and the format plugin type come from bibcite core.
