Paragraphs Modal Edit extends the Paragraphs Edit module so that a rendered paragraph's contextual "edit / clone / delete" links open the Paragraphs Edit forms inside a Drupal AJAX modal dialog instead of a full-page navigation.

---

The module is a thin UX layer with no forms of its own for content editors — it works entirely through hooks (`src/Hook/ParagraphsModalEditHooks.php`). `hook_paragraph_view_alter` attaches `core/drupal.ajax` + `core/drupal.dialog.ajax` and adds a `paragraph` contextual-links group (using `paragraphs_edit`'s `ParagraphLineageInspector` to find the root parent entity and its route parameters), except on the paragraph edit route itself. `hook_contextual_links_view_alter` then rewrites those links to `class="use-ajax"` with `data-dialog-type="modal"` and a `data-dialog-options` width. When the request is an AJAX/XHR one, `hook_form_alter`/`hook_form_paragraph_form_alter` swap the submit buttons of the paragraph edit, clone and delete forms to AJAX callbacks (`ajaxUpdate`, `ajaxRemove`) that close the dialog, re-render just the affected paragraph via a `ReplaceCommand`/`RemoveCommand`, and redirect back to the referer. `hook_paragraph_update` bumps the parent node's changed time when a paragraph is edited through the modal. The only setting is `modal_width` (`paragraphs_modal_edit.settings`), a select of 6–10 mapped to 60%–100%, edited at `/admin/config/user-interface/paragraphs-modal-edit` (permission `administer site configuration`). Requires Paragraphs and Paragraphs Edit (and Entity Reference Revisions). No permissions, Drush, or plugins.

---

- Edit a paragraph in a modal dialog straight from where it renders on the page.
- Clone a paragraph via the contextual menu without leaving the page.
- Delete a paragraph in a confirm modal, removing it from the DOM on success.
- Give content editors an in-place editing experience for Paragraphs content.
- Avoid full-page reloads when tweaking one paragraph among many.
- Re-render only the edited paragraph after save via AJAX replace.
- Keep the editor's scroll position when editing deeply nested paragraphs.
- Set the modal width (60/70/80/90/100%) to suit wide paragraph forms.
- Widen the dialog for paragraphs with many fields or media.
- Update the parent node's "changed" timestamp when a paragraph is modal-edited.
- Reuse Paragraphs Edit's per-paragraph edit routes without its default full-page UX.
- Edit paragraphs nested inside other paragraphs (root-parent lineage resolved automatically).
- Provide editors contextual edit links on the front-end rendered entity.
- Close the dialog automatically after a successful save/clone/delete.
- Return the editor to the originating page (referer) after the action.
- Layer modal editing onto an existing Paragraphs-based landing-page workflow.
- Reduce clicks for editors managing long paragraph stacks.
- Keep validation errors inside the modal (form is re-shown on error).
- Offer a lighter alternative to full inline Paragraphs form widgets.
- Standardize paragraph editing UX across content types with one module.
