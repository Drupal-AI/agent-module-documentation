<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Visual Editor opens Drupal's standard node edit form in an off-canvas sidebar while you view a node's decoupled preview iframe, and lets clicking a component in that preview jump the sidebar form to the matching field — the `visual_editor_paragraphs` submodule adds per-paragraph targeting.

---

Visual Editor is a thin editing-UI layer, not a page builder and not a text editor. It requires `decoupled_preview_iframe`, which renders a node's front-end preview inside an iframe on the node view page. On node views whose bundle has preview enabled (in the `default` or `full` view mode), Visual Editor attaches its JavaScript and, optionally, opens an off-canvas dialog on page load. That dialog loads `/visual_editor/form/node/{node_uuid}/edit`, which renders the **ordinary `NodeForm`** through a dedicated `visual_editor` form display and a `NodeEditForm` subclass. Because it reuses core's node form, every field is edited as a normal structured field value — text formats, validation, revisions, moderation and translation all behave exactly as they do on `/node/{nid}/edit`; there is no separate markup store and no bypass of the field system. The form is submitted over AJAX; on success the JS reloads the page so the preview reflects the saved node. The distinctive piece is a `window` `message` listener: the decoupled front end can `postMessage` a `VISUAL_EDITOR_COMPONENT` event (with a paragraph UUID) to expand and scroll to that component's widget in the sidebar, or a `VISUAL_EDITOR_COMPONENT_ORDER` event to re-sync the paragraph drag-and-drop order after reordering in the preview. The submodule stamps `data-visual-editor-uuid` / `data-visual-editor-storage` attributes onto paragraph widget rows so the JS can find them. Access to the edit route is gated by a real per-node `update` check; the only permission the module defines a route for is `administer site configuration`, guarding a small settings form (two checkboxes: disable the default off-canvas CSS, and auto-open the dialog on page load). Scope is node-only.

---

- Requires `decoupled_preview_iframe`; that module supplies the front-end preview iframe this one edits alongside.
- Only nodes are supported — `hook_entity_type_build()` registers a `visual_editor` form class on the `node` entity type and nothing else.
- The editor is Drupal's own `NodeForm`, subclassed as `NodeEditForm`, rendered through a `visual_editor` form display mode.
- Because it is the standard node form, edits are ordinary structured field values: text formats, field validation, revisions, moderation state and translation all work normally — no markup soup, no field-system bypass.
- The off-canvas dialog is loaded from route `visual_editor.node_edit` at `/visual_editor/form/node/{node_uuid}/edit`, keyed by the node's UUID.
- Route access is `EntityForm::access`, which loads the node by UUID and returns `$node->access('update', $account)` — proper per-node edit access, not a blanket permission.
- The dialog form hides the Delete button, hides Preview unless editing the latest revision, and adds a Close and a Cancel (discard) action; submit is AJAX (`::ajaxSubmit`).
- On successful save the JS `visualEditorReload` handler navigates to `/node/{id}` to refresh form state and avoid the "content modified by another user" concurrency error.
- The module reads `?preview=true` and pulls a previewed form state from the `node_preview` temp store, so it can edit an unsaved preview of the node.
- If the viewed revision is not the latest, the form loads and edits the latest revision instead.
- A `window` `message` listener drives two front-end→back-end interactions: `VISUAL_EDITOR_COMPONENT` (open/expand/scroll to a paragraph by UUID) and `VISUAL_EDITOR_COMPONENT_ORDER` (re-apply a new paragraph order to the tabledrag select widgets).
- The `visual_editor_paragraphs` submodule (depends on `paragraphs`) adds `data-visual-editor-uuid` and `data-visual-editor-storage="paragraph"` to paragraph field-widget rows during the AJAX edit-form render, which is what the message listener targets.
- Settings live in `visual_editor.settings`: `disable_styles` (drop core's off-canvas CSS via `hook_library_info_alter`) and `open_load` (auto-open the dialog on node view). No config schema ships.
- The settings form is at `/admin/config/visual_editor/settings` (menu link under Configuration » Services) and requires `administer site configuration`.
- A JS toggle (`#dialog-toggle`) expands/collapses the off-canvas panel between 440px and 1200px widths.
- `hook_form_alter` moves the moderation-state field into the meta group; `hook_theme` + a `visual-editor--dialog` template render the breadcrumb/menu plus the form.
- Sidebar chrome is styled by `css/dialog-overrides.css`, which hard-codes some Gin-admin-theme selectors (e.g. `--gin-toolbar-y-offset`).
- Install sets the module weight to 10 so its hooks run after related modules.
- Core requirement is `^10 || ^11` (the paragraphs submodule declares `^9 || ^10 || 11`); no non-Drupal PHP library dependencies.
- Practical fit: sites already using `decoupled_preview_iframe` (typically Paragraphs-based landing pages with a decoupled or iframe-rendered front end) that want editors to edit in a sidebar next to a live-ish preview rather than on the bare form page.
