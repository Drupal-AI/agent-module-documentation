# Index sync strategies, cron, drush, synonyms & keymatches

## Sync strategies (`src/Strategy/`, base `src/SyncStrategy.php`)

A "strategy" mutates the ES index settings/mappings for a feature, then triggers a reindex. Extend
`SyncStrategy` (implements `SyncStrategyInterface`) and override `execute(ClientInterface $client, array
$settingsParams = [], array $mappingParams = [])`. The base `execute()` closes the index, applies
`putSettings()`/`putMapping()`, and reopens it in a `finally` (with a 1s sleep); exceptions are logged to
the `elasticsearch_search_api` channel. `getFieldMapping($client, $fields)` fetches current mappings.

| Strategy class | Service id (example) | What it adds to the ES index |
|---|---|---|
| `Strategy\Autosuggest` | `…sync_strategy.autosuggest` | A `search_suggest` `completion` field; makes `title` `copy_to` it. Powers autocomplete. |
| `Strategy\CustomAll` | `…sync_strategy.custom_all` | A `custom_all` `text` field (ngram_analyzer); every supported indexed field `copy_to` it (skips `object`/`nested`). Query one field instead of many. |
| `Strategy\DidYouMean` | `…sync_strategy.did_you_mean` | A `title.trigram` sub-field + a `trigram` (shingle) analyzer. Powers "did you mean". |
| `Strategy\Synonyms` | `…sync_strategy.synonym` | A `synonym_graph` token filter from config `elasticsearch_search_api.synonym_settings:synonyms` (newline groups), and a default whitespace+lowercase+synonym analyzer. Returns early (no-op) if no synonyms configured. |

## SyncService (`src/SyncService.php`, example id `elasticsearch_search_api.sync`)

Constructed with the index, `@elasticsearch_connector.client_manager`, entity type manager, and an ordered
array of strategy services. `sync()` runs each strategy's `execute($client)`, then `reindex()` +
`indexItems()` on the Search API index. Invoked from `hook_cron` (see below) and the drush command.

## hook_cron

`elasticsearch_search_api_cron()` calls `\Drupal::service('elasticsearch_search_api.sync')->sync()`.
NOTE: that service id only exists if you defined it (it lives in `services.yml.example`); enabling only the
bare parent without a `services.yml` will make cron fail to find `elasticsearch_search_api.sync`.

## Drush command (`src/Commands/SearchCommands.php`, drush.services.yml.example)

| Command | Class::method | Behavior |
|---|---|---|
| `reset-search-index-with-ngram-analyzer` | `SearchCommands::resetSearchIndexWithNgramAnalyzer()` | `index->clear()` → `index->reindex()` → `SyncService::sync()` → `index->indexItems()`. |

Wired only via `drush.services.yml.example` (class args: `@…factory.index`, `@…sync`). Not registered
until you copy that file into a real module.

## Synonym config form (`src/Form/SynonymForm.php`)

`ConfigFormBase` (id `synonym_form`) with a single `synonyms` textarea, editing config object
`elasticsearch_search_api.synonym_settings` key `synonyms`. The `Synonyms` strategy consumes it on the next
sync (daily via cron per the form's help text). Route/permission are example-only
(`administer synonyms`). No config schema ships for this object.

## Keymatches (`src/KeymatchService.php`, `src/Form/KeymatchForm.php`)

Keymatches pin curated links to the top of results for matching queries. Entry string format (CSV, one per
line): `query,TYPE,url,title`. `TYPE` is `TERM` (all space-delimited terms occur, case-insensitive),
`PHRASE` (phrase occurs, case-insensitive) or `EXACT` (identical, case-sensitive). `KeymatchService`
(example id `elasticsearch_search_api.keymatch_service`, args config.factory, path.validator,
`@…factory.keymatch_entry`):
- `find($query)` → matching `KeymatchEntry[]` (`getQuery/getUrl/getTitle/getType`).
- `getKeymatchConfiguration()` reads config `elasticsearch_search_api.keymatch:keymatches`.
- `isValid($entry, $strict)` validates 4 CSV parts + known type (+ path validity when strict).

`KeymatchForm` (`ConfigFormBase`, id `elasticsearch_search_api_keymatch_form`) edits config
`elasticsearch_search_api.keymatch`, validating each line. `KeymatchEntryFactory` builds `KeymatchEntry`
value objects. Route/permission (`administer keymatches`) are example-only. No config schema ships.
