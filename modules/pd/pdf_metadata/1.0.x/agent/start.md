<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Metadata (pdf_metadata) — agent index

Writes PDF document metadata (**Title, Author, Subject, Keywords**) into uploaded PDF files,
driven by **entity token patterns** configured per file field, on entity **insert/update**.
Package `custom`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `1.0.x`
(released 1.0.0-beta8).

- **Install, the settings form, config object + schema, providers, custom binary path** →
  [config/settings.md](config/settings.md)
- **Per-field setup, the token metadata, the entity-save write path, services/hooks** →
  [fields/metadata.md](fields/metadata.md)

## Dependencies

Drupal modules (info.yml): `hook_event_dispatcher`, `core_event_dispatcher`, `file (>= 8.8.0)`,
`token`. Composer `require`: `drupal/token`, `drupal/hook_event_dispatcher`. Composer `suggest`:
`phpexiftool/exiftool`. **Runtime**: at least one server binary — **Ghostscript** (`gs`, default)
or **ExifTool** — must be installed or the module cannot write anything (`hook_requirements`
flags this at runtime).

## What it actually provides

- **No entities, no field types, no field widgets/formatters, no Drush.** It works entirely
  through **field third-party settings** (`pdf_metadata` namespace) plus an event subscriber.
- **Config route/form**: `pdf_metadata.settings` → `/admin/config/content/pdf-metadata/settings`,
  permission **`administer site configuration`** (`SettingsForm`). Menu link under
  *Configuration → Content authoring* (`links.menu.yml` lists parent `system.admin_config_content`).
- **Config object** `pdf_metadata.settings` (schema in `config/schema/pdf_metadata.schema.yml`):
  `provider` (`ghostscript`|`exiftool`, default `ghostscript`), `exiftool_binary_path` (''),
  `extra_gs_options` (sequence). Field third-party schema:
  `field.field.*.*.*.third_party.pdf_metadata` (`enabled`, `reference_enabled`, `meta_types`).
- **Services** (`pdf_metadata.services.yml`):
  - `pdf_metadata.provider_manager` → `Provider\PdfMetadataProviderManager` — registers and
    selects providers, with fallback.
  - `pdf_metadata.metatadata_creation_service` → `Service\MetadataCreationService` — token
    replacement, field discovery, and the PDF write orchestration. *(service id is misspelled
    "metatadata" in the yml — reference it verbatim.)*
  - `pdf_metadata.event_subscriber` → `EventSubscriber\EntityEventSubscriber`.
- **Providers** (hand-rolled, not a Drupal plugin manager): `GhostscriptProvider` (id
  `ghostscript`), `ExiftoolProvider` (id `exiftool`), both implementing
  `Provider\PdfMetadataProviderInterface` (`getId`, `getLabel`, `isAvailable`,
  `getAvailabilityError`, `writeMetadata`, `getLastError`).

## Mechanism (from source)

- `EntityEventSubscriber` subscribes to `ENTITY_INSERT`, `ENTITY_UPDATE` (from
  `core_event_dispatcher`) and to the `field_config_edit_form` alter event
  (`hook_event_dispatcher.form_field_config_edit_form.alter`). Save handlers call
  `MetadataCreationService::appendMetadata($entity)`; the form-alter handler injects the per-field
  settings via `addMetaFormFields()`.
- `appendMetadata()` → `validateFields()` (finds file fields and entity-reference fields whose
  `pdf_metadata` third-party settings are enabled) → `validateReferenceFields()` (walks references
  to file fields flagged `reference_enabled`) → `validateFiles()` (keeps only
  `application/pdf` MIME, resolves tokens with `Token::replacePlain(..., ['clear' => TRUE])`) →
  `generatePdfWithMetadata()` (calls the active provider's `writeMetadata($realpath, $metadata)`).
- `PdfMetadataProviderManager::getActiveProvider()` returns the configured provider, falling back
  to Ghostscript then ExifTool if the chosen one is unavailable.

See [fields/metadata.md](fields/metadata.md) for the field settings + write path and
[config/settings.md](config/settings.md) for the admin form and provider detection.
