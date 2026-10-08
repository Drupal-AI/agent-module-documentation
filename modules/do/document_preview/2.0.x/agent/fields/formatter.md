<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Preview Formatter (document_preview_formatter)

The module's core feature: a field formatter that renders a **core file field** as an in-browser
document preview via the Google Docs viewer. Source:
`src/Plugin/Field/FieldFormatter/DocumentPreviewFieldFormatter.php`.

## Plugin

- Attribute `#[FieldFormatter(id: 'document_preview_formatter', label: 'Document Preview Formatter',
  field_types: ['file'])]` — targets **`file`** fields only.
- `class DocumentPreviewFieldFormatter extends FileFormatterBase implements
  ContainerFactoryPluginInterface`.
- `create()` injects the **`file_url_generator`** service (`$this->fileUrlGenerator`).

## Setting

- `defaultSettings()`: `['view_type' => 'simplebox'] + parent::defaultSettings()`.
- `settingsForm()`: one `select` named **`view_type`** with options `simplebox` → *"Simplebox"* and
  `modal` → *"Modal window"*.
- `settingsSummary()`: prints *"Render document in Simplebox"* or *"Render document in Modal Window"*.
- No config schema ships for this setting (no `config/schema/`), so the value is stored via core's
  generic field-formatter settings handling.

## Rendering (`viewElements()`)

For each file from `getEntitiesToView($items, $langcode)` (so core file/display access is honored):

1. Reads target entity type, bundle, field name, field type from `$this->fieldDefinition`, plus the
   file's `getFileUri()` and `getFileName()`.
2. `StreamWrapperManager::getScheme($file_uri)` — **only `public` is rendered**. Any other scheme
   (e.g. `private`) skips the preview and calls
   `messenger()->addError('The file (%file) is not publicly accessible… Google Docs viewer…')`.
3. For public files, builds the absolute URL with
   `$this->fileUrlGenerator->generateAbsoluteString($file->getFileUri())` and returns a
   `#theme => 'document_preview_field'` element passing `url`, `filename`, `delta`, `entity`,
   `bundle`, `field_name`, `field_type`, `view_type`, and attaching `document_preview/document-preview`.

## Template (`templates/document-preview-field.html.twig`)

Branches on `view_type`:

- **`simplebox`** → inline
  `<iframe class="document-preview-field" src="https://docs.google.com/viewer?url={{ url }}&embedded=true">`
  plus a `Download` link to `url`.
- **`modal`** → a `<a class="use-ajax" href="{{ path('document_preview.modal', {}, {'query': {'url': url}}) }}">{{ filename }}</a>`
  — clicking opens the file in the AJAX modal (see [../api/modal-route.md](../api/modal-route.md)).

Theme suggestions (from `DocumentPreviewHooks::themeSuggestionsDocumentPreview`) allow overrides like
`document_preview_field__<entity>`, `__<entity>__<bundle>`, `__<entity>__<bundle>__<delta>`,
`__<field_type>`, `__<field_type>__<field_name>`, `__<field_type>__<field_name>__<delta>`.

## How to attach a preview to content

1. `drush en document_preview -y` (pulls core `field` + `file`).
2. Add a **file field** to your entity/bundle (e.g. a content type or a custom block type — the
   module does **not** create a block type for you; create it under *Structure → Block types* if you
   want one).
3. On that bundle's **Manage display**, set the field's format to **"Document Preview Formatter"** and
   pick **Simplebox** or **Modal window**.
4. Upload documents to a **public** file field (files on `private://` will not preview — Google must
   be able to fetch the URL, so this also fails on local-only environments).
