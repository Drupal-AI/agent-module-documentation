<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MDX "Load Document" dialog, media widget & sanitizer

## Install & enable

```bash
drush en document_loader_mdx -y   # pulls in document_loader_media
drush cr
```

Install-time check (`document_loader_mdx_requirements`, install phase only): fails unless the AI
module's `ui/mdxeditor/dist/assets/main.js` contains the string `drupal:mdx-fill` — i.e. AI 1.4+.
Also install a Document Loader **loader** plugin whose loaders emit markdown/text, or the dialog
has nothing to offer.

## Page attachments (`src/Hook/PageHooks.php`)

`#[Hook('page_attachments')]` (service-registered, D10-bridged in `.module` via `#[LegacyHook]`)
attaches on every page:

- library `document_loader_mdx/mdx_editor_button`;
- `drupalSettings.documentLoaderMdx.dialogUrl` = the `document_loader_mdx.dialog` route URL;
- `drupalSettings.documentLoaderMdx.iconPath` = the module's `icons/document-load.svg`.

The button JS injects the toolbar button wherever an MDXEditor textarea (`data-mdxeditor`) exists.

## The dialog form (`src/Form/DocumentLoaderMdxForm.php`)

Route `document_loader_mdx.dialog` (`/document-loader/mdx/dialog`, `_permission: 'access content'`).
`FormBase`, id `document_loader_mdx_form`.

- On build it stores `textarea_name` / `editor_id` from the request, then calls
  `DocumentLoaderManager::discoverSourceCategories()` and keeps only categories whose loaders
  support **markdown or text** (editor content is markdown).
- A **"Load from"** select (`source_category`) rebuilds the form via AJAX; switching categories
  clears stale field/`dl__` input.
- The active category's fields render either as the **media-library widget** (for `file`) or as
  schema-driven fields via `DocumentLoaderManager::buildSchemaFormElements()`. Per-loader options
  render via `buildLoaderOptionsFormSection('dl__', …, $type_ids)`.
- `output_format` / `max_length` are hidden (`markdown`, `0`).

### Media-library widget (`buildMediaLibraryWidget()`)

Opens the Drupal media library (allowed type `document`) through the
`document_loader_media.media_library.opener` service in a **nested** dialog (custom selectors
`#dl-media-library-modal` / `#dl-document-loader-dialog`) so dismissing it doesn't close the parent
modal. The opener writes selected media IDs into a hidden field and triggers a hidden update
button; `handleMediaSelection()` stores the first ID in `selected_media_id`.
`resolveMediaInputData()` loads the media, reads its source-field file, and returns
`['file_input' => $fileUri]`.

### Submit (`submitAjax()`)

Collects input (media → file_input; other categories → `collectSchemaFormValues()`).
`resolveFileUrlInput()` redirects a typed `url` to `file_input` when the URL path ends in a
supported document extension (so it is downloaded and parsed as a file rather than scraped).
Merges `dl__` loader options, calls
`DocumentLoaderManager::loadFromData($data, currentUser, 'markdown', 0, caller: 'mdx_editor')`,
runs the content through `MdxContentSanitizer::sanitize()`, then emits `CloseDialogCommand` +
`FillMdxEditorCommand($textareaName, $content)` + a status message.

## `MdxContentSanitizer` (`src/Utility/MdxContentSanitizer.php`)

Static `sanitize(string): string`. Splits content on fenced code blocks:

- **prose** → strips HTML comments (`<!-- -->`), strips HTML tags (`<...>`), and reduces
  `![alt](src)` images to their alt text;
- **code fences** → normalizes the fence info string, mapping aliases (shell→sh; yml/yaml/text/txt
  → none) and dropping any language not in the MDXEditor-supported allowlist (js/ts/css/html/json/
  python/bash/sh/sql/markdown/… ).

The sanitized markdown is inserted into the textarea value (not innerHTML) by the
`FillMdxEditorCommand` JS handler.
