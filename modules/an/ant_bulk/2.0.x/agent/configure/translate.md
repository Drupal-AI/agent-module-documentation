# Bulk translate form

Route `ant_bulk.translate` → `/ant-bulk/translate`, form `Drupal\ant_bulk\Form\TranslateForm`
(id `ant_bulk_translate`), permission `use bulk auto translate`, `_admin_route: TRUE`. Also linked
as "Auto bulk translations" under Configuration → Regional and language (`system.admin_config_regional`).

This form selects target languages + content types, builds the node list, and dispatches a Batch
that runs `auto_node_translate`'s translator over each node.

## Form fields

| Field | Type | Notes |
|---|---|---|
| `translate[<langcode>]` | checkbox per language | All site languages **except the default** language. At least one required. |
| `bundles[<type>]` | checkbox per content type | Only node types with **content translation enabled** (`ContentTranslationManager::isEnabled('node', $type)`) are listed. Each shows "Total nodes" and per-language "Translated total". At least one required. |
| `workflow[<workflow_id>][state]` | radios | Shown only when `content_moderation` is installed. Picks the moderation state applied to the new translations, per content-moderation workflow. Default is the workflow's first state. |
| `batch_size` | number (min 0) | **Caps the total number of nodes processed** this run (newest nid first). Empty/0 = all matching nodes. This is a total cap, not the per-step chunk size (the batch always processes 1 node per step). |
| `overwrite` | checkbox | When off, nodes that already have a translation in the selected language(s) are skipped. When on, existing translations are re-translated. |

Validation (`validateForm`): at least one content type and at least one language must be selected.

## What happens at runtime

1. `submitForm` reads `status` from config `ant_bulk.settings` (see [settings.md](settings.md)).
2. `TranslationManager::getNodes($bundles, $batch_size, $overwrite, $languages, $status)` builds the nid list:
   - `getDefaultNodes()` — entity query `type IN (bundles)`, sorted `nid DESC`, `accessCheck(FALSE)`; adds `status = 1` when the `status` config is on.
   - When `overwrite` is off, nids already present in the target languages (`getTranslatedNodes()`) are filtered out.
   - When `batch_size` is set, the list is sliced to the first N.
3. `hook_ant_bulk_translation_items_alter(&$nodes)` is invoked so other modules can drop nids (see [../hooks/alter.md](../hooks/alter.md)).
4. A single batch operation `[TranslationManager, 'translateBatchSet']` is queued with the nid list, the raw
   `translate` checkbox array, and the `workflow` values; `batch_set()` starts it.
5. Per node, `translateBatch()` loads the node, calls `auto_node_translate.translator`
   `Translator::translateNode($node, $translations)`, and — if the node is moderated and a workflow state was
   chosen — sets each translation's `moderation_state`, creates a revision, and publishes/unpublishes per the
   selected state.
6. `translateFinished()` reports `"<count> elements processed."` via the messenger.

## Notes

- The actual translation provider, credentials and field mapping all live in `auto_node_translate` — this module
  only orchestrates which nodes and languages are sent through it.
- "Total nodes" / "Translated total" counts on the form honor the `status` config the same way the run does.
