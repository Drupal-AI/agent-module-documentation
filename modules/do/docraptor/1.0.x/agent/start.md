<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DocRaptor (docraptor) — agent index

A thin Drupal wrapper around the **DocRaptor** HTML-to-PDF SaaS API (rendered by the commercial
**Prince** engine). It exposes **one service** that custom code calls to turn an HTML string into a
PDF (or other document type) and write the bytes to a file. Package `PDF`. Core
`^10.2 || ^11`. License GPL-2.0-or-later. Version 1.0.x (installed 1.0.0-beta1).

- **Configure the credential, document type and Prince options; the settings route, permission and
  menu link** → [config/settings.md](config/settings.md)
- **The `docraptor.manager` service — how code requests and saves a document** →
  [api/manager.md](api/manager.md)

## Dependencies

- Drupal module: **`key`** (`drupal/key ^1.19`) — required; the API credential is chosen as a Key
  entity, not typed into config.
- Composer library: **`docraptor/docraptor` `^3.0 || ^4.0`** (the official DocRaptor PHP SDK,
  `library_dependencies`). Install via Composer; it is not a Drupal module.
- No PHP version constraint declared. No other Drupal module dependencies.

## What it actually provides (from source)

- **One service** `docraptor.manager` → `Drupal\docraptor\DocraptorManager`
  (`docraptor.services.yml`, `src/DocraptorManager.php`). Injected:
  `config.factory`, `logger.factory`, `cache.data`, `language_manager`, `key.repository`.
  (`cache.data` and `language_manager` are injected but unused in this version.)
- **One settings form** `Drupal\docraptor\Form\DocraptorSettingsForm` (`ConfigFormBase`) at route
  **`docraptor.settings`** → path `/admin/config/system/docraptor`, editing config object
  **`docraptor.settings`**.
- **One permission** `administer docraptor settings` (`docraptor.permissions.yml`) — gates the
  settings route.
- **One menu link** `docraptor.settings` under `system.admin_config_services`
  (`docraptor.links.menu.yml`).
- **Config schema** for `docraptor.settings` (`config/schema/docraptor.schema.yml`).
- **No routes for generating PDFs**, no controllers, blocks, fields, plugins, hooks, Drush
  commands or `config/install` defaults. Generation is driven entirely by calling the service from
  your own code.

## Mechanism at a glance

- `DocraptorManager::__construct()` loads config `docraptor.settings`, reads `username_key`
  (a Key id), fetches its value from `key.repository`, and sets it as the DocRaptor `DocApi`
  **username** (DocRaptor uses the API key as the basic-auth username).
- `preparePdfDocument($html, $filename)` builds a `DocRaptor\Doc` from the config (test mode,
  document type, and Prince options: `pdf_forms`, `pdf_profile`, `color_conversion`, `icc_profile`).
- `savePdfDocument($absolutePath)` calls `DocApi::createDoc()` and `file_put_contents()`s the
  result; API failures are logged to the `docraptor` channel and re-thrown as `\Exception`.

## Caveats (functional)

- The constructor calls `keyRepository->getKey($username_key)->getKeyValue()` with no null guard,
  so instantiating the service before a Key is configured raises an error — configure the settings
  form first.
- The document is written with `file_put_contents($absolute_pdf_path, …)`; the caller supplies and
  is responsible for the destination path (it is not made a managed file automatically).
