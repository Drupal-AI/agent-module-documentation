<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_note` content entity

Source: `src/Entity/EntityNote.php`, `EntityNoteInterface.php`, `EntityNoteAccessControlHandler.php`,
`EntityNoteViewBuilder.php`, `EntityNoteViewsData.php`, `EntityNotesListBuilder.php`,
`entity_notes.permissions.yml`, `entity_notes.routing.yml`, `entity_notes.install`.

## Definition

`@ContentEntityType(id = "entity_note")` extending `ContentEntityBase`, implementing
`EntityNoteInterface` (which extends `ContentEntityInterface`, `EntityChangedInterface`,
`EntityPublishedInterface`, `EntityOwnerInterface`). Uses `EntityChangedTrait`,
`EntityPublishedTrait`, `StringTranslationTrait`.

- `base_table = entity_note`, `data_table = entity_note_field_data`, `translatable = TRUE`.
- `admin_permission = "administer entity note entities"`.
- `entity_keys`: id=`id`, label=`name`, uuid=`uuid`, uid=`user_id`, langcode=`langcode`,
  published=`status`.
- `field_ui_base_route = entity_note.settings` → extra fields are managed under the settings route
  (Field UI, if enabled).

## Handlers

- `view_builder` = `EntityNoteViewBuilder` — on `build()` it hides the `note` field label
  (`#label_display = 'hidden'`) and sets `user_id` `#access = FALSE` (author never rendered on the
  note view).
- `list_builder` = `EntityNotesListBuilder` — adds a "View" operation only when
  `$entity->access('view')` passes.
- `views_data` = `EntityNoteViewsData` — plain subclass of `EntityViewsData` (no overrides).
- `access` = `EntityNoteAccessControlHandler` (see below).
- forms: `default`/`add`/`edit` = core `ContentEntityForm`, `delete` = core
  `ContentEntityDeleteForm`.
- `route_provider.html` = core `DefaultHtmlRouteProvider` (generates add/canonical/edit/delete
  routes from the `links` template).

## Links

`canonical = /entity-note/{entity_note}`, `add-form = /entity-note/add`,
`edit-form = /entity-note/{entity_note}/edit`, `delete-form = /entity-note/{entity_note}/delete`.
`entity_notes.routing.yml` explicitly declares `entity.entity_note.canonical`
(`_entity_access: entity_note.view`) and `entity.entity_note.edit_form`
(`_entity_access: entity_note.update`); add/delete come from the route provider.

## Fields (`baseFieldDefinitions()`)

- `note` — `text_long`, **required**, revisionable; form widget `text_textfield`
  (rows 10, format `basic_html`); view formatter `text_default`. Getter/setter `getNote()` /
  `setNote()`. (`entity_notes_update_8100()` in `.install` made the storage definition required.)
- `entity_id` — `integer`, the id of the host entity the note is for; not display-configurable.
- `entity_type_id` — `string`, the host entity's type id; not display-configurable.
- `user_id` — `entity_reference` → `user`, "Authored by"; defaulted to the current user in
  `preCreate()`. `EntityOwnerInterface` getters/setters.
- `status` — publish flag (from `publishedBaseFieldDefinitions`).
- `created` / `changed` — timestamps; `getCreatedTime()` / `setCreatedTime()`.

`label()` returns the static string "Entity Note" (the `name` entity key is not populated by the
module's own add-note form).

## Access & permissions

`entity_notes.permissions.yml` declares six permissions:
`add entity note entities`, `administer entity note entities` (`restrict access: true`),
`delete entity note entities`, `edit entity note entities`,
`view published entity note entities`, `view unpublished entity note entities`.

`EntityNoteAccessControlHandler::checkAccess()` maps operations to those permissions:
- `view`: `view unpublished entity note entities` if the note is unpublished, else
  `view published entity note entities`.
- `update`: `edit entity note entities`.
- `delete`: `delete entity note entities`.
- unknown op → `AccessResult::neutral()`.
`checkCreateAccess()` → `add entity note entities`.

These are the note entity's access checks; the note's own canonical/edit/delete routes enforce them
via `_entity_access`.
