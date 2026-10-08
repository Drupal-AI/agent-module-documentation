<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

Choose which entity types get notes. Source: `src/Form/EntityNotesConfigForm.php`,
`entity_notes.routing.yml`, `entity_notes.links.menu.yml`,
`config/install/entity_notes.settings.yml`, `config/schema/entity_notes.settings.schema.yml`.

## Route & menu

- Route `entity_note.settings` → path `/admin/structure/entity_note/settings`, `_form =
  EntityNotesConfigForm`, title "Entity Notes", requirement `_permission: 'access administration
  pages'`, `_admin_route: TRUE`. This is also the entity's `field_ui_base_route` and the
  `data.json` `configure` route.
- Menu link `entity_note.admin.structure.settings` under `system.admin_structure`
  (Administration → Structure → Entity Notes).
- Settings task tab `entity_note.settings_tab` (from `entity_notes.links.task.yml`).

## Form — `EntityNotesConfigForm` (extends `ConfigFormBase`)

- `getFormId()` = `entity_notes_config_form`; editable config = `entity_notes.settings`.
- Injected: `config.factory`, `router.builder`, `plugin.manager.menu.local_task`,
  `entity_type.manager`.
- `buildForm()`: a `checkboxes` element `entity_types` whose `#options` are every entity type id →
  label from `entity_type.manager->getDefinitions()` (ksorted), defaulted from
  `entity_notes.settings:entity_types`. (Note: it lists *all* entity types, including config entity
  types; only content entity types with a canonical link produce a usable notes tab.)
- `submitForm()`: saves `entity_types` as `array_values(array_filter($values))` to
  `entity_notes.settings`, then calls `routeBuilder->rebuild()` and
  `localTaskManager->clearCachedDefinitions()` so the dynamic `{entity}/notes` routes and tabs are
  regenerated immediately.

## Config object & schema

- `config/install/entity_notes.settings.yml`: `entity_types: {}` (empty by default — no notes tabs
  until you enable a type).
- `config/schema/entity_notes.settings.schema.yml`: `entity_notes.settings` is a `config_object`
  with mapping `entity_types` = `sequence` of `string`.

## Operating it

1. `composer require drupal/entity_notes` and `drush en entity_notes -y` (pulls in `views`).
2. Visit `/admin/structure/entity_note/settings`, tick the entity types that should have notes, save.
3. Grant the relevant permissions (see entity/entity-note.md) on People → Permissions.
4. Each enabled entity type now shows an "Entity Notes" tab on its canonical pages
   (`{entity}/notes`). See ui/per-entity-notes.md.
