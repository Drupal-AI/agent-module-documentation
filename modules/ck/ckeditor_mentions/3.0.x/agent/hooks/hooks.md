# Hooks

## Implemented by this module (`ckeditor_mentions.module`, `.install`)
| Hook | What it does |
|---|---|
| `hook_entity_insert` | Dispatches `CKEditorEvents::MENTION_FIRST` for each mention in the new entity's text fields |
| `hook_entity_update` | Dispatches `CKEditorEvents::MENTION_SUBSEQUENT` for each mention in the updated entity |
| `hook_help` | Help page text linking to the text-formats admin page |
| `hook_install` | Creates image style `mentions_icon` (image_scale_and_crop 40×40) for user-mention avatars |
| `hook_uninstall` | Deletes the `image.style.mentions_icon` config |

`hook_update_last_removed()` returns `8003`; updates `10001`–`10004` rebuild the container and
normalise/backfill `ckeditor_mentions_mentions` plugin settings (10004 sets `useRewrittenUrl = TRUE`
for existing installs as a BC default).

## Alter hooks provided for integrators (`ckeditor_mentions.api.php`)
| Hook | Signature | Use |
|---|---|---|
| `hook_ckeditor_mentions_build_token_alter` | `(array &$token, EntityInterface $entity)` | Alter one suggestion's token array (`entity_type`, `entity_id`, `entity_uuid`, `label`, `search_label`, `mention_uuid`, `url`, …) before it is added to results — e.g. append the bundle to a node's `label`. |
| `hook_ckeditor_mentions_build_tokens_alter` | `(array &$tokens)` | Alter the whole suggestion list (keyed by entity id) — e.g. unset an id to hide it. |

Both are invoked from `MentionsTypeBase::buildTokens()`.

## Plugin-info alter
`hook_mentions_type_plugin_info_alter(&$definitions)` — alter discovered `@MentionsType` plugin
definitions (registered via `MentionsTypeManager::alterInfo('mentions_type_plugin_info')`).

## Query tags
Each mentions-type query is tagged `ckeditor_mentions_{plugin_id}` (e.g. `ckeditor_mentions_user`,
`ckeditor_mentions_node`) with the plugin available via `$query->getMetaData('plugin')`, so you can
alter the candidate query with `hook_query_ckeditor_mentions_{plugin_id}_alter(AlterableInterface $query)`.

## Submodule: `ckeditor_mentions_entity`
Implements `hook_entity_insert` / `hook_entity_update` / `hook_entity_delete` to create and clean up
`mention` content entities (fields: `parent` and `target` dynamic_entity_reference, `uid` owner,
`created`) from the mentions found in a saved entity's fields — a persisted record of every mention.
Requires `dynamic_entity_reference`.
