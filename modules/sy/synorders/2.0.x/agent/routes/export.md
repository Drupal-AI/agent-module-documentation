<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# /orders-xls export route, controller & the view link hook

## Route

`synorders.routing.yml`:

| Route | Path | Handler | Access |
|-------|------|---------|--------|
| `synorders.page` | `/orders-xls` | `SynordersController::page` | `_permission: 'administer commerce_order'` |

Title "Orders upload". Same permission as the `cml_orders` view (see
[`../views/cml-orders.md`](../views/cml-orders.md)).

## The "Download Excel" link — `src/Hook/ViewsHooks.php`

`ViewsHooks::viewsPreView()` (`#[Hook('views_pre_view')]`) fires for every view. When the view id is
`cml_orders` **and** display id is `page`, it builds a `Link` "Download Excel" to `internal:/orders-xls`
carrying `query => $view->getExposedInput()` (the live filter values), then injects it as a
`text_custom` header area (`<div class="load-xls">…</div>`) via `$view->setHandler('page', 'header', …)`.
So the export link always reflects the filters the user is currently viewing.

## The controller — `src/Controller/SynordersController.php`

`final class SynordersController extends ControllerBase`. Injected via `create()`: `request_stack`
and `file_system`. Three methods:

### `page(): BinaryFileResponse`
Calls `getView()`, builds `orders.xlsx` through `xlsStructure()`, and returns a `BinaryFileResponse`
with headers `Content-Type: application/vnd.ms-excel` and
`Content-Disposition: attachment;filename="orders.xlsx"`. The `true` 4th arg marks the file for
deletion after send (`deleteFileAfterSend`).

### `getView(): array`
```php
$view = Views::getView('cml_orders');          // RuntimeException if missing
$query = $this->requestStack->getCurrentRequest()?->query->all() ?? [];
$view->setExposedInput(array_filter($query, static fn ($v) => is_string($v)));
$view->setDisplay('page');
$view->setArguments([]);
$view->execute();
```
It then walks `$view->result`: for each integer row id `< 1000` it iterates `$view->field`,
**skipping the `operations` field**, uses `$field->label()` for the header row (on `$rid == 0`), and
stores `strip_tags($field->advancedRender($row))` as the cell value. Row ids `>= 1000` break the loop
(hard cap: first 1000 rows). Returns `[$table (labels), $result (rows)]`.

The exposed input is taken straight from the request query (string values only) and handed to the
view's own exposed-filter handling — the view applies the same access/permission (`administer
commerce_order`) and parameterised filter queries as the on-screen `/orders` page; there is no raw SQL
here.

### `xlsStructure(array $table, array $result, string $filename): string`
```php
$publicPath = Settings::get('file_public_path', 'sites/default/files');
$path = $publicPath . '/Excel';
$this->fileSystem->prepareDirectory($path, CREATE_DIRECTORY | MODIFY_PERMISSIONS);
$spreadsheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();
$sheet->fromArray($table,  NULL, 'A1', FALSE);  // labels → header row
$sheet->fromArray($result, NULL, 'A2', FALSE);  // rows
(new \PhpOffice\PhpSpreadsheet\Writer\Xlsx($spreadsheet))->save($path . '/' . $filename);
return $path . '/' . $filename;
```
Writes the workbook to `public://Excel/orders.xlsx` (a **fixed filename under the public files
directory**) and returns the path for `page()` to stream. Note the workbook is written to disk before
being served; review the location/retention implications for the customer PII it contains.

## Install side effect — `synorders.install`

`synorders_install()` → `user_role_change_permissions('editor', ['administer commerce_order' => 1])`;
`synorders_uninstall()` sets it back to `0`. Installing the module therefore widens the `editor` role
to full Commerce-order administration (and thus to this view and export).
