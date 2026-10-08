<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: front-end → back-end postMessage contract

Visual Editor's only "integration surface" is a `window` `message` listener in
`js/visual_editor.node_view.js` (`Drupal.behaviors.visualEditorListener`). A decoupled/iframe
front end drives the Drupal editing sidebar by posting messages to the parent window. Each message
must carry a `type`; unknown types are ignored.

## `VISUAL_EDITOR_COMPONENT`
Open/expand the sidebar edit widget for one paragraph and scroll it into view.
```js
parent.postMessage({ type: 'VISUAL_EDITOR_COMPONENT', uuid: '<paragraph-uuid>' }, '*');
```
Handler finds `tr[data-visual-editor-uuid="<uuid>"]`, clicks its parent field-group tab, triggers
the paragraph's edit (`mousedown` on `div.paragraphs-actions > input`), expands the dialog if it
was collapsed, and `scrollIntoView`s the row.

## `VISUAL_EDITOR_COMPONENT_ORDER`
Re-apply a new paragraph order to the tabledrag delta selects after reordering in the preview.
```js
parent.postMessage({
  type: 'VISUAL_EDITOR_COMPONENT_ORDER',
  changes: {
    active: { index: <from> },
    over:   { index: <to> },
    items:  { updated: ['<uuid0>', '<uuid1>', ...] }, // new order
  },
}, '*');
```
When `active.index !== over.index`, the handler writes each UUID's new index into its row's
`td.delta-order select`, then toggles "collapse all" to force the widget to re-sort.

## The targets these messages need
The `data-visual-editor-uuid` / `data-visual-editor-storage="paragraph"` attributes on widget
rows are added by the **`visual_editor_paragraphs`** submodule
(`hook_preprocess_field_multiple_value_form`), only during the AJAX render of the
`visual_editor.node_edit` route and only for paragraph widgets. Without that submodule (or for
non-paragraph fields) there are no rows to target.

## Outbound message
On successful AJAX save, `NodeEditForm::successfulAjaxSubmit()` invokes JS
`visualEditorReload('node', id)`, which navigates the parent page to `/node/{id}` (a full reload
to refresh form state, not a `postMessage` back to the iframe).
