<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA action plugins

Two ECA action plugins. Both are `#[Action]` + `#[EcaAction]` classes extending
`Drupal\eca\Plugin\Action\ConfigurableActionBase`, so they appear as configurable actions in any ECA
modeller. `version_introduced: '1.0.0'`.

## Install / enable

`composer require drupal/eca_entity_print` then enable `eca_entity_print` (pulls in `eca` and
`entity_print`). Configure an Entity Print engine (Dompdf or wkhtmltopdf/PhantomJS) under Entity Print
settings, then add one of the actions to an ECA model. No settings page is provided by this module.

## Shared execution (`PrintFileFromEntity`, `src/Plugin/Action/PrintFileFromEntity.php`)

`create()` injects: `access_manager`, `entity_print.print_builder` (`PrintBuilderInterface`),
`plugin.manager.entity_print.print_engine` (`EntityPrintPluginManagerInterface`),
`plugin.manager.entity_print.export_type` (`ExportTypeManagerInterface`). The ECA token service is
inherited from the base class.

`doExecute($object)` (shared by both actions):
1. `entityPrintPluginManager->createSelectedInstance($this->getExportType())` builds the print engine for
   the configured export type.
2. File name = `getFileName()` + `.` + `$print_engine->getExportType()->getFileExtension()`.
3. `printBuilder->savePrintable([$object], $print_engine, 'private', $file_name)` renders and writes the
   document to the **`private://`** scheme, returning a URI.
4. On success, creates a `Drupal\file\Entity\File` (`status => 1`, `uid => 1`), marks it permanent
   (`setPermanent()`), and saves it.
5. Adds the file entity to the ECA token map via `tokenService->addTokenData($token_name, $file)`. If
   `token_name` is empty it defaults to **`eca-entity-output-filename`**.

Helpers: `getExportType()`, `getFileName()` each run the config value through
`tokenService->replaceClear(...)` and `trim()`. `getFileName()` falls back to
`uniqid('eca.entity_print.output', TRUE)` when `file_name` is empty.

`execute($entity)` returns early unless `$entity instanceof FieldableEntityInterface`, then calls
`doExecute($entity)`.

### Config fields (`defaultConfiguration()` + `buildConfigurationForm()`)

- `token_name` (string, default `''`) — token that will hold the generated file entity
  (`#eca_token_reference`). Empty → `eca-entity-output-filename`.
- `file_name` (string, **required**, default `''`) — exported file name, supports token replacement
  (`#eca_token_replacement`). Extension is appended automatically.
- `export_type` (string, default `'pdf'`, **required**) — select built from
  `exportTypeManager->getFormOptions()`.

### Access (`access()`)

For a `FieldableEntityInterface` target, delegates to
`accessManager->checkNamedRoute('entity_print.view', [export_type, entity_id, entity_type], $account)` —
i.e. the caller must be allowed to view that entity's Entity Print output. Otherwise `AccessResult::forbidden()`.

## `PrintFileFromView` (`src/Plugin/Action/PrintFileFromView.php`)

Subclass; renders a View instead of a single entity. `execute()` loads the View via `getView()` and calls
`doExecute($this->view)`.

Additional config fields:
- `view_id` (**required**) — select of enabled Views (loaded via `entityTypeManager` storage `view`).
- `display_id` (default `'default'`) — the View display id to render.
- `arguments` (textarea) — Views contextual filter values, one per line, token-supported; split on `/` in
  `getView()` and passed to `setArguments()`.

`getView()` loads the enabled View, sets the display (or `initDisplay()`), applies arguments, and stores it
in `$this->view`; returns FALSE if the View is missing/disabled or the display can't be set. `access()`
returns allowed only when the resolved View display's `access($account)` passes.

## Config schema

`config/schema/eca_entity_print.schema.yml` defines mappings
`action.configuration.eca_entity_print_print_file_from_entity` (token_name, file_name, export_type, object)
and `action.configuration.eca_entity_print_print_file_from_view` (token_name, file_name, export_type,
view_id, display_id, arguments).

## Operating notes

- Output goes to `private://`; ensure the private file system is configured or `savePrintable` cannot write.
- The created file is owned by user 1 and permanent; downstream ECA steps read it from the configured token.
- Export types beyond `pdf` are whatever Entity Print export-type plugins are registered on the site.
