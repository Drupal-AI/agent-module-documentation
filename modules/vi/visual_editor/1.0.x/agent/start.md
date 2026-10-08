<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visual Editor (visual_editor) — agent index

Off-canvas **node** editing next to a **decoupled preview iframe**. Not a page builder, not a
text/WYSIWYG editor, not a CKEditor plugin, not core in-place editing.

## What it actually is
- Hard dependency on **`decoupled_preview_iframe`**, which renders a node's front-end preview in
  an iframe on the node view page. Visual Editor rides on top of that.
- `hook_entity_type_build()` registers a `visual_editor` **form class** (`NodeEditForm extends
  \Drupal\node\NodeForm`) on the `node` entity type only.
- `hook_node_view_alter()` attaches the `visual_editor/node_view` JS + `drupalSettings` on views
  of preview-enabled bundles in the `default`/`full` view mode.
- The JS opens an **off-canvas dialog** loading route `visual_editor.node_edit`
  (`/visual_editor/form/node/{node_uuid}/edit`), which renders the ordinary node form through a
  `visual_editor` form display. Submit is AJAX; on save the page reloads to `/node/{id}`.
- A `window` `message` listener lets the decoupled front end drive the sidebar: `postMessage`
  a component UUID to expand/scroll to that paragraph's widget, or a new order to re-sync the
  paragraph tabledrag. The `visual_editor_paragraphs` submodule stamps the target
  `data-visual-editor-uuid` attributes onto paragraph widget rows.

## Key correction vs. naive assumptions
- It edits through **core's `NodeForm`**, so edits are ordinary **structured field values** —
  text formats, validation, revisions, moderation and translation all behave exactly as on
  `/node/{nid}/edit`. There is **no separate markup store** and **no bypass** of the field system.
- Scope is **nodes only**. There is no generic entity editor despite the `EntityForm` controller
  name.

## Routes & access
- `visual_editor.node_edit` — `_custom_access` = `EntityForm::access`, which loads the node by
  UUID and returns `$node->access('update', $account)`. Proper per-node edit gate.
- `visual_editor.settings` — `administer site configuration`. See [configure/settings.md](configure/settings.md).

## Config
- `visual_editor.settings`: `disable_styles` (bool), `open_load` (bool). No config schema ships.

## Files worth reading
- `visual_editor.module` — hooks, theme, AJAX close/discard callbacks, form class registration.
- `src/Controller/EntityForm.php` — access check + dialog render.
- `src/Form/NodeEditForm.php` + `src/FormEditTrait.php` — the subclassed node form, preview/latest-revision handling.
- `js/visual_editor.node_view.js` — dialog open/toggle + the postMessage protocol.
- `modules/visual_editor_paragraphs/` — paragraph-row targeting (depends on `paragraphs`).

## Detail docs
- [configure/settings.md](configure/settings.md) — the two settings and how they behave.
- [api/postmessage.md](api/postmessage.md) — the front-end → back-end `postMessage` contract.
