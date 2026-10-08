# Configure & use Layout Paragraphs Library

No settings form and no permissions of its own — behavior is driven by paragraph type config.

## Setup

1. Enable `paragraphs_library` (from the Paragraphs project) and `layout_paragraphs`.
2. Enable this submodule: `drush en layout_paragraphs_library -y`.
3. On each paragraph type you want to be reusable, turn on **Allow adding to library**
   (the `allow_library_conversion` third-party setting, provider `paragraphs_library`) at
   `/admin/structure/paragraphs_type/{type}`.
   - This option is force-hidden (`#access = FALSE`) on paragraph types that have the
     `layout_paragraphs` section behavior enabled — sections cannot be library items.

## Runtime behavior (all AJAX, native hooks in `layout_paragraphs_library.module`)

- **Promote to library** button appears on the Layout Paragraphs component add/edit form for a
  paragraph type when `allow_library_conversion` is true and it is *not* a section. Submitting
  it (`layout_paragraphs_library_submit`) creates a `LibraryItem::createFromParagraph()`, saves
  it, and replaces the component with a `from_library` paragraph referencing the item
  (`field_reusable_paragraph`). Component behavior settings are copied to the new component.
- **Unlink from library** button appears on `from_library` components; it swaps the reference
  back for an editable copy of the original paragraph.
- Both actions update the Layout Paragraphs tempstore
  (`layout_paragraphs.tempstore_repository`) and re-render the affected component via the
  builder's `successfulAjaxSubmit()`.

## Hooks it implements (for reference)

- `hook_form_layout_paragraphs_component_form_alter()` — adds the promote/unlink buttons.
- `hook_form_paragraphs_type_form_alter()` + a `#process` callback — hides
  `allow_library_conversion` on section paragraph types.
- `hook_library_info_alter()` — workaround wrapper (core issue #3502302).
