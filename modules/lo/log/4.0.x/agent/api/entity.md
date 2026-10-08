<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Log entity

`Drupal\log\Entity\Log` (`#[ContentEntityType(id: 'log')]`), extends
`entity` module's `RevisionableContentEntityBase`; implements
`Drupal\log\Entity\LogInterface` and uses `EntityChangedTrait`, `EntityOwnerTrait`,
`RevisionLogEntityTrait`. Revisionable, translatable, owned, with revision UI on.

- Entity keys: `id`, revision `revision_id`, bundle `type`, label `name`, owner `uid`, `uuid`, `langcode`.
- Tables: base `log`, data `log_field_data`, revision `log_revision`, revision data `log_field_revision`.
- Bundle entity: `log_type` (see [../configure/log-types.md](../configure/log-types.md)).
- Handlers: storage `LogStorage`, access `UncacheableEntityAccessControlHandler`,
  permission_provider `UncacheableEntityPermissionProvider`, query_access
  `UncacheableQueryAccessHandler`, list_builder `LogListBuilder`, views_data `LogViewsData`,
  view_builder core `EntityViewBuilder`. Route providers: `AdminHtmlRouteProvider` +
  `RevisionHtmlRouteProvider`. Forms: add/edit `LogForm`, delete `ContentEntityDeleteForm`,
  delete-multiple `DeleteMultipleForm`, revision-revert `RevisionRevertForm`.
- Links: canonical `/log/{log}`, add-page `/log/add`, add-form `/log/add/{log_type}`,
  collection `/admin/content/log`, edit `/log/{log}/edit`, delete `/log/{log}/delete`,
  delete-multiple `/log/delete`, version-history `/log/{log}/revisions`,
  revision `/log/{log}/revisions/{log_revision}/view`, revert `.../revert`.

## Base fields (`Log::baseFieldDefinitions()`)

| Field | Type | Notes |
|-------|------|-------|
| `name` | string(255) | Log label. Leave blank to auto-generate from the type's `name_pattern`. Revisionable, translatable. |
| `timestamp` | timestamp | **Required.** Time of the event being logged. Default = request time (`::getRequestTime`). Revisionable. |
| `status` | state | **Required.** `state_machine` state field. Workflow chosen per bundle via `workflow_callback` → `Log::getWorkflowId($log)` (loads the bundle's `LogType::getWorkflowId()`). Revisionable. |
| `uid` | entity_reference→user | Author/owner. Default = current user (`::getCurrentUserId`). Revisionable. |
| `created` | created | Authored-on time; default request time. Revisionable. |
| `changed` | changed | Last-edited time. Revisionable. |

Plus owner fields (`EntityOwnerTrait`) and revision-log fields
(`revision_user`/`revision_created`/`revision_log_message` via `RevisionLogEntityTrait`).
`name` and `timestamp` map to Views handlers — see [../views/views.md](../views/views.md).

## Interface (`LogInterface`)

Extends `ContentEntityInterface`, `EntityChangedInterface`, `RevisionLogInterface`,
`EntityOwnerInterface`. Methods: `getName()`, `setName($name)`, `getCreatedTime()`,
`setCreatedTime($ts)`, `getTypeNamePattern()`, `getBundleLabel()`. Static helpers on `Log`:
`getCurrentUserId()`, `getRequestTime()`, `getWorkflowId(LogInterface $log)`.

> Note: the `status` field is a **workflow state** (pending/done), not a publish flag —
> `Log` does not implement `EntityPublishedInterface`.

## Automatic naming (`LogStorage::doPostSave()`)

`Drupal\log\LogStorage` (extends `SqlContentEntityStorage`, injects the `token` service).
On save it fills a blank `name` — and re-generates a previously auto-generated name on
update — by rendering the bundle's `name_pattern` through
`token->replace($pattern, ['log' => $entity], [], new BubbleableMetadata())`. It runs the
parent save first so a new log has an id for token replacement, then re-saves if the name
changed.

## Name autocomplete

`Drupal\log\Controller\LogAutocompleteController::autocomplete($log_bundle, $request)`
(route `log.autocomplete.name`) returns distinct existing `name` values for a bundle,
sorted by usage. It runs a direct DB query on the data table using
`$database->escapeLike()` + parameterized conditions, and scopes results to what the caller
may see: `administer log` or `view any <bundle> log` → all; `view own <bundle> log` →
`uid = current user`; otherwise an empty set. `LogForm` wires this widget onto the `name`
field when the bundle already has logs.

## Create a log programmatically

```php
$log = \Drupal\log\Entity\Log::create([
  'type' => 'observation',      // a log_type bundle id
  'name' => '',                 // blank => auto-named from name_pattern
  'timestamp' => \Drupal::time()->getRequestTime(),
  'status' => 'pending',        // a state in the bundle's workflow
  // 'uid' defaults to current user
]);
$log->save();                   // LogStorage fills the name if left blank
```

## Context provider

Service `log.log_route_context` (`Drupal\log\ContextProvider\LogRouteContext`, tagged
`context_provider`) exposes the current log as an entity context named `log` on log routes:
it resolves `log_revision`, then `log`, then (on `log.add`) a freshly `Log::create()`d stub
for the routed `log_type`. Cache context: `route`.
