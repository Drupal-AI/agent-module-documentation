<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Print Browserless PDF (entity_print_browserless_pdf) — agent index

An **Entity Print print-engine plugin** that renders PDFs by POSTing the entity's print HTML to a
remote **Browserless** (headless-Chrome-as-a-service) `/pdf` API and streaming back the PDF.
Package `Entity Print`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha2 (dir 1.0.x).

- Depends on **`entity_print`** (composer `drupal/entity_print:^2.4`); no other module or library deps.
- Uses core's Guzzle `http_client_factory` for the outbound call; no config schema, no permissions,
  no routes, no hooks, no submodules of its own.
- Ships one service: a logger channel `logger.channel.entity_print_browserless_pdf`.

## What it actually is

- One plugin: `BrowserlessApi` (id **`browserless_api`**, label *"Browserless API"*, `export_type = "pdf"`),
  in `src/Plugin/EntityPrint/PrintEngine/BrowserlessApi.php`, extending Entity Print's `PdfEngineBase`
  and implementing `ContainerFactoryPluginInterface`.
- It is selected and configured on **Entity Print's own settings form** (route/permission owned by
  `entity_print`, typically `/admin/config/content/entityprint`). This module adds **no** settings
  route of its own — `configure` is null.

## Solution docs

- **The plugin, HTTP client, HTML→PDF payload, page assembly, asset rewriting** →
  [plugins/browserless_api.md](plugins/browserless_api.md)
- **Config keys, defaults, the settings-form fields, validation, and the token** →
  [config/settings.md](config/settings.md)
