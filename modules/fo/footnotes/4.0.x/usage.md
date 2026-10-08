Footnotes lets content editors insert automatically numbered footnotes into rich-text via a CKEditor 5 button; a text-format filter then renders the references as superscript links and collects the notes into a numbered footer (or a dialog / a separate block).

---

The module has three cooperating pieces: (1) a **CKEditor 5 plugin** (`footnotes_footnotes`, toolbar item `footnotes`) that opens a dialog (route `footnotes.dialog`) to insert a `<footnotes>` element into the markup, with a live preview (route `footnotes.preview`); (2) a **text-format filter** `filter_footnotes` (TYPE_TRANSFORM_IRREVERSIBLE) that, at display time, replaces each footnote marker with a numbered superscript reference and appends a footnotes list, handling auto-numbering, duplicate-content collapsing, optional CSS, and optional dialog popups; and (3) a **Footnotes Group block** (`footnotes_group`) plus an `entity_extra_field_info` "footnotes" pseudo-field so the collected notes can be placed outside the body. Configuration lives entirely in the **text format**: you enable the `filter_footnotes` filter and the Footnotes CKEditor button on a format (the module ships an optional ready-made `footnote` format + editor). Filter settings include `footnotes_collapse` (merge identical notes), `footnotes_css` (load the bundled stylesheet), `footnotes_dialog` (show notes in a popup with `footnotes_dialog_prevent_bubbling`), `footnotes_footer_disable` (suppress the inline footer so the block/pseudo-field can render notes instead), and preview options (`footnotes_preview_show_text`, `footnotes_preview_character`). It also provides a Search API processor `footnotes_ignore_citations` to keep footnote text out of the search index, four overridable Twig templates, a Twig spaceless fallback, and a Drush command `footnotes:upgrade-3-to-4` (with `hook_footnotes_upgrade_3x4x_build_alter`) to migrate content authored with the 3.x markup. No configure route and no permissions of its own — depends on `ckeditor5`, `editor`, and `media`.

---

- Add scholarly-style numbered footnotes to article body text through the CKEditor toolbar.
- Automatically number footnote references in the order they appear, with links to the notes list.
- Collect all footnotes into a numbered list at the bottom of a post.
- Collapse repeated identical footnotes into a single numbered note with back-references (`footnotes_collapse`).
- Show a footnote's text in a popup dialog on click instead of jumping to the footer (`footnotes_dialog`).
- Prevent click-event bubbling when using footnote dialogs (`footnotes_dialog_prevent_bubbling`).
- Move the footnotes list out of the body and render it via the Footnotes Group block.
- Disable the inline footer (`footnotes_footer_disable`) and place notes anywhere with the block or Twig Tweak.
- Render footnotes as an entity "extra field" so they appear as a configurable component in the display.
- Provide a ready-to-use "Footnote" text format for editors without configuring one from scratch.
- Add the Footnotes button to an existing CKEditor 5 format (e.g. Full HTML) for authors.
- Preview footnote content inline while editing, including the reference text (`footnotes_preview_show_text`).
- Customize the preview marker character shown in the editor (`footnotes_preview_character`).
- Load or skip the module's bundled footnote CSS depending on your theme (`footnotes_css`).
- Keep footnote/citation text out of Search API indexes with the "Ignore citations" processor.
- Override footnote markup by providing your own `footnote-list`, `footnote-link`, `footnote-links`, or `footnote-dialog` templates.
- Group footnotes across multiple fields/blocks on a page via the group block's JS grouping (`group_via_js`).
- Migrate legacy 3.x footnote content to 4.x markup in bulk with `drush footnotes:upgrade-3-to-4 node`.
- Alter each upgraded footnote's render array during migration via `hook_footnotes_upgrade_3x4x_build_alter()`.
- Add references to taxonomy term or paragraph rich-text fields, not just nodes.
- Provide legal or academic citations on long-form content with consistent formatting.
- Let editors insert footnotes without writing any HTML by hand.
- Ensure duplicate citations (same source cited twice) reuse one footnote number.
- Place a "References" section in the sidebar using the Footnotes Group block.
