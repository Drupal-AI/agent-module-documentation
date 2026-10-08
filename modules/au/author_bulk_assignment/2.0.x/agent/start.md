<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Author Bulk Assignment (author_bulk_assignment) — agent index

Adds a **Views bulk operation (VBO)** to admin entity listings that reassigns the **author
(owner / `uid`)** of the selected content to a chosen user account. Version **2.0.0**, core
`^10 || ^11`, depends only on core **`views`**. No Drush commands.

## What it actually is (mechanism)

1. **Settings form** (`SettingsForm`, route `author_bulk_assignment.settings` at
   `/admin/config/content/author-bulk-assignment`, gated by permission
   `administer author bulk assignment settings`). It lists every entity type whose definition
   has a `uid` **or** `owner` key and, on save, creates one core **`Action` config entity** per
   selected type (id `<entity_type>_author_bulk_assignment_action`, plugin
   `entity:author_bulk_assignment_action:<entity_type>`). Unselecting a type deletes its Action.
   The selected type ids are stored in `author_bulk_assignment.settings:types`.
2. **Action plugin** `AuthorAssignmentBulkAction` (id `entity:author_bulk_assignment_action`,
   extends core `EntityActionBase`) with a **deriver** `EntityAuthorAssignmentActionDeriver` that
   derives one action per entity type having a `uid`/`owner` key. `execute($entity)` simply calls
   `$entity->setOwnerId($this->assigneeId)->save()`. `access()` returns **allowed iff the current
   user has `assign author to selected content`** — no per-entity check inside the plugin.
   `setAssignee(int $uid)` injects the target owner.
3. **Custom VBO views field** — `hook_views_data_alter()`
   (`author_bulk_assignment.views.inc`) swaps the default `*_bulk_form` views field `id` for
   `author_assignment_node_bulk_form` (nodes, extends `NodeBulkForm`) or
   `author_assignment_entity_bulk_form` (everything else, extends `BulkForm`). Both use
   `AuthorAssignmentBulkFormTrait`, which re-implements `viewsForm()` to add an
   **`assignee_uid` `entity_autocomplete`** ("Assign to", target `user`,
   `include_anonymous => FALSE`, `#validate_reference => FALSE`) shown only when the author-assign
   action is chosen.
4. **Batch** — on submit the trait sets the assignee on the plugin and, per selected entity,
   checks that **the assignee** can `update` the entity; eligible entities are queued to the
   **Batch API** (`AuthorAssignBatch::assignAuthor`) which runs `execute()` per entity.

## Permissions

- `assign author to selected content` — use the reassignment VBO. **Not** `restrict access`.
- `administer author bulk assignment settings` — the settings form.

Neither entity-listing view access nor the VBO is created automatically for arbitrary views;
an admin enables entity types on the settings form, and the bulk field appears on listings that
expose a bulk form for those base tables (e.g. `/admin/content`).

## Config / plugins provided

- Config: `author_bulk_assignment.settings` (`types: sequence`), schema in
  `config/schema/author_bulk_assignment.schema.yml` (`action.configuration.entity:author_bulk_assignment_action:*`).
- Plugins: 1 Action (derived per entity type) + 2 Views field plugins. **No new plugin types.**
- Library `author_bulk_assignment/drupal.author_bulk_assignment.admin` (css/admin.css).

## Things to think about — a bulk write with consequences

1. **"Own content" permissions follow the change.** The new author gains edit/delete rights over
   everything reassigned. That is the point — check it against whose account that is.
2. **The published byline changes.** An editorial/ethical decision, not just data cleanup.
3. **Revisions keep their own author.** Reassignment does not rewrite history; the prior author
   stays in the revision log.

## See also

- `config/settings-form.md` — the settings form and how Action config entities are created/removed.
- `usage.md` — when to reach for it.
