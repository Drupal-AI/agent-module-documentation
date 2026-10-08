<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities Import Type — config entity, forms, routes, permissions

The `entities_import_type` **config entity** stores one reusable spreadsheet→entity mapping.
Source: `src/Entity/EntitiesImportType.php`, `config/schema/entities_import_type.schema.yml`,
`src/Form/EntitiesImportTypeForm.php`, `entities_import.routing.yml`, `entities_import.permissions.yml`.

## Install / enable

- `composer require drupal/entities_import` (pulls **`phpoffice/phpspreadsheet ^1.16`** — required, per
  `composer.json`), then enable the `entities_import` module. Manage types at
  **Structure → Entities Import Type** (`/admin/structure/entities-import`).

## The config entity

`@ConfigEntityType(id = "entities_import_type", config_prefix = "entities_import_type",
admin_permission = "administer site configuration")`. Handlers: list builder
`EntitiesImportTypeListBuilder`, forms `EntitiesImportTypeForm` (default/add/edit) and
`EntitiesImportTypeDeleteForm`, route provider `EntitiesImportTypeHtmlRouteProvider` (extends
`AdminHtmlRouteProvider`). `config_export` / schema keys:

- `id`, `label`, `uuid` — identity.
- `entity_type` — `content_type` or `taxonomy` (radios).
- `content_type` — target node bundle (machine name) when `entity_type = content_type`.
- `taxonomy` — target vocabulary id when `entity_type = taxonomy`.
- `language_code` — target langcode (only when the `language` module is enabled; the form makes it
  required in that case).
- `unique_value_fields` — textarea, one field machine name per line; used to decide create-vs-update by
  matching existing entities on those field values.
- `title` — the spreadsheet column/field whose value becomes the node title / term name; if blank, the
  unique-value fields are joined with `-` to build the title (`FileUploadForm::getTitleArrayIndex()`).
- `file_path` — folder name under `public://` (e.g. `article-images`) used to build file/image field
  URIs.
- `file` — an optional stored sample/template managed file.

## Routes & permissions

Config-entity routes come from `EntitiesImportTypeHtmlRouteProvider` + the entity `links`
(`/admin/structure/entities-import`, `/add`, `/{entities_import_type}`, `/edit`, `/delete`). The
collection route requires the entity's admin permission — **`administer site configuration`** — so
creating/editing/deleting import types is an admin-only action.

The **run** route is separate:

```
entities_import.file_upload:
  path: '/admin/entities-import/upload'
  defaults: { _form: '\Drupal\entities_import\Form\FileUploadForm', _title: 'File Upload' }
  requirements: { _permission: 'Access Entities Import' }
```

The single permission `Access Entities Import` is declared in `entities_import.permissions.yml`. The
edit form (`EntitiesImportTypeForm::form()`) renders an **"Import {id}"** link to this route with the
import-type id passed as the `type` query argument (`Url::fromRoute('entities_import.file_upload',
['type' => $entity->id()])`).

## Config export example

```yaml
# config/install or a config export: entities_import.entities_import_type.article_import.yml
langcode: en
status: true
id: article_import
label: 'Article import'
entity_type: content_type
content_type: article
taxonomy: ''
language_code: en
unique_value_fields: |
  title
title: title
file_path: article-images
file: null
```

## Helpers this config drives

- `FieldDetails::getReferenceFieldBundle()/getFieldCardinality()/getFieldType()` inspect the target
  bundle's field definitions to know how to map each column.
- `EntitiesImportTypeForm::save()` marks any uploaded sample `file` permanent and redirects to the
  collection. Content-type and vocabulary option lists come from `getContentTypeList()` /
  `getVocabularyList()`.
