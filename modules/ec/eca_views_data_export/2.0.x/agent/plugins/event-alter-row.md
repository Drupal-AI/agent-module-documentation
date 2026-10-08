<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA event: Alter a row (`eca_views_data_export:alter_row`)

Source: `src/Plugin/ECA/Event/ViewsDataExportEvent.php`,
`src/Plugin/ECA/Event/ViewsDataExportEventDeriver.php`, `src/Event/AlterRow.php`,
`src/Hook/ViewsHooks.php`, `src/EcaEvents.php`, `config/schema/eca_views_data_export.schema.yml`.

## When it fires

`ViewsHooks::viewsDataExportRowAlter()` implements core `hook_views_data_export_row_alter()`
(fired by the views_data_export module while building an export display) and calls:

    $this->triggerEvent->dispatchFromPlugin('eca_views_data_export:alter_row', $row, $result, $view);

So the event is dispatched **once per exported result row**, during export generation — not on a
schedule and not when the View is viewed normally. `$row` (the outgoing cells, passed by reference),
`$result` (`\Drupal\views\ResultRow`) and `$view` (`\Drupal\views\ViewExecutable`) come straight
from the hook. The legacy procedural wrapper in `eca_views_data_export.module` forwards to the same
service method.

## Event object — `Event\AlterRow`

- `getRow(): array` — returns the row **by reference**; actions that mutate it change the exported
  output. This is why `SetColumnValue` can write back.
- `getResult(): array` — the Views result copied into a plain array (constructor iterates the
  `ResultRow` into `$this->result`).
- `getView(): ViewExecutable` — the executing View (used for wildcard scoping).

## Plugin definition & scoping

`ViewsDataExportEvent::definitions()` declares the single derivative:

- `alter_row` → label *"Alter a row"*, `event_name` = `EcaEvents::ALTER_ROW`
  (`'eca_views_data_export.alter_row'`), `event_class` = `AlterRow::class`.

`buildConfigurationForm()` adds two textfields on the event configuration:

- **View ID** (`view_id`) — machine name of the View to match, or empty for any.
- **Display ID** (`display_id`) — display machine name to match, or empty for any.

Scoping is implemented via the wildcard mechanism:

- `generateWildcard()` returns `"{view_id}::{display_id}"` (trimmed).
- `appliesForWildcard()` splits on `::` and matches when the event is an `AlterRow` **and**
  (`view_id` empty or equals `$event->getView()->id()`) **and** (`display_id` empty or equals
  `$event->getView()->current_display`).

Config schema (`eca.event.plugin.eca_views_data_export:alter_row`): `view_id` (string),
`display_id` (string).

## Tokens exposed by the event

`getData(string $key)` (annotated with `#[Token]`) returns ECA data-transfer objects:

- `current_result` → `DataTransferObject::create($event->getResult())` — token type
  `[current_result:*]`.
- `current_row` → `DataTransferObject::create($event->getRow())` — token type `[current_row:*]`.

`Hook\TokenHooks` registers both as nested/dynamic token types (`tokenInfo()`) and, in `tokens()`,
remaps the incoming data to ECA's `dto` key and delegates resolution to ECA's own token handler
(`eca_tokens()` if available, otherwise the registered `Drupal\eca\Hook\TokenHooks` listener on
`drupal_hook.tokens`). This lets a model read individual cells/fields of the current row or result
inside any action.

## Operating it

1. Enable the module (`drush en eca_views_data_export`); `eca` and `views_data_export` are required.
2. In an ECA model, add the event **"ECA Views data export: Alter a row"**; optionally set View ID
   / Display ID to limit which export it reacts to.
3. Add conditions/actions; use `[current_row:...]` / `[current_result:...]` tokens and/or the
   "Set column value" action to change the exported cells.
