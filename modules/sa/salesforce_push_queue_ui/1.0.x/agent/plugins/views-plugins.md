<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views data and plugins

The module defines **no plugin types of its own** — it *provides* four Views handlers and a
`hook_views_data()` definition. Use these ids when hand-writing a view on the queue table.

## Views data (`salesforce_push_queue_ui_views_data()`)

Base table `salesforce_push_queue`, base field `item_id`, group *Salesforce Push Queue*.

| Views field id | Column | Handlers |
|---|---|---|
| `item_id` | `item_id` | numeric field/sort/filter/argument |
| `name` | `name` (mapping id) | standard field, standard sort, filter `salesforce_push_queue_mapping_name`, string argument |
| `entity_id` | `entity_id` | numeric field/sort/filter/argument |
| `mapped_object_id` | `mapped_object_id` | numeric field/sort/filter/argument + **relationship** to `salesforce_mapped_object.id` |
| `op` | `op` (`create`/`update`/`delete`) | standard field, string filter/argument |
| `failures` | `failures` | numeric field/sort/filter/argument |
| `last_failure_message` | `last_failure_message` | standard field, string filter/argument |
| `expire` | `expire` | core `date` field/sort/filter/argument |
| `expire_formatted` | `expire` (real field) | field `salesforce_push_queue_expire` |
| `created` | `created` | core `date` field/sort/filter/argument |
| `created_formatted` | `created` (real field) | field `salesforce_push_queue_timestamp` |
| `updated` | `updated` | core `date` field/sort/filter/argument |
| `updated_formatted` | `updated` (real field) | field `salesforce_push_queue_timestamp` |
| `operations` | — | field `salesforce_push_queue_operations` (no query) |

## `salesforce_push_queue_timestamp` — TimestampField

`FieldPluginBase`, injects `date.formatter`. Options: `date_format` (default `medium`, plus a
`custom` and a `relative` choice), `custom_date_format`, `timezone`, `show_relative` (default
TRUE, used when `date_format` is `relative`). Renders a Unix timestamp as a formatted date.

## `salesforce_push_queue_expire` — ExpireField

Extends `TimestampField`. Renders:

- `expire` empty/`0` → `<span class="expire-status expire-none">Not set</span>`
- `expire < REQUEST_TIME` → red `🔴 <formatted date>` (`expire-expired`) — lease has lapsed
- otherwise → green `🟢 <formatted date>` (`expire-active`) — item is currently claimed

## `salesforce_push_queue_mapping_name` — MappingNameFilter

Extends `InOperator`; `getValueOptions()` runs
`SELECT DISTINCT name FROM salesforce_push_queue ORDER BY name`, so the exposed select only
lists mappings that currently have queued items (an empty queue means an empty filter list).

## `salesforce_push_queue_operations` — QueueOperations

`query()` is a no-op (adds nothing to SQL). `render()` builds a `#type: operations` element with
two links — *Reset failures (N)* and *Reset expiration (T)* — pointing at the two controller
routes, and appends the current path + query string as `destination` so you return to the same
filtered/paged view. Note the two `if (… || TRUE)` guards: both links are **always** rendered,
even for items with `failures = 0` and `expire = 0`. It has a `destination` option
(*Include destination*, default TRUE) in the field settings form, but `render()` ignores it and
always sets the destination.

`getValue($values, $field)` reads `$values->salesforce_push_queue_{$field}`, so a custom view
must keep the default table alias for the operations column to resolve ids.

## Adding the queue to your own view

```php
// Programmatic view (or do it in the UI: Add view → "Show: Salesforce Push Queue").
$view = \Drupal\views\Entity\View::create([
  'id' => 'sf_queue_failures',
  'label' => 'Salesforce push failures',
  'base_table' => 'salesforce_push_queue',
  'base_field' => 'item_id',
]);
```

Then add fields `name`, `entity_id`, `failures`, `last_failure_message`, `expire_formatted`,
`operations`, and a `failures` numeric filter (`>= 1`). Because the view id will not be
`salesforce_push_queue`, `hook_views_pre_render()` will not strip the message prefix — expect the
full `Queue item %item failed %fail times…` text.
