<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-entity notes tab (dynamic routes, deriver, form, View)

How a "Entity Notes" tab appears on every canonical page of the entity types you enable, listing that
entity's notes and offering an add-note form.

Source: `src/Routing/EntityNotesRoutes.php`, `src/Plugin/Derivative/EntityNotesLocalTasks.php`,
`src/Form/EntityNoteForm.php`, `config/install/views.view.entity_notes.yml`,
`entity_notes.links.task.yml`, `entity_notes.routing.yml`.

## Dynamic routes — `EntityNotesRoutes::routes()`

Registered via `route_callbacks` in `entity_notes.routing.yml`
(`\Drupal\entity_notes\Routing\EntityNotesRoutes::routes`). It reads
`entity_notes.settings:entity_types`; for each enabled entity type id it:
- loads the entity type definition (a failure is logged to channel `entity_notes` and skipped — e.g.
  the providing module not yet enabled during a config install),
- takes the type's `canonical` link template and adds a route `entity_notes.{entity_type_id}` at
  `"{canonical}/notes"` with defaults `_form = EntityNoteForm`,
  `_title_callback = EntityNoteForm::title`, and requirement
  `_permission: 'add entity note entities'`.

Injected services: `logger.factory`, `entity_type.manager`, `config.factory`.

## Local-task tab — `EntityNotesLocalTasks` deriver

`entity_notes.links.task.yml` declares `entity_notes.local_tasks` with deriver
`EntityNotesLocalTasks`. For each enabled entity type it derives a local task
`entity_note.{entity_type_id}` titled "Entity Notes", `route_name =
entity_notes.{entity_type_id}`, `base_route = entity.{entity_type_id}.canonical`, weight 99 — i.e. a
tab next to View/Edit on that entity. Injects `config.factory`.

Both the routes and the tabs are rebuilt when the settings form saves (it calls
`router.builder->rebuild()` and clears the local-task cache — see config/settings.md).

## The add-note page — `EntityNoteForm` (extends `FormBase`)

- `getEntityFromRouteParameters()` resolves the host entity from the route: it reads the route's
  compiled variable name (the first path variable, e.g. `node`), gets that route parameter, and loads
  the entity via `entity_type.manager`. Result stored on `$this->entity`.
- `title()` → `"{host label} notes"` (translated), used as the page/tab title.
- `buildForm()` builds:
  - a static `<h2>Notes</h2>` heading, then
  - a `#type => 'view'` element rendering View `entity_notes`, display `entity_notes_block`, with
    `#arguments = [entity->id(), entity->getEntityTypeId()]` (the two contextual filters), and
  - the note-entity edit form fields, obtained by creating a transient `EntityNote` seeded with
    `entity_id`/`entity_type_id` from the host entity and calling
    `EntityFormDisplay::collectRenderDisplay($note, 'edit')->buildForm()`; the display is stashed in
    form state as `form_display`.
  - a submit button "Add new note".
- `submitForm()` mirrors `ContentEntityForm::copyFormValuesToEntity()`: it runs
  `$form_display->extractFormValues()` then copies any remaining matching field values onto the note,
  and calls `$this->note->save()`. The note is persisted with the host `entity_id`/`entity_type_id`
  set at build time; author defaults to the current user (`EntityNote::preCreate`).

## The View — `views.view.entity_notes`

Base table `entity_note_field_data`. Two displays:
- **default** (master): table style, pages 10/page, `access: none`, filter `status = 1`, single field
  `note`.
- **entity_notes_block** (block display, used by the form above): fields Date (`changed`), Note
  (`note__value`, `text_default`) and an operations column; `access: perm =
  'view published entity note entities'`; two contextual filters in order — `entity_id` (numeric) then
  `entity_type_id` (string), each `default_action: 'not found'`; empty text "No notes found.".

Do not remove or reorder the contextual filters (`entity_id`, `entity_type_id`); the form passes
`#arguments` positionally.

## Note entity's own routes

Generated/declared for the `entity_note` entity itself: `/entity-note/add`,
`/entity-note/{entity_note}` (canonical, `_entity_access: entity_note.view`),
`/entity-note/{entity_note}/edit` (`_entity_access: entity_note.update`),
`/entity-note/{entity_note}/delete`. See entity/entity-note.md for the access mapping.
