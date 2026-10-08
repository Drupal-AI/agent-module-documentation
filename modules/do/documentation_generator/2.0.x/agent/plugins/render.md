<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render plugins (`DocumentationGeneratorRender`) & file download

A **render** plugin decides *how* the compiled chapters are emitted — the export format. This is the
second extensible plugin type.

## Plugin type wiring

- Manager service `plugin.manager.documentation_generator_render.processor` =
  `Plugin\DocumentationGeneratorRenderManager` (extends `DefaultPluginManager`); discovers plugins
  in `Plugin/DocumentationGeneratorRender`, interface
  `Plugin\DocumentationGeneratorRenderInterface`, annotation
  `Annotation\DocumentationGeneratorRender` (`@DocumentationGeneratorRender(id, label)`).
- Base class `Plugin\DocumentationGeneratorRenderBase` (thin; extends `PluginBase`).

## Interface contract

- `getExtension()` → file extension of the output (`'pdf'`, `'docx'`).
- `render($fileName, $path, $title, array $groups)` → build the document from `$groups` (the array
  of each available chapter's `elements()`) and write it; return TRUE on success.

`GenerateForm::submitForm()` names the file `documentation.<getExtension()>`, passes the realpath of
`private://` as `$path` and `"<site name> Documentation"` as `$title`.

## Built-in render plugins (`src/Plugin/DocumentationGeneratorRender/`)

- **`PDF`** (id `pdf`, label "PDF") — renders the `documentation` theme
  (`#theme => 'documentation'`, `#title`, `#groups`) to HTML, feeds it to **dompdf**
  (`documentation_generator.dompdf` service, `loadHtml` → `render` → `output`), and writes the bytes
  with `file.repository`'s `writeData()` to `private://<fileName>` (catches `FileException` → FALSE).
- **`Word`** (id `word`, label "Word") — builds a `.docx` directly with **PhpWord**
  (`documentation_generator.php_word` service): title styles + a TOC section, then one section per
  chapter group. It maps element `type => 'title'` to `addTitle(value, level)` and
  `type => 'paragraph'` to `addText(...)`, expanding `@parameter` tokens into `addLink()` /
  `addListItem()`. Text is passed through `Html::escape()` before `addText`/`addLink`. Saved via
  `IOFactory::createWriter($phpWord, 'Word2007')->save($path.'/'.$fileName)` (catches PhpWord
  `Exception` → FALSE).

Both write only to the **private** filesystem under the fixed names `documentation.pdf` /
`documentation.docx`.

## Downloading the generated file (`documentation_generator.module`)

`documentation_generator_file_download($uri)` implements `hook_file_download`. It returns download
headers **only** when the scheme is `private`, the target is exactly `documentation.docx` or
`documentation.pdf`, **and** the current user has `administer documentation generator`; otherwise it
returns nothing (core denies the private-file request). The generate form links to
`system.private_file_download` for the produced file, so the permission check runs on every
download.

## Add a new export format

Create a class in your module's `src/Plugin/DocumentationGeneratorRender/` with a
`@DocumentationGeneratorRender(id, label)` annotation extending `DocumentationGeneratorRenderBase`,
implement `getExtension()` and `render()`, and it automatically appears as a radio option on the
Generate form. If it should be downloadable through Drupal's private-file access, note that the core
module's `hook_file_download` only whitelists the two built-in filenames — a new extension/filename
needs its own `hook_file_download` (or a different delivery route) to be served from `private://`.
