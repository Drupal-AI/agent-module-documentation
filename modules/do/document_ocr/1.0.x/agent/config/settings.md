<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, routes, permission & services

## Install / enable

`composer require drupal/document_ocr` (pulls the OCR/AI libraries) then enable the module. Each
processor also needs its own library/binary and credentials before it will run
(`requirementsAreMet()`); `pdf_parser` is pure PHP and needs no binary. The shipped
`views.view.document_ocr` implies the core **views** module is enabled.

## Permission

One permission, `administer document ocr` (`document_ocr.permissions.yml`). It gates every custom
route and is the `admin_permission` of all five entity types, so `_entity_access` requirements on
CRUD routes also resolve to it. No public/anonymous or low-privilege route exists.

## Settings config object (`document_ocr.settings`)

Global defaults (`config/install/document_ocr.settings.yml`; schema `config_object`):

| key | type | default | meaning |
|-----|------|---------|---------|
| `realtime_processing` | boolean | false | Process on entity save instead of queuing for cron. |
| `attempts` | integer | 3 | Max processing attempts before a task is marked failed. |
| `delete_destination` | boolean | true | Delete the imported destination entity when its source file is deleted. |
| `process_update` | boolean | true | Re-process files when an existing source entity is updated. |

Per-mapping `settings` (on the `document_ocr_mapping` entity) can override these.

## Routes (all under `/admin/config/structure/document-ocr`, `document_ocr.routing.yml`)

- **Mappings:** `entity.document_ocr_mapping.collection` (list, `administer document ocr`);
  `document_ocr_mapping.new` / `.mapping` / `.settings` (new-mapping wizard, `administer document
  ocr`); edit / configuration / template_file / mapping / process / settings / delete
  (`_entity_access: document_ocr_mapping.*`); `entity.document_ocr_mapping.enable` /
  `.disable` (`HelperController::enable/disable`, `_entity_access: document_ocr_mapping.update`).
- **One-time import:** `document_ocr_mapping.onetime_new` / `.onetime_mapping` /
  `.onetime_files` (`administer document ocr`) — upload + process files ad hoc.
- **Processors:** `entity.document_ocr_processor.collection` + edit/configuration/delete +
  `document_ocr_processor.new` / `.configuration`.
- **Transformers:** `entity.document_ocr_transformer.collection` + edit/configuration/delete +
  `document_ocr_transformer.new` / `.configuration`.
- **Tasks:** `entity.document_ocr_task.collection`; `.older_entities` (Queue Older Entities form);
  `.process` / `.restart` / `.delete` (`_entity_access: document_ocr_task.*`).

Menu links (`links.menu.yml`) place Mapping/Processors/Transformers/Tasks/One-time under
*Structure → Document OCR*; local tasks (`links.task.yml`) render them as tabs; action links
(`links.action.yml`) add the modal "New …" buttons.

## Services (`document_ocr.services.yml`)

- Plugin managers: `plugin.manager.document_ocr_processor`, `plugin.manager.document_ocr_transformer`.
- ParamConverters: `paramconverter.document_ocr_processor`, `paramconverter.document_ocr_transformer`.
- Provider clients: `document_ocr.google_documentai`, `document_ocr.google_translate`,
  `document_ocr.google_text2speech`, `document_ocr.openai`, `document_ocr.microsoft_translate`.
- Repositories (bundled JSON lookups in `repository/`): `document_ocr.languages_repository`,
  `.languages_iso639_repository`, `.documentai_regions_repository`, `.openai_models_repository`,
  `.theme_repository`.
- Orchestration: `document_ocr.process` (the pipeline), `document_ocr.batch` (Batch API static
  callbacks), `document_ocr.module` (hook glue), and the event subscriber
  `document_ocr.processed_data` (`EventSubscriber\TaskEventSubscriber`).

See [../api/processing.md](../api/processing.md) for how these run.

## Config schema

`config/schema/document_ocr.schema.yml` defines `document_ocr.mapping.*`, `document_ocr.processor.*`,
`document_ocr.transformer.*` (config_entity) and `document_ocr.settings` (config_object) — so
`provides_config_schema` is true.
