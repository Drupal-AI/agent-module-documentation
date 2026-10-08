<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA action: Set column value (`eca_views_data_export_set_column_value`)

Source: `src/Plugin/Action/SetColumnValue.php`,
`config/schema/eca_views_data_export.schema.yml`.

`SetColumnValue extends \Drupal\eca\Plugin\Action\ConfigurableActionBase`. Declared with
`#[Action(id: 'eca_views_data_export_set_column_value', label: 'Set column value')]` and
`#[EcaAction(version_introduced: '1.0.0')]`. It is meant to run inside the **"Alter a row"** event
(see [event-alter-row.md](event-alter-row.md)); outside that event it is a no-op.

## Configuration

`defaultConfiguration()` / `buildConfigurationForm()` expose two textfields:

- **`column`** — the key/name of the row cell to overwrite.
- **`value`** — the new value to write into that cell.

`submitConfigurationForm()` stores both back into `$this->configuration`. Config schema
`action.configuration.eca_views_data_export_set_column_value`: `column` (string), `value` (string).
Both support tokens.

## What execute() does

    public function execute(): void {
      $event = $this->getEvent();
      if ($event instanceof AlterRow) {
        $row = &$event->getRow();
        $column = $this->tokenService->replaceClear($this->configuration['column']);
        $value  = $this->tokenService->replaceClear($this->configuration['value']);
        if (isset($row[$column])) {
          $row[$column] = $value;
        }
      }
    }

- Only acts when the current ECA event is an `AlterRow` instance.
- Both `column` and `value` are token-replaced via `tokenService->replaceClear()` (ECA's token
  service, from the base class).
- The row is obtained **by reference** from the event, so the write reaches the exported output.
- **Guarded update:** it writes only when `$column` already exists in the row
  (`isset($row[$column])`) — it overwrites an existing export column and does **not** add new
  columns. If the column name does not match an existing key, nothing changes.

## access()

`access()` returns `AccessResult::allowed()` unconditionally (returned as object or bool per
`$return_as_object`). This is the standard pattern for an ECA action that runs within the model's
execution context; the export's own access is governed entirely by Views / views_data_export, not
by this action.

## Typical use

Inside a model triggered by "Alter a row", add one or more "Set column value" actions to reformat,
mask, or recompute existing export columns, e.g. `column` = `title`, `value` =
`[current_row:...]`-derived text.
