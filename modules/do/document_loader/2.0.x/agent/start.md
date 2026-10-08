<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader (document_loader) — agent index

A **plugin framework** that ingests documents from many sources and normalizes them into one
`content` + `metadata` result. Package `Web services`. Depends only on core **`file`**. Core
`^10.4 || ^11`. License GPL-2.0-or-later. Version 2.0.5. Configure at
`document_loader.settings_form`. Permission: `document_loader.administer`.

**Ships the framework only — no concrete loader plugins.** Install a loader module (PDF Parser,
Webpage, AI File To Text, …) for anything to actually extract. Same idea as LangChain document
loaders: sources are plugins, output is uniform, consumers work against one shape (RAG, search
index, migration).

## Solution docs

- **The `DocumentLoaderManager` service, the load pipeline, hooks, `DocumentLoaderResult`, Drush** →
  [api/manager.md](api/manager.md)
- **The two plugin types, attributes, Input/Output/Type classes, the factory, FileInputNormalizer** →
  [plugins/loader-types.md](plugins/loader-types.md)
- **Settings form, config object/schema, explorer form, routes & permissions** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Two plugin types** (both `DefaultPluginManager` subclasses, attribute-discovered):
  - `document_loader` — extraction backends. Manager `plugin.manager.document_loader`, interface
    `Plugin\DocumentLoaderInterface`, base `Plugin\DocumentLoaderBase`, attribute
    `Attribute\DocumentLoader` (discovers `Plugin/DocumentLoader/`). **The base module registers
    none.**
  - `document_loader_type` — input categories. Manager `plugin.manager.document_loader_type`,
    interface `DocumentLoaderType\DocumentLoaderTypeInterface`, base `DocumentLoaderTypeBase`,
    attribute `Attribute\DocumentLoaderType` (discovers `Plugin/DocumentLoaderType/`). ~19 type
    plugins ship (Pdf, Word, Spreadsheet, Presentation, Image, Text, Markdown, Html, Json, Xml,
    Yaml, Toml, Api, Website, S3, Notion, GitHub, SharePoint, OneDrive, Slack).
- **Services** (`document_loader.services.yml`): `document_loader.manager`
  (`Service\DocumentLoaderManager`, the high-level pipeline), `document_loader.type_factory`
  (`DocumentLoaderType\DocumentLoaderTypeFactory`), `document_loader.file_input.normalizer`
  (`FileInput\FileInputNormalizer`), plus the two plugin managers and the `Hook\DocumentLoaderHooks`
  help hook.
- **Input/Output class hierarchies** under `src/DocumentLoaderType/Input/*` and `.../Output/*`:
  Inputs are `FileInput` subclasses (extension-matched) or `UrlInputInterface` implementors
  (`ApiInput`, `WebsiteUrlInput`); Outputs are `ContentOutput` subclasses named `{Format}Output`.
- **Routes/forms**: `document_loader.settings_form` (`/admin/config/media/document-loader`),
  `document_loader.explorer_form` (`/…/explorer`) — both `_permission: document_loader.administer`.
  Local tasks + a menu link under *Configuration → Media*.
- **Drush**: `document-loader:list`, `document-loader:inputs`, `document-loader:load`
  (`Drush\Commands\DocumentLoaderCommands`).
- **Hooks provided** (`document_loader.api.php`): `hook_document_loader_pre_load_alter()`,
  `hook_document_loader_post_load_alter()`; plus alter info `document_loader_info` /
  `document_loader_type_info`.
- **Config**: single object `document_loader.settings` (`default_loaders` map; schema type
  `ignore`).
- **Submodules** (own doc trees under `modules/`): `document_loader_automator`,
  `document_loader_fwa`, `document_loader_mdx`, `document_loader_media`, `document_loader_tool`.
