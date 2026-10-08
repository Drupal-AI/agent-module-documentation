<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_log_entry` content entity (entity_logger)

Source: `src/Entity/EntityLogEntry.php` (+ interface), `src/EntityLogEntryStorage.php`,
`src/EntityLogEntryAccessControlHandler.php`, `src/EntityLogEntryViewBuilder.php`,
`src/EntityLogEntryListBuilder.php`, `src/EntityLogEntryViewsData.php`,
`src/Form/EntityLogEntryForm.php`, `src/Routing/RouteSubscriber.php`,
`src/Controller/EntityLoggerController.php`, `src/Plugin/**`, `config/install/views.view.entity_logger.yml`.

## Entity definition

`@ContentEntityType(id = "entity_log_entry")`, `base_table = "entity_logger"`, `internal = TRUE`,
`admin_permission = "administer entity log entries"`. Handlers: `access` =
`EntityLogEntryAccessControlHandler`; forms add/edit = `EntityLogEntryForm`, delete =
core `ContentEntityDeleteForm`; `storage` = `EntityLogEntryStorage`; `view_builder` =
`EntityLogEntryViewBuilder`; `list_builder` = `EntityLogEntryListBuilder`; `views_data` =
`EntityLogEntryViewsData`; route provider = core `AdminHtmlRouteProvider`.

Links: `add-form` `/entity_logger/{entity_type}/{entity}/add`, `edit-form`
`/entity_logger/{entity_log_entry}/edit`, `delete-form` `/entity_logger/{entity_log_entry}/delete`,
`collection` `/admin/structure/entity_logger`. `field_ui_base_route =
entity.entity_log_entry.collection`.

### Base fields (`baseFieldDefinitions()`)

- `target_entity` — **dynamic_entity_reference** (the logged entity). Accessors
  `getTargetEntity()` / `setTargetEntity()`.
- `severity` — integer (tiny, unsigned); an RFC log level. Form widget is turned into a select of
  `RfcLogLevel::getLevels()` by `EntityLogEntryForm::form()`.
- `message` — `string_long` (the log message; form widget `string_textarea`).
- `context` — `map` (serialized PSR-3 context array).
- `created` — created timestamp.
- `uid` / owner — via `EntityOwnerTrait`; `preCreate()` defaults `uid` to the current user.

`label()` returns "Log #<id> for entity <target label>".

## Storage

`EntityLogEntryStorage extends SqlContentEntityStorage`. Adds
`deleteForTargetEntity(EntityInterface $target)` — queries entries whose
`target_entity.target_type` / `target_entity.target_id` match and deletes them
(with `accessCheck(FALSE)`, internal maintenance). Called from
`EntityHooks::entityPreDelete()` so an entity's logs are removed when the entity is deleted.

## Access handler

`EntityLogEntryAccessControlHandler::checkAccess()` maps operations to permissions:
`view` → `view entity log entries`, `update` → `edit entity log entries`, `delete` →
`delete entity log entries`; unknown ops → neutral. `checkCreateAccess()` → `add entity log entries`.

## Rendering

`EntityLogEntryViewBuilder::viewMultiple()` renders each entry from the stored message with its
context (PSR-3 placeholders resolved). `EntityLogEntryListBuilder` renders the
admin collection rows (ID, message via the view builder, severity label from `RfcLogLevel::getLevels()`,
created date).

## Per-entity Log page

- `EntityHooks::entityTypeAlter()` adds the `entity-logger` link template
  (`/entity_logger/<type>/{<type>}`) to each **enabled** entity type.
- `RouteSubscriber::alterRoutes()` creates `entity.<type>.entity_logger` for every type that has that
  link template, pointing at `EntityLoggerController::log()` / `::pageTitle()`, requirement
  `_permission: view entity log entries`, `_admin_route`, and an `_entity_logger_entity_type_id`
  option used by the controller to resolve the entity from the route.
- `EntityLoggerController::log()` embeds the `entity_logger` view, display `embed_entity_log`, with the
  target entity's type id + id as arguments.
- Local task "Log" is derived per entity type by `Plugin/Derivative/EntityLoggerLocalTask`; the "Add
  log entry" local action by `Plugin/Derivative/EntityLoggerLocalAction` +
  `Plugin/Menu/LocalAction/EntityLogEntryAddLocalAction`. `EntityHooks::entityOperation()` also adds a
  "Log" operation link on entity listings (gated by `view entity log entries`).

## Views integration

Config view `entity_logger` (base table `entity_logger`, base field `id`) ships a `default` (table) and
`embed_entity_log` (embed) display, access `perm: view entity log entries`, contextual filters on
`target_entity__target_type` and `target_entity__target_id`. `EntityLogEntryViewsData` adds the
`entity_log_entry_severity_label` field and an `in_operator` severity filter using
`RfcLogLevel::getLevels()`. The Views field plugin `SeverityLabel`
(`@ViewsField("entity_log_entry_severity_label")`) renders the numeric severity as its label.
