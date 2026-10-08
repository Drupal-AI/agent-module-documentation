<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synusers (synusers) — agent index

Adds an admin page **`/users-xls`** that **exports** the site's users to an **XLSX** file. It runs a
bundled Views view (`cml_users`, `page` display), writes the visible columns to
`public://Excel/users.xlsx` with **PhpSpreadsheet**, and returns it as a download. A
`hook_views_pre_view()` injects a **"Download Excel"** link into that view's header. Package
**SynapseF**. Core `^11 || ^12`. License GPL-2.0-or-later. Version 2.0.7. **Export only — no
upload/import exists** despite the "Users upload" page title.

- **The export route, controller flow, columns, and file output** → [api/export.md](api/export.md)
- **The bundled `cml_users` view, the pre-view hook, and the install/uninstall hooks** →
  [config/views.md](config/views.md)

## What it actually is

- One route: **`synusers.page`** → path `/users-xls`, title *"Users upload"*, controller
  `SynusersController::page`, requirement **`_permission: 'administer users'`**
  (`synusers.routing.yml`). This is the module's only route; there is no second/unauthenticated one.
- One controller: `src/Controller/SynusersController.php` (`final class SynusersController extends
  ControllerBase`). Injects `request_stack`, `entity_type.manager`, `views.executable`
  (`ViewExecutableFactory`), `file_system`.
- One hook helper: `src/Hook/ViewsPreView.php` (`ViewsPreView::hook()`), invoked from
  `synusers_views_pre_view()` in `synusers.module`.
- Install/uninstall hooks: `synusers.install` grants/revokes the **`administer users`** permission on
  the **`editor`** role.
- Bundled optional config: `config/optional/views.view.cml_users.yml` (a "Users" view).
- Menu link: `synusers.links.menu.yml` adds a *"Users"* link (`internal:/users`) to the `editor` menu.

## Dependencies

- **Composer:** `phpoffice/phpspreadsheet: ^5.9` (must be installed via Composer).
- **Modules:** core **Views** is required at runtime (controller uses `ViewEntityInterface` /
  `ViewExecutableFactory`; hook uses `ViewExecutable`) but is **not declared** in `info.yml`.
- **Data model:** the bundled view depends on three custom user fields —
  `field.storage.user.field_user_name`, `field_user_surname`, `field_user_phone`. Because these are
  its optional-config dependencies, on a site lacking those fields the `cml_users` view is never
  installed, so `/users` (view page) 404s and `/users-xls` throws (see below).

## Provides

- No permissions of its own, no Drush commands, no config schema, no plugin types, no settings form
  (`configure` is null). It reuses the core `administer users` permission.

## Mechanism (from source)

- `SynusersController::page()` calls `getView()` then `xlsStructure()`, then returns a
  `BinaryFileResponse` for `public://Excel/users.xlsx` with `Content-Type: application/vnd.ms-excel`
  and `Content-Disposition: attachment; filename="users.xlsx"`.
- `getView()` loads the `cml_users` view entity (throws `\RuntimeException` "The cml_users view is
  unavailable." if missing), sets exposed input from the request query, sets display `page`, executes
  it, and collects `$field->label()` (header) + `$field->getValue($row)` for every field **except
  `operations` and `status`**.
- `xlsStructure()` prepares `public://Excel`, builds a `Spreadsheet`, writes the header row (A1) and
  data rows (A2) via `Sheet::fromArray()`, and saves with the `Xlsx` writer.
- Query params: `queryParameters()` copies only scalar `$request->query` values through as Views
  exposed input.

See [api/export.md](api/export.md) and [config/views.md](config/views.md) for details.
