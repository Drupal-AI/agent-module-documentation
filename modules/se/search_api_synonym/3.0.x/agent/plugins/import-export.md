# Search API Synonym — import & export plugins

Two plugin types. Both use annotation discovery under `src/Plugin/search_api_synonym/{import,export}/`.

## Import plugins
- Annotation: `@SearchApiSynonymImport` (`src/Annotation/SearchApiSynonymImport.php`) — `id`, `label`,
  `description`.
- Manager: `plugin.manager.search_api_synonym.import` (`ImportPluginManager`).
- Base: `Drupal\search_api_synonym\Import\ImportPluginBase` (interface `ImportPluginInterface`).
- Built-in: `csv`, `json`, `solr` (`src/Plugin/search_api_synonym/import/`).

Implement:
```php
public function parseFile(\Drupal\file\Entity\File $file, array $settings = []); // return rows: [['word'=>, 'synonym'=>, 'type'=>], ...]
public function allowedExtensions();                    // e.g. ['csv'] — used to validate the upload
public function buildConfigurationForm(array $form, FormStateInterface $form_state);  // optional plugin options
public function validateConfigurationForm(array &$form, FormStateInterface $form_state);
```
The import form (`src/Form/SynonymImportForm.php`) validates the uploaded file against the active
plugin's `allowedExtensions()` (`file_save_upload` + `file_validate_extensions`), runs `parseFile()`,
and saves the rows as `search_api_synonym` entities. CSV parsing reads `word,synonym,type` columns
(see `import/Csv.php`).

## Export plugins
- Annotation: `@SearchApiSynonymExport` (`src/Annotation/SearchApiSynonymExport.php`).
- Manager: `plugin.manager.search_api_synonym.export` (`ExportPluginManager`) — key methods
  `setPluginId()`, `setExportOptions()`, `validatePlugin()`, `getAvailableExportPlugins()`,
  `executeExport()`.
- Base: `Drupal\search_api_synonym\Export\ExportPluginBase` (interface `ExportPluginInterface`).
- Built-in: `solr` (`src/Plugin/search_api_synonym/export/Solr.php`).

Implement:
```php
public function getFormattedSynonyms(array $synonyms);  // return the serialized file contents for the backend
```
`ExportPluginManager::executeExport()` gathers synonyms per the current options, calls
`getFormattedSynonyms()`, writes the file to the configured `file_export_location`, and fires
`hook_search_api_synonym_synonyms_file_saved($file_path)`.

Example directory (shipped): `examples/example.csv`, `examples/example.json`,
`examples/solr_synonyms.txt`.
