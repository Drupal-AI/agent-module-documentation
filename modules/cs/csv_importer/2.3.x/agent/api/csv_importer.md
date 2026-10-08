# Programmatic API

## Services (`csv_importer.services.yml`)

- **`csv_importer.parser`** → `Drupal\csv_importer\Parser` (implements `ParserInterface`).
  - `getCsvById(int $id, string $delimiter = ','): array` — load a **managed file** entity by
    fid and return it as an array of rows (each row an array of cells).
  - `getCsvFieldsById(int $id): ?array` — the header row (row 0) of that CSV.
  - `getCsvEntity(int $id): ?\Drupal\file\Entity\File` — load the file entity.
- **`plugin.manager.importer`** → `Drupal\csv_importer\Plugin\ImporterManager`
  (a `DefaultPluginManager`; alter hook `importer_info`, discovers `Plugin/Importer`).

## The `importer` plugin type

- Interface: `Drupal\csv_importer\Plugin\ImporterInterface` (methods `data()`, `add()`,
  `finished()`, `process()`; const `REGEX_MULTIPLE`).
- Base class: `Drupal\csv_importer\Plugin\ImporterBase` (contains all import logic).
- Attribute: `Drupal\csv_importer\Attribute\Importer` (id, label, description, deriver);
  legacy annotation `@Importer` also supported.
- The module ships **one** plugin, `Plugin/Importer/Importer` (id `importer`), whose
  `ImporterDeriver` creates a derivative **for every content entity type**, giving plugin IDs
  like `importer:node`, `importer:user`, `importer:taxonomy_term`. Each derivative definition
  carries an `entity_type` key.

## Running an import in code

Mirror what `ImporterForm::submitForm()` does — build parsed rows, create the derived plugin,
call `process()` (which sets up a Batch):

```php
$parser  = \Drupal::service('csv_importer.parser');
$manager = \Drupal::service('plugin.manager.importer');

$fid  = 123;                 // fid of an uploaded managed CSV file
$rows = $parser->getCsvById($fid, ',');

$manager->createInstance('importer:node', [
  'csv'                => $rows,                      // rows incl. header row 0
  'csv_entity'         => $parser->getCsvEntity($fid),// used for history logging
  'entity_type'        => 'node',
  'entity_type_bundle' => 'article',                 // NULL for bundleless types
  'fields'             => ['title', 'body', 'field_tags'], // fields to keep
])->process();
```

`process()` calls `data()` (which normalizes rows, applies the `field|prop` and
`values()/multiple()` syntax, and invokes `hook_csv_importer_pre_import`) then batches `add()`
over the content, creating or updating entities and finally logging to `csv_importer_history`
in `finished()`.

## Extending

Write your own importer by subclassing `ImporterBase` in `src/Plugin/Importer/` with an
`#[Importer(id: '…', deriver: …)]` attribute, or override the shipped one via the
`importer_info` alter hook (see hooks doc). The base constructor is `final`; add behavior by
overriding `data()` / `add()` / `attach()`.
