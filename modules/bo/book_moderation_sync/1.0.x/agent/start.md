<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Moderation Sync (book_moderation_sync) — agent index

**Propagates a book page's content-moderation state to its direct child pages on save.** Package
*Content Moderation*. Version **1.0.0** (version dir `1.0.x`). Core `^10.3 || ^11`. License
GPL-2.0-or-later. Depends on core **`content_moderation`** and **`book`** (composer requires
`drupal/book:^2.0`).

- **Hook behavior (the sync + the delete option), config, route, service** →
  [api/sync.md](api/sync.md)

## What it actually is

- No entities, no plugins, no fields, no permissions, no Drush. Just two hooks + one settings form.
- One config object: **`book_moderation_sync.settings`** with a single boolean
  `delete_children_on_book_delete` (schema in `config/schema/book_moderation_sync.schema.yml`;
  installed to `0` by `book_moderation_sync_install()`).
- One route: **`book_moderation_sync.settings`** → `/admin/config/content/book-moderation-sync`,
  permission **`administer site configuration`**, form
  `Form\BookModerationSyncSettingsForm` (`ConfigFormBase`). Wired as `configure:` in info.yml.

## Mechanism (from source)

- Service `Drupal\book_moderation_sync\Hook\BookModerationHooks` (`book_moderation_sync.services.yml`)
  is injected with `entity_type.manager`, `content_moderation.moderation_information`,
  `book.outline_storage`, `book.manager`, `logger.factory`.
- `book_moderation_sync.module` implements the legacy hook shims (attribute hooks live on the
  service class):
  - **`hook_node_presave`** → `BookModerationHooks::nodePresave()`: only acts when the node
    `getType() === 'book'`, is a moderated entity, and has an id. Calls
    `syncModerationState($node, $node->get('moderation_state')->value)`.
  - **`hook_entity_predelete`** → in `.module`: if the deleted entity is a `book` node **and**
    `delete_children_on_book_delete` is enabled, calls `deleteBookChildren()`.
- `syncModerationState()` iterates `loadBookChildren()` (which uses
  `book.outline_storage->loadBookChildren(nid)` — **direct children only, one level**) and, for
  each moderated child whose `moderation_state` differs, does
  `$child->set('moderation_state', $state)->save()`.
- `deleteBookChildren()` iterates the same direct children and calls `$child->delete()`.

## Notes / caveats

- Sync is **one level deep per save** (direct children of the saved book node), not the whole
  subtree; deeper pages only follow when their own parent book node is subsequently saved.
- The sync is driven by the parent-node save event; it re-uses the parent's `moderation_state`
  value and writes it onto children. Errors (`EntityStorageException`) and missing-`depth` rows
  are logged on channel `book_moderation_sync`, not surfaced to the user.
- `delete_children_on_book_delete` defaults to **off** (`0`).
