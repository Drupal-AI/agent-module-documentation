<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book assembler, field mapping & field installer (epub_generator_book)

## `BookEpubAssembler` (service `epub_generator_book.book_assembler`)

`src/BookEpubAssembler.php`. Args (`epub_generator_book.services.yml`): `@book.manager`,
`@entity_type.manager`, `@renderer`, `@epub_generator.generator`, `@config.factory`, `@file_system`.
The base module's `EpubNodeDownloadController`, the Drush `epub:generate-book` command, and the
viewer's cache subscriber all pull this service optionally (`@?…` / `$container->has()`), so it is a
soft dependency.

- `isBookNode(NodeInterface): bool` and `getBookId(NodeInterface): ?int` via
  `book.manager->loadBookLinks([nid], FALSE)`.
- `generate(NodeInterface, array $options = []): string` and
  `generateDownloadResponse(NodeInterface, array $options = []): BinaryFileResponse` — both call
  `prepare()` then the base generator.
- `prepare()` resolves the book id, loads the **root** node, resolves the field mapping for the
  root's bundle, fills `generate_title_page` and per-book `strip_selectors` (from the mapped field),
  and returns `[EpubMetadata, EpubChapter[], options]`.
- `buildChapters($bid)` → `walkTree()` over `book.manager->bookTreeAllData($bid)`: the root node is
  skipped (metadata only); each other node that is **published** and whose bundle is
  `isBundleEnabled()` is rendered (`epub` view mode → `full` fallback) with
  `renderer->renderInIsolation()`; `stripLeadingTitleHeading()` drops a theme-rendered duplicate
  title, then a clean `<h1 class="epub-chapter-title">` is prepended; the outline depth becomes the
  chapter `level`.
- `buildMetadata()` reads root-node fields through helper extractors: `extractTextValues` (author,
  multi-value / entity-reference labels, owner fallback), `extractSingleValue`, `extractDescription`
  (renders the field so its text format runs; prefers a summary), `extractImagePath` (plain image
  field **or** a media reference unwrapped to its source file, resolved via
  `file_system->realpath()`), `extractIntValue`, and `extractSelectorList` (splits with
  `CssSelectorToXpath::splitList`).

## Field mapping (`getFieldMapping($bundle)`)

Two layers: the default `field_mapping` overlaid with `bundle_field_mapping[$bundle]`. The overlay is
per-property (a bundle names only the fields it differs on); an override value of `''` wins as
"this bundle has no such field", while `NULL` does not blank a default. Config
`epub_generator_book.settings` (schema reuses one `epub_generator_book.field_mapping` type for both
the default and each override, so the shapes cannot drift).

## `BookFieldMappingForm`

`src/Form/BookFieldMappingForm.php` at `/admin/config/content/epub-generator/book-field-mapping`
(perm `administer epub generator`). Sections: one-click **Set up metadata fields** (calls the
installer + `applyMapping`), **Default field mapping** + **Default layout field mapping** (free-text
field-machine-name inputs), and **Per-content-type overrides** (one collapsible group per
Book-allowed content type; blank = inherit, a lone `-` = opt-out), plus `generate_title_page`.
Field-name inputs are validated against `^[a-z][a-z0-9_]*$`. Book-allowed types come from
`book.settings:allowed_types` via `BookHelperTrait`.

## `BookMetadataFieldInstaller` (service `epub_generator_book.field_installer`)

`src/BookMetadataFieldInstaller.php`. `static getFieldDefinitions()` is the single source of truth for
the canonical fields (author `field_book_author` string cardinality -1; `field_subtitle`,
`field_isbn`, `field_book_publisher`, `field_copyright`, `field_edition` strings;
`field_cover_image` image [module `image`]; `field_epub_layout`/`_spread`/`_orientation` list_string
[module `options`]; `field_book_description` text_with_summary [module `text`];
`field_epub_strip_selectors` string_long; `field_viewport_width`/`_height` integer).

- `install($bundle): array{created,existing,skipped_modules,conflicts}` — idempotent: creates missing
  storages/instances, skips a field whose type module is disabled, and refuses to attach to a
  pre-existing storage of a different type (conflict). Places new widgets after existing components
  and saves the form display only when something was created.
- `applyMapping($bundle)` writes the canonical map as a **per-bundle override** (not the default), so
  running setup on a second content type never clobbers the first.

## Drush & install

- `epub:setup-book-fields <bundle>` (alias `epub-sbf`, `src/Drush/Commands/`) = the CLI equivalent of
  the one-click setup.
- `epub_generator_book_update_10301()` adds the strip-selectors mapping key and the override
  container; leaves an existing `description → body` mapping in place and warns.
- Book downloads themselves go through the base route `epub_generator.node_download` (perm
  `generate epub`); this submodule adds no download route. Hooks: `hook_help`.
