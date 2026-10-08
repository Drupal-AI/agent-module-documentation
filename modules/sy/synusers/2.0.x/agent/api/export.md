<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XLSX user export (`/users-xls`)

Source: `synusers.routing.yml`, `src/Controller/SynusersController.php`. Library:
`phpoffice/phpspreadsheet` (`^5.9`, declared in `composer.json`).

## Route & access

```yaml
synusers.page:
  path: '/users-xls'
  defaults:
    _controller: '\Drupal\synusers\Controller\SynusersController::page'
    _title: 'Users upload'
  requirements:
    _permission: 'administer users'
```

- Only route in the module. Gated by the core high-trust permission **`administer users`**.
- The response is a **file download**, not an HTML page: `page()` returns a
  `Symfony\...\BinaryFileResponse`. So there is no rendered admin screen at this path (title
  "Users upload" is a misnomer — the module exports, it does not upload/import).

## Controller flow (`SynusersController`)

Constructor injects `request_stack`, `entity_type.manager`, `views.executable`
(`ViewExecutableFactory`), `file_system`, and hardcodes:
`viewId = 'cml_users'`, `displayId = 'page'`, `path = 'public://Excel'`, `filename = 'users.xlsx'`.

1. **`page()`** → `getView()`, then `xlsStructure()`, then returns
   `new BinaryFileResponse('public://Excel/users.xlsx', 200, headers, TRUE)` with
   `Content-Type: application/vnd.ms-excel` and
   `Content-Disposition: attachment;filename="users.xlsx"`.
2. **`getView()`** — loads the `cml_users` view entity via `entity_type.manager`. If it is not a
   `ViewEntityInterface` it throws `\RuntimeException('The cml_users view is unavailable.')`.
   Otherwise it `get()`s an executable, `setExposedInput($this->request)`, `setDisplay('page')`,
   `setArguments([])`, `execute()`. For each result row it iterates `$view->field`, **skipping the
   `operations` and `status` fields**; on the first row it records each remaining field's
   `label()` into the header (`$this->table`), and stores `$field->getValue($row)` into
   `$this->result[$rid][$fid]`.
3. **`xlsStructure()`** — `fileSystem->prepareDirectory('public://Excel', CREATE_DIRECTORY |
   MODIFY_PERMISSIONS)` (throws if it can't), then builds a `Spreadsheet`, writes the header array
   at `A1` and the data array at `A2` via `getActiveSheet()->fromArray(..., NULL, 'A1'|'A2', FALSE)`,
   and saves with `new Xlsx($spreadsheet)` to `public://Excel/users.xlsx`.
4. **`queryParameters()`** — copies each scalar value from `$request->query->all()` into a
   `key => (string) value` array used as the view's exposed input. Non-scalar params are dropped.

## What columns are exported

Whatever fields the `cml_users` `page` display renders, minus `operations` and `status`. With the
bundled view that is: **Login (name), First name (field_user_name), Surname (field_user_surname),
Phone (field_user_phone), Email (mail)** — header labels come from the view field labels, values from
each field handler's raw `getValue()`. Row set and order follow the view's filters/sorts, refined by
any exposed-filter query params passed to `/users-xls`.

## Operating it

1. `composer require phpoffice/phpspreadsheet` (via `ddev composer require ...`) is required — the
   controller fatally errors without the library.
2. `ddev drush en synusers -y`.
3. Ensure the `cml_users` view exists (see [config/views.md](config/views.md) — it needs the three
   custom user fields, or a replacement view of the same id/display).
4. As a user with `administer users`, hit `/users-xls` (or click the injected "Download Excel" link on
   the view page) to download `users.xlsx`.

## Behavior on a stock site (verified)

On a site **without** the `field_user_name` / `field_user_surname` / `field_user_phone` user fields,
the bundled optional view is never imported, so:

- `/users` → **404** (view page display absent).
- `/users-xls` → **500** (`getView()` throws `\RuntimeException` because the `cml_users` entity is
  `null`).

The module is therefore only usable alongside the vendor's custom user-field setup (or an
operator-supplied `cml_users` view with a `page` display).

## Output location

The spreadsheet is generated under the site's public files stream and streamed back to the
requesting admin as a `BinaryFileResponse` attachment download.
