<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Todo content entity

Source: `src/Entity/Todo.php`, schema `config/schema/contrib_todo_list.schema.yml`.

`Todo` extends `ContentEntityBase`. Annotation:

```
@ContentEntityType(
  id = "todo",
  label = "Todo",
  base_table = "todo",
  entity_keys = { "id"="id", "uuid"="uuid", "langcode"="langcode" }
)
```

Minimal by design: the annotation declares no handlers, forms, links, admin_permission, or views_data. The entity keys are `id`/`uuid`/`langcode`; the author is tracked by a plain `uid` base field (see below) rather than an `owner` entity key.

## Base fields (`baseFieldDefinitions()`)
| Field | Type | Notes |
|-------|------|-------|
| `langcode` | language | revisionable; set from current language on create |
| `nid` | entity_reference → node | required; the node the todo is attached to |
| `uid` | entity_reference → user | required; the creating user |
| `share` | boolean | default FALSE; when TRUE the todo is visible to other users on the node |
| `todo` | text_long | required, translatable; the description text |
| `state` | list_string | required; stores a **label** string ("Pending"/"In progress"/"Completed"), not the key |
| `pin` | text_long | default null; a CSS selector string locating an element to drop a marker on |

Note the `state` field stores the human label produced by `TodoState::getStateFromKey()`, while routes/filters use the *key* (`pending`, `in-progress`, `completed`). The `list_string` field defines no allowed-values callback, so any string can be persisted through the entity API.

## State value object (`src/data/TodoState.php`)
Constants `PENDING='pending'`, `IN_PROGRESS='in-progress'`, `COMPLETED='completed'`. Static helpers: `getStateFromKey($key)` (key → label, defaults to `pending`), `getKeyByLabel($label)` (label → key), `getStateKeys()`, `getStateLabels()`, `getStates()` (key→label map). Used by the controller, service, Twig extension and JS.

## Install
`hook_install()` (`.install`) pins the schema version to 10000; `hook_update_10001()` seeds French locale translations for the UI strings. Enabling the module creates the `todo` base table automatically. Config schema `contrib_todo_list.todo.*` documents the stored fields (id, uuid, langcode, nid, uid, share, todo, state, pin).
