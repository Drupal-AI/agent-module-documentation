<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins: actions, Views field/filter handlers, local task

All in `src/Plugin/`. Every plugin is **derived per generic entity type** — a base definition plus a
deriver that emits one instance for each applicable `entity_generic`-marked type.

## Action plugins (`src/Plugin/Action/`)

12 bulk actions (usable from Views Bulk Operations / admin listings), each an `@Action` extending core
`EntityActionBase` with a deriver in `src/Plugin/Action/Derivative/`:

| Action class | id | sets | applicable when type has key |
|---|---|---|---|
| `EnableAction` / `DisableAction` | `entity:enable_action` / `entity:disable_action` | `setStatus(ENABLED/DISABLED)` | `status` |
| `ApproveAction` / `UnapproveAction` | `entity:approve_action` / `entity:unapprove_action` | `setApproved(…)` | `approved` |
| `ArchiveAction` / `UnarchiveAction` | `entity:archive_action` / `entity:unarchive_action` | `setArchived(…)` | `archived` |
| `MarkDeletedAction` / `UnmarkDeletedAction` | `entity:mark_deleted_action` / … | `setDeleted(…)` | `flag_deleted` |

- **Deriver pattern** (`ApproveActionDeriver`, etc., extending core `EntityActionDeriverBase`):
  `isApplicable()` returns `$entity_type->hasKey('<flag>')`; `getDerivativeDefinitions()` emits one
  action per applicable type with a per-type label.
- **Access**: each `execute()` sets the flag via the lifecycle trait and `save()`s; each `access()`
  requires `$entity->access('update')`. `EnableAction`/`DisableAction` additionally `andIf()` the
  `status` field's `edit` access. No action grants access on its own.

## Views field handlers (`src/Plugin/views/field/`)

- `GenericOperationModalBase` — abstract base for modal-operation link fields.
- `GenericEditModal` (`@ViewsField("entity_generic_link_edit_modal")`) — renders a link to
  `entity.<type>.edit_modal_form`; has a **Form mode** option (from
  `entity_display.repository` form modes); default label "edit".
- `GenericDeleteModal` (`entity_generic_link_delete_modal`) — link to `delete_modal_form`.
- `GenericToggleStatusModal` (`entity_generic_toggle_status_modal`) — link to the status-toggle modal.

These fields are registered in Views by `GenericViewsData::addEntityLinks()` (see
[../handlers.md](../handlers.md)) and only appear when the entity type declares the matching modal
link template.

## Views filter handlers (`src/Plugin/views/filter/`)

- `IdAutocomplete` (`@ViewsFilter("entity_generic_id_autocomplete")`) — extends core `InOperator`;
  exposes an `entity_autocomplete` (tags) widget targeting the entity type; validates selected values
  down to a sorted list of target ids and filters on the entity ID.
- `IdSelect` (`@ViewsFilter("entity_generic_id_select")`) — same idea with a select widget.

Both are wired by `GenericViewsData::getViewsData()` as `{id}_autocomplete` / `{id}_select` filters.

## Local task (`src/Plugin/LocalTask/Derivative/`)

- `LocalTaskDeriver` — driven by `entity_generic.links.task.yml` (base plugin `entity_generic.entities`,
  weight 100). Iterates `entity_generic_types()` and emits **View / Edit / Delete** local tabs
  (weights 0 / 10 / 200) for each type that has the corresponding `canonical` / `edit-form` /
  `delete-form` link template, all under the canonical base route.
