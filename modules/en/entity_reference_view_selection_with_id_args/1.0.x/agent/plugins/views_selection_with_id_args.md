<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Selection plugin: `view_selection_with_id_args`

## What it is

`src/Plugin/EntityReferenceSelection/ViewsSelectionWithIdArgs.php` —
class `ViewsSelectionWithIdArgs extends \Drupal\views\Plugin\EntityReferenceSelection\ViewsSelection`.

Plugin annotation (`@EntityReferenceSelection`):
- `id = "view_selection_with_id_args"`
- `label = "Views: Filter by an entity reference view (with current entity ID as argument)"`
- `group = "view_selection_with_id_args"`
- `weight = 0`

It is a drop-in variant of core's `views` selection handler. The only behavioural change: the
**host entity's ID is prepended as the first contextual argument** passed to the referenced View.

## Install / enable

`ddev drush en entity_reference_view_selection_with_id_args -y`. Depends on core `field` and
`views` (`.info.yml`). No config-install objects, no routes, no permissions, no services, no menu.

## How to use

1. On an entity-reference field's storage/settings form (Reference type), choose the handler
   **"Views: Filter by an entity reference view (with current entity ID as argument)"**.
2. Select a View + display of type **Entity Reference** (core requirement — same list as the
   core `views` handler; `Views::getApplicableViews('entity_reference_display')`).
3. The referenced View must define at least one **contextual filter (argument)**; the first one
   receives the host entity's ID. Add more contextual filters to consume the optional static args.

## Overridden methods (vs core `ViewsSelection`)

- `buildConfigurationForm($form, $form_state)` — calls `parent::buildConfigurationForm()` and, when
  `$form['view']['arguments']` exists, rewrites its `#description` to:
  *"Provide a comma separated list of additional arguments to pass to the view. The current entity
  ID will always be the first argument passed to the view."* Pure label change; the field, storage,
  and validation (`ViewsSelection::settingsFormValidate`, which comma-explodes the string into the
  `arguments` array) are inherited unchanged.
- `getDisplayExecutionResults(string $match = NULL, $match_operator = 'CONTAINS', int $limit = 0, array $ids = NULL)`
  — identical to the parent except it sources arguments from `getViewArguments()` instead of the raw
  configured `view.arguments`. Calls `initializeView(...)` then
  `$this->view->executeDisplay($display_name, $arguments)`.
- `getViewArguments(): array` (new) — reads `$this->getConfiguration()['view']['arguments']`, takes
  the host entity from `$this->getConfiguration()['entity']`, and does
  `array_unshift($arguments, $entity->id())`. So final args = `[host_id, ...configured_args]`.

The `entity` key in the handler configuration is the entity currently being edited; core's
entity-reference field API populates it when it instantiates the selection handler. On an entity
that has no ID yet (unsaved), `$entity->id()` is `NULL`, so `NULL` is passed as the first argument.

## What is inherited unchanged from core

- `initializeView()` — loads the View, checks `$this->view->access($display_name)` (the **View's own
  access plugin gates the results**), sets the display and entity-reference options.
- `getReferenceableEntities()` / `validateReferenceableEntities()` / `countReferenceableEntities()` —
  call `getDisplayExecutionResults()`; validation of selected IDs re-runs the same display/arguments.
- `stripAdminAndAnchorTagsFromResults()` — labels are passed through `Xss::filter()` with the admin
  tag list (minus `a`) before display in autocomplete/select widgets.
- `defaultConfiguration()` — `view => [view_name => NULL, display_name => NULL, arguments => []]`.

## Config schema

`config/schema/entity_reference_view_selection_with_id_args.schema.yml` defines
`entity_reference_selection.view_selection_with_id_args` (`type: entity_reference_selection`) with a
`view` mapping: `view_name` (string), `display_name` (string), `arguments` (sequence of strings).
Stored in the field's `handler_settings`; no separate config object.
