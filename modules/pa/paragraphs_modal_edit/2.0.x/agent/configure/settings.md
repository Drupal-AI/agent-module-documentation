# Configure Paragraphs Modal Edit

Route `paragraphs_modal_edit.settings` → `/admin/config/user-interface/paragraphs-modal-edit`
(menu under *Configuration › User interface*), permission **`administer site configuration`**.
Form `ParagraphsModalEditSettingsForm`. Config object `paragraphs_modal_edit.settings`.

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `modal_width` | integer, one of `6,7,8,9,10` | `9` | Dialog width. Rendered as a percentage: the value is multiplied — `9` → `data-dialog-options='{"width":"90%"}'`. Select options are labelled 60%–100%. |

```bash
drush config:set paragraphs_modal_edit.settings modal_width 10 -y   # 100% wide dialog
```

Schema constrains the value to the choice set `6,7,8,9,10`.

## How it wires the modal (no config beyond width)

Everything runs from `src/Hook/ParagraphsModalEditHooks.php`:

- **`hook_paragraph_view_alter`** — on any route except `paragraphs_edit.edit_form`, resolves the paragraph's root parent via `paragraphs_edit.lineage.inspector` (`ParagraphLineageInspector::getRootParent`), adds a `#contextual_links['paragraph']` group with `root_parent_type`/`root_parent`/`paragraph` params, and attaches `core/drupal.ajax` + `core/drupal.dialog.ajax`.
- **`hook_contextual_links_view_alter`** — for the `paragraph` contextual-links group, sets each link's `class[] = use-ajax`, `data-dialog-type = modal`, and `data-dialog-options` width from `modal_width` (default `90%`).
- **`hook_form_alter` / `hook_form_paragraph_form_alter`** — only when the request is XHR (`isXmlHttpRequest()`): swap the submit `#ajax` callback of the paragraph edit form and the `paragraph_*_clone_form` to `ajaxUpdate`, and `paragraph_*_delete_form` to `ajaxRemove`.
- **AJAX callbacks** (`ajaxUpdate`, `ajaxRemove`, `ajaxCancel`, all `static`): on no validation errors, `CloseModalDialogCommand`, then re-render just the paragraph (`ReplaceCommand` on `[data-quickedit-entity-id="paragraph/<id>"]`) or `RemoveCommand`, and `RedirectCommand` to the request referer.
- **`hook_paragraph_update`** — when saved via route `paragraphs_edit.edit_form`, sets the parent node's changed time to now.

Note: the legacy `.module` file also implements `hook_contextual_links_view_alter` (default `60%`)
in parallel with the Hook class — behavior/width can depend on which fires in your core version.
