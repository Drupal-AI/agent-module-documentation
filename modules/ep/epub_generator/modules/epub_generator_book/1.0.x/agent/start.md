<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePub Generator: Book Integration (epub_generator_book) — agent index

Assembles a **core Book** outline into a single multi-chapter **ePub**. Package `Content`,
core `^11.1`. Depends on `epub_generator`, `node`, and `book`. License GPL-2.0-or-later.
Version 1.0.x. Configure at `epub_generator_book.field_mapping`.

- **Assembler service, field mapping, field installer, mapping form** →
  [api/assembler.md](api/assembler.md)

## What it is (from source)

- **Service `epub_generator_book.book_assembler`** = `BookEpubAssembler`
  (`src/BookEpubAssembler.php`): the base module's `EpubNodeDownloadController` and Drush
  `epub:generate-book` delegate to it when a node belongs to a book. Walks the tree with
  `book.manager`, renders each published in-outline node, and calls `epub_generator.generator`.
- **Service `epub_generator_book.field_installer`** = `BookMetadataFieldInstaller`
  (`src/BookMetadataFieldInstaller.php`): the one-click setup that creates + maps the canonical
  metadata field set on a content type (idempotent; reports created/existing/skipped/conflicts).
- **`BookFieldMappingForm`** (`src/Form/BookFieldMappingForm.php`) at
  `/admin/config/content/epub-generator/book-field-mapping` (perm `administer epub generator`).
- **Hooks** in `src/Hook/EpubGeneratorBookHooks.php`. Drush `epub:setup-book-fields <bundle>`
  (alias `epub-sbf`) in `src/Drush/Commands/EpubGeneratorBookCommands.php`.

## How assembly works

- `isBookNode()` / `getBookId()` use `book.manager->loadBookLinks()`.
- `buildChapters()` → `walkTree()` over `bookTreeAllData($bid)`: skips the root (metadata only),
  skips unpublished nodes and non-enabled bundles, renders each node (epub→full view mode) with
  `renderer->renderInIsolation()`, prepends a clean `<h1 class="epub-chapter-title">`, and records
  an `EpubChapter` with the outline `depth` as its `level`.
- `buildMetadata()` reads root-node fields via the resolved mapping (`getFieldMapping()` = default
  overlaid with per-bundle overrides).

## Config (`epub_generator_book.settings`)

`config/install` + `config/schema`: `field_mapping` (default map of ePub property → field machine
name), `bundle_field_mapping` (per-node-type override maps), `generate_title_page` (bool). Default
map targets `field_book_author`, `field_isbn`, `field_book_publisher`, `field_copyright`,
`field_cover_image`, `field_subtitle`, `field_edition`, `field_book_description`,
`field_epub_strip_selectors`, `field_epub_layout`, `field_viewport_width/height`,
`field_epub_spread`, `field_epub_orientation`. `epub_generator_book_update_10301()` adds the
strip-selectors key + the override container.

## No new permissions or routes beyond the mapping form

Download happens through the base module's `epub_generator.node_download` route (perm `generate epub`);
this submodule only changes what that route produces for book nodes. Menu/task links in
`epub_generator_book.links.menu.yml` / `.links.task.yml`.
