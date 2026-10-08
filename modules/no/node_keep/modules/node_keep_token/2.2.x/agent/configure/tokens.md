# Machine name field & node-keep tokens

## The `keeper_machine_name` field

`node_keep_token_entity_base_field_info()` adds a `keeper_machine_name` string base field to all
nodes. In the node form it sits in the "Node keep" section and is only shown (via `#states`) when
the `node_keeper` checkbox is ticked. On submit `node_keep_token_validate()`:

- rejects any character outside `[a-z0-9_]` ("can only contain letters, numbers and underscore"),
- requires uniqueness across protected nodes (via `NodeKeepTokenService::isMachineNameUsed()`).

Changing it requires the `administer node_keep_token per node` permission (otherwise the field is
`#disabled`).

Set it in code:

```php
$node->set('node_keeper', TRUE);            // must be protected to expose tokens
$node->set('keeper_machine_name', 'home');
$node->save();
```

## Tokens

Token type: **`node-keep`**. For every protected node (`node_keeper = 1`) that has a machine name,
these tokens are registered and replaced live (`node_keep_token_token_info()` / `_tokens()`):

| Token | Resolves to |
|---|---|
| `[node-keep:<machine_name>:alias]` | the node's path alias (via `path_alias.manager`) |
| `[node-keep:<machine_name>:id]` | the node id (nid) |
| `[node-keep:<machine_name>:url]` | the canonical URL path (`entity.node.canonical`) |
| `[node-keep:<machine_name>:uri]` | the internal uri, e.g. `node/34` |

Example — resolve a token in code:

```php
$out = \Drupal::token()->replace('[node-keep:home:url]');
```

Replacement is driven by `getProtectedMachineNames()` (live query), so a token resolves as soon as
the node is protected and named — no cache clear needed for replacement. (The token *info* list
shown in UI token browsers is built from the same data and may be cached.)
