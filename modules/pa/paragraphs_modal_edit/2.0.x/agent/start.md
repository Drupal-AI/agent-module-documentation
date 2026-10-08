# Paragraphs Modal Edit — agent index

Extends **Paragraphs Edit** so a rendered paragraph's contextual edit/clone/delete links open the
Paragraphs Edit forms in a Drupal AJAX **modal dialog** and re-render just that paragraph on save.
Pure hook-based UX layer. Depends on `paragraphs` + `paragraphs_edit` (+ Entity Reference Revisions).
No permissions, Drush, or plugins.

- **The one setting (`modal_width`), its route/permission, and how the modal + AJAX callbacks work** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `paragraphs_modal_edit.settings` → `modal_width` (int 6–10 = 60%–100%, default 9). Route `paragraphs_modal_edit.settings` at `/admin/config/user-interface/paragraphs-modal-edit`, perm `administer site configuration`.
- Behavior in `src/Hook/ParagraphsModalEditHooks.php`: `paragraph_view_alter` adds the `paragraph` contextual-links group + dialog libraries; `contextual_links_view_alter` marks links `use-ajax` + `data-dialog-type=modal`; on XHR requests `form_alter`/`form_paragraph_form_alter` swap submit to AJAX callbacks `ajaxUpdate`/`ajaxRemove` (close dialog, ReplaceCommand/RemoveCommand, redirect to referer).
- `paragraph_update` bumps the parent node's changed time when edited via the modal route.
