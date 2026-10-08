<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The EndNote format

## `bibcite_format` plugin(s)

Declared in `bibcite_endnote.bibcite_format.yml` (YAML plugin discovery). Plugin id(s): **endnote7, endnote8, tagged**.
Each definition includes `id`, `label`, `extension` (xml/enw), `encoder`
(`\Drupal\bibcite_endnote\Encoder\EndnoteEncoder`), optional `normalizer`, and `types` / `fields` lists (the EndNote record types
and field names this format understands).

Because `EndnoteEncoder` implements both Symfony `EncoderInterface` and `DecoderInterface`, the
format is available for **import** (`getImportDefinitions()`) and **export**
(`getExportDefinitions()`).

Inspect live:

```bash
drush php:eval '$p = \Drupal::service("plugin.manager.bibcite_format")->createInstance("endnote7");
print $p->getExtension()." import=".(int) $p->isImportFormat()." export=".(int) $p->isExportFormat();'
```

## Type/field mapping — `bibcite_entity.mapping.endnote7`

A config object mapping EndNote record types and fields to Bibcite reference types and
`bibcite_*` fields. Shape:

```yaml
format: endnote7
types:
  Book: book      # a EndNote type -> a bibcite_reference_type
  # ...
fields:
  # <format field>: <bibcite field>
```

The importer uses `types`/`fields` to turn a decoded EndNote record into a
`bibcite_reference`; the exporter uses them in reverse. To change how a EndNote type is
imported, edit its entry in this config:

```php
$c = \Drupal::configFactory()->getEditable("bibcite_entity.mapping.endnote7");
$types = $c->get("types"); $types["Book"] = "book"; $c->set("types", $types)->save();
```

## What the submodule does *not* add

No configuration UI, no permissions, no routes, no Drush, no plugin types. Import/export UI and
the `access bibcite export` / `bibcite import` permissions come from `bibcite_export` /
`bibcite_import`; citation rendering and the format plugin type come from bibcite core.
