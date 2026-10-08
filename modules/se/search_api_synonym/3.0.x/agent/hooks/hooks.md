# Search API Synonym — hooks

Source: `search_api_synonym.api.php`.

## `hook_search_api_synonym_synonyms_file_saved($file_path)`
Called after a synonyms file has been (re)written by an export — from
`ExportPluginManager::executeExport()`. Use it to push the file to a search backend, clear a cache,
or trigger a reindex.

```php
function mymodule_search_api_synonym_synonyms_file_saved($file_path) {
  // e.g. copy $file_path into the Solr conf dir and reload the core.
  \Drupal::logger('mymodule')->info('Synonyms written to @p', ['@p' => $file_path]);
}
```
