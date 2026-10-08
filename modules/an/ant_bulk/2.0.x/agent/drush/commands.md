# Drush commands

Class `Drupal\ant_bulk\Drush\Commands\AntBulkCommands` (Drush 11+ attribute-style, injects
`ant_bulk.manager`). Added in the 1.x rc2 release.

| Command | Alias | Arguments | Options |
|---|---|---|---|
| `ant_bulk:translate` | `anttrans` | `type` — content-type machine name; `language` — target langcode | `--overwrite` (default off — skip nodes already translated in `language`); `--size` (total node cap; all when 0/omitted) |

## Behavior

`translate($type, $language, $options)`:
1. `TranslationManager::getNodes([$type], $options['size'], $options['overwrite'], [$language => 1])`
   — builds the nid list (same logic as the UI, but `status` defaults to `FALSE`, so **unpublished
   nodes are included** regardless of the `ant_bulk.settings` `status` config).
2. Queues one batch op `[TranslationManager, 'translateBatchSet']` with an **empty** workflows array
   (no content-moderation state is applied on the CLI path).
3. `batch_set()` + `drush_backend_batch_process()` runs it; each node goes through
   `auto_node_translate.translator` `Translator::translateNode()`.

The CLI path does **not** invoke `hook_ant_bulk_translation_items_alter()` (only the UI form does).

## Examples

```bash
# Translate all "article" nodes into French (skips already-translated, all nodes).
drush ant_bulk:translate article fr

# Re-translate the 100 newest articles into French, overwriting existing translations.
drush anttrans article fr --overwrite=1 --size=100
```

Only one content type and one language per invocation; run repeatedly for more.
