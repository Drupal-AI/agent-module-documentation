# The Resave form

`\Drupal\resave_all_nodes\Form\ResaveAllNodesForm` (form id `resave_all_nodes_form`).
Route `resave_all_nodes.form` → path `/admin/config/development/resave-all-nodes`,
requires `_permission: 'resave all nodes'`. Reached from the admin menu link
`resave_all_nodes.toolbar_menu` under Configuration ▸ Development.

This is a **trigger** form, not a settings form: it saves no config object and has no
config schema. Submitting it queues a Batch API run and returns; nothing is persisted.

## Form fields

| Field | `#type` | Purpose | Default |
|---|---|---|---|
| `node_types` | `checkboxes` | Content types to resave. Options are every `node_type` entity (`id => label`). **If none are checked, all types are resaved.** | none checked |
| `available_node_types` | `hidden` | Full `id => label` map, used as the fall-back list when no checkbox is ticked. | all types |
| `chunk_size` | `number` | Nodes processed per batch operation. | 250 (also used if left empty) |
| `submit` | `submit` | Button labelled "Resave now". | — |

`validateForm()` is empty (no validation). `submitForm()` computes the target type list —
`array_filter` of the checked boxes, else `array_keys` of `available_node_types` — and the
chunk size, then calls `setBatch()`.

## What happens at runtime

1. `getNodeIds(array $node_types)` runs an entity query on `node` storage with
   `->accessCheck(TRUE)` and `->condition('type', $node_types, 'IN')` — so the form only
   picks up nodes the current user may access.
2. `setBatch()` chunks the NIDs with `array_chunk(..., $chunk_size, TRUE)` and builds one
   Batch API operation per chunk, all pointing at
   `\Drupal\resave_all_nodes\Batch\ResaveAllNodesBatch::batchOperation`, with
   `finished` = `ResaveAllNodesBatch::batchFinished`. `batch_set($batch)` schedules it.
3. `batchOperation($chunk, &$context)` does `Node::loadMultiple($chunk)`, then for each node
   `$node->save()`; if the node `isTranslatable()`, it also `->save()`s every **non-default**
   translation (`getTranslationLanguages(FALSE)`). Each saved id is appended to
   `$context['results']`.
4. `batchFinished($success, $results, $operations)` adds the message
   "Resaved N nodes." via `\Drupal::messenger()`, or an error message naming the
   unprocessed operation on failure.

Because every save re-fires presave/update hooks, expect side effects: Pathauto alias
regeneration, Search API / queue re-population, `changed` timestamp updates, a new revision
per node where the type creates revisions by default, and any entity-update event
subscribers firing. On a large site this is slow — the Drush command
([drush/commands.md](../drush/commands.md)) is the better trigger there.

## No programmatic config

There is nothing to set via `drush cset` / `Config` — the module stores no settings. To run
it non-interactively use the Drush command instead of the form.
