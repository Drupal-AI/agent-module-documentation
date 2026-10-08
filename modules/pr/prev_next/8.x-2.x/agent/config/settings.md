<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & indexing

## Install / enable
`drush en prev_next -y`. Requires core **block**. `hook_schema()` (`prev_next.install`) creates table
`prev_next_node`. `config/optional/prev_next.settings.yml` seeds `batch_size: 200`.

## Settings form
- **Route**: `prev_next.config_form` → `/admin/config/system/prev-next` (menu link
  `prev_next.links.menu.yml`, under *Configuration › System*).
- **Permission**: `administer prev next` (`prev_next.permissions.yml`).
- **Form class**: `Drupal\prev_next\Form\PrevNextConfigForm` (`getEditableConfigNames()` =
  `prev_next.settings`).

### Global setting
- `batch_size` (in `prev_next.settings`) — number of nodes to index per cron run. Default 200; lower
  it on shared/low-memory hosts.

### Per content type (config object `prev_next.node_type.<bundle>`)
The form iterates `NodeType::loadMultiple()` and edits one config object per bundle. Fields (schema in
`config/schema/prev_next.schema.yml`, mapping `prev_next.node_type.*`):
- `include` (bool) — include this type in indexing. Form note: *"If none of them is included, then all
  of them will be."*
- `indexing_criteria` (string) — ordering key; select options are exactly `nid` (Node ID),
  `created` (Post date), `changed` (Updated date), `title` (Title).
- `same_type` (bool) — restrict neighbours to the same content type. When off, neighbours may be any
  included type.
- `current`, `indexing_criteria_current`, `same_type_current` — hidden "previous value" mirrors used to
  detect a changed setting (changing any indexing option is meant to reset/rebuild the index).

Which bundles are "indexed" is derived by `PrevNextHelper::getBundleNames()` from the list of existing
`prev_next.node_type.*` config keys; `loadBundle($bundle)` returns the immutable config for one type.

## Populating the index
- **New/edited/deleted nodes**: maintained automatically — `prev_next.module` implements
  `hook_entity_insert`, `hook_entity_update`, `hook_entity_delete`, each calling `prev_next.api`
  (`add` / `update` / `remove`) only when the node's bundle is in `getBundleNames()`.
- **Pre-existing nodes**: not indexed until touched. Either **bulk-save** them (Content admin →
  *Save content* action) or let the backwards cron indexing run over successive cron passes
  (`batch_size` per run).
- **Re-index**: the project provides a re-index action from the settings page after criteria changes;
  bulk-saving content re-triggers `add()` for each node.

Only **published** nodes (`status = 1`) are ever stored as a neighbour, so unpublished nodes never
appear as a prev/next target.
