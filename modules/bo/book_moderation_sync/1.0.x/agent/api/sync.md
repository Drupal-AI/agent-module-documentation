<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Moderation Sync — hooks, config, and the sync/delete mechanism

Everything the module does lives in `book_moderation_sync.module` (hook shims) and
`src/Hook/BookModerationHooks.php` (logic), plus one settings form and one config object.

## Install / enable

```
drush en book_moderation_sync -y
```

Requires `content_moderation` and `book` (info.yml `dependencies`), and the contrib **Book 2.x**
package (`composer require drupal/book:^2.0`). `book_moderation_sync_install()` writes
`book_moderation_sync.settings:delete_children_on_book_delete = 0`.
`book_moderation_sync_update_8000()` re-sets the same default; `book_moderation_sync_uninstall()`
deletes the config object.

There is **nothing to do to activate the sync** beyond attaching a Content Moderation workflow to
the `book` content type — the sync only fires for moderated `book` nodes.

## Configuration

- Config object: **`book_moderation_sync.settings`**
  - `delete_children_on_book_delete` (boolean; schema `config/schema/book_moderation_sync.schema.yml`,
    label "Delete children when a book is deleted"). Default `0`.
- Route/form: **`book_moderation_sync.settings`** → `/admin/config/content/book-moderation-sync`,
  `_permission: 'administer site configuration'`, `Form\BookModerationSyncSettingsForm`
  (`ConfigFormBase`, `getEditableConfigNames()` → `['book_moderation_sync.settings']`). A single
  checkbox bound to `delete_children_on_book_delete`.

Config-export example:

```yaml
# book_moderation_sync.settings.yml
delete_children_on_book_delete: false
```

## Service

`book_moderation_sync.services.yml` registers `Drupal\book_moderation_sync\Hook\BookModerationHooks`
(id = the FQCN) with constructor args: `@entity_type.manager`,
`@content_moderation.moderation_information`, `@book.outline_storage`, `@book.manager`,
`@logger.factory` (a `book_moderation_sync` channel is fetched in the constructor).

## Hooks and flow

### `hook_node_presave` → `nodePresave()`

Guards: `$entity->getType() === 'book'` **and** `moderationInformation->isModeratedEntity($entity)`
**and** `$entity->id()` (existing node). When all pass, calls
`syncModerationState($entity, $entity->get('moderation_state')->value)`.

`syncModerationState(NodeInterface $node, $state)`:

- `loadBookChildren($node)` yields the node's **direct** children:
  `book.outline_storage->loadBookChildren($node->id())` returns the outline rows; each row missing
  a `depth` key is skipped with a warning; each remaining child id is loaded via the node storage.
- For each yielded child that is a moderated entity **and** whose current `moderation_state` differs
  from `$state`: `$child->set('moderation_state', $state)` then `$child->save()`. A save that throws
  `EntityStorageException` is caught and logged as an error (`@nid`, `@message`).

### `hook_entity_predelete` (in `.module`)

If the deleted entity is a `NodeInterface` of type `book` and `delete_children_on_book_delete` is
truthy, resolves the service and calls `deleteBookChildren($entity)`, which iterates the same
`loadBookChildren()` set and `$child->delete()`s each, logging any `EntityStorageException`.

### `hook_help`

`help.page.book_moderation_sync` returns a one-line description.

## Operational notes

- **Depth of propagation:** `loadBookChildren()` is one level (direct children of the saved node).
  A change at the top of a deep book reaches grandchildren only when the intermediate pages are
  themselves saved. There is no recursion and no queue.
- **Trigger:** the sync rides the parent book node's own save (presave), so it runs inside that
  save's request/transaction.
- **Logging:** channel `book_moderation_sync` — warnings for outline rows lacking `depth`, errors
  for failed child save/delete. Nothing is shown to the editor.
- **Idempotence:** children already at the target state are skipped (the `!== $state` check).
