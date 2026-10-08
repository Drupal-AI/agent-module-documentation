<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Previewer adds a **Preview** button to every paragraph row of a Paragraphs field widget, opening a modal that renders that single (unsaved) paragraph with the front-end theme.

---

The module ships no entity type, no settings form and no configure route. It works entirely by providing three replacement field widgets for `entity_reference_revisions` fields: `paragraphs_previewer` (subclass of the modern `ParagraphsWidget`), `entity_reference_paragraphs_previewer` (subclass of the legacy `InlineParagraphsWidget`) and `paragraphs_previwer` (a misspelled, deprecated alias that `hook_form_entity_form_display_edit_form_alter()` hides from the widget dropdown). All three share `ParagraphsPreviewerWidgetTrait`, which injects an AJAX submit button labelled *Preview* into each paragraph row's action area and defaults the widget's `edit_mode` setting to `closed`. Clicking it rebuilds the form, then `ajaxSubmitPreviewerItem()` returns an `OpenModalDialogCommand` whose content is an `<iframe>` (theme hook `paragraphs_previewer_modal_content`) pointing at the route `paragraphs_previewer.form_preview` — `paragraphs-previewer/form/{form_build_id}/{element_parents}`, guarded by a CSRF token and the `view any paragraphs previewer` permission. `ParagraphsPreviewController::onForm()` pulls the cached form, finds the in-progress `Paragraph` entity in the widget state, clones the parent entity, substitutes the single paragraph into the parent's field and renders that field item with the view mode from `paragraphs_previewer.settings:previewer_view_mode` (default `full`). Because the preview page reuses the front-end theme but strips `page_top`, `page_bottom` and every non-`system_main_block` block, it shows the paragraph's own markup without surrounding node chrome. The dialog is full-width, draggable and resizable so responsive designs can be checked before the host entity is ever saved.

---

- Let editors preview a single paragraph's rendered output before saving the node.
- Check a hero/banner paragraph's design without publishing a draft.
- Verify a card or callout paragraph renders correctly right after adding it.
- Resize the modal to test how a paragraph behaves at tablet and mobile widths.
- Preview a paragraph nested inside another paragraph (the controller walks up through `subform` parents).
- Preview paragraphs on a node form, a taxonomy term form, a media form or any entity with a Paragraphs field.
- Give reviewers a modal preview instead of teaching them the full node preview flow.
- Switch the previewer to render with the `teaser` view mode instead of `full` for compact previews.
- Restrict who may open previews with the `view any paragraphs previewer` permission.
- Replace the stock **Paragraphs** widget with **Paragraphs Previewer** on one bundle only, leaving others untouched.
- Keep using the legacy `entity_reference_paragraphs` widget while still adding previews (`entity_reference_paragraphs_previewer`).
- Migrate an old site off the misspelled `paragraphs_previwer` plugin id via `paragraphs_previewer_update_8001()`.
- Default a paragraphs widget to *Closed* edit mode so rows are collapsed and previewed rather than expanded.
- Debug why a paragraph type's template produces empty markup, without saving revisions.
- Compare two paragraph variants side by side by previewing each row in turn.
- Let a content team validate a landing page built from a dozen paragraphs before it goes live.
- Preview a paragraph that references media so image styles and captions can be sanity-checked.
- Add previewing to a Layout-Builder-adjacent workflow where paragraphs supply the page sections.
- Avoid the "save, view, go back and edit" loop when authoring long paragraph stacks.
- Provide previewing on a translation form for a not-yet-saved translated paragraph.
- Attach preview styling only where needed via the `paragraphs_previewer/widget`, `/dialog` and `/preview-page` libraries.
- Ship a per-field-mode configuration where the default form display previews but a custom form mode does not.
- Give a design QA role preview access without granting node edit rights on production content.
