<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export a content type to a Drupal module

The Export feature turns your UI-built content types into a real, hand-maintainable module and hands it
to you as a downloadable archive. It is purely a scaffolding/download tool — nothing is installed or
executed on the current site.

## Flow
1. Route `content_entity_builder.export` (`/admin/structure/content-types/export`, task "Export") →
   `Form\ContentEntityBuilderExportForm`. You supply a module **label**, **machine name** (`#type =>
   machine_name`, must not be an existing module), a **description**, and check one or more content
   types to include.
2. On submit, the form builds a `$config` array and calls
   `Export\ContentEntityBuilderExportHelper::generateArchiveTarFile()`.
3. The helper creates `temporary://<name>.tar.gz` (via `ArchiveTar`, gz) and `addString()`s the
   generated files into it (see below). It then redirects to `content_entity_builder.download`.
4. `content_entity_builder.download/{name}` →
   `Controller\ContentEntityBuilderDownloadController::downloadExport()` builds a request for
   `<name>.tar.gz` and streams it via core `FileDownloadController::download()` (scheme `temporary`).
   `Hook\ContentEntityBuilderHooks::fileDownload()` authorizes the download only for holders of
   `administer content entity types` and only for `.tar.gz` targets.

Both the export form and the download route require `administer content entity types`.

## What the archive contains
Per selected content type, `generateArchiveTarFile()` emits (module-relative):
- `<name>.info.yml`, `<name>.module` (hook_theme + template_preprocess), `<name>.install`
  (hook_install that clears the source `content_type` config), `<name>.permissions.yml`,
  `<name>.links.action/task/menu.yml`, `<name>.routing.yml`, `config/schema/<name>.schema.yml`.
- `src/Entity/<Entity>.php` — the content entity class. Which template is used depends on the type's
  mode: `generateEntityPhp` (basic), `generatePlusEntityPhp` (basic_plus), `generateAdvancedEntityPhp`
  (advanced, translatable + owner/published/changed), `generateFullEntityPhp` (full,
  `EditorialContentEntityBase` + revisions).
- `src/<Entity>Interface.php`, `src/<Entity>ListBuilder.php`, `src/Form/<Entity>Form.php`,
  `src/Form/<Entity>DeleteForm.php`, `src/<Entity>AccessControlHandler.php` (basic/plus) or the
  advanced access handler, `src/<Entity>StorageSchema.php`, `templates/<entity>.html.twig`.
- For non-basic modes, the bundle config entity plus its interface, list builder, form and delete form,
  and a controller: `src/Entity/<Entity>Type.php`, `src/<Entity>TypeInterface.php`,
  `src/<Entity>TypeListBuilder.php`, `src/Form/<Entity>TypeForm.php`,
  `src/Form/<Entity>TypeDeleteForm.php`, `src/Controller/<Entity>Controller.php`.

## How the code is produced
Each file is a PHP heredoc template in `ContentEntityBuilderExportHelper`, filled by `strtr()` with the
type's machine name (`@entity_name`), studly class name (`@EntityName`), module name (`@module_name`),
label, entity keys and paths. Base field definitions come from each field plugin's
`exportCode($translatable, $revisionable)` (concatenated into `@fields_code`). The generated classes are
standard `@ContentEntityType`-annotated entities with real access control handlers, so the exported
module is self-contained and no longer depends on content_entity_builder at runtime (the generated
`hook_install` removes the builder's `content_type` config for the exported ids).
