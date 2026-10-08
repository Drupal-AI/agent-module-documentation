<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Inline Entity Form Dialog widget

1. Enable the module: `drush en inline_entity_form_dialog -y`.
2. Go to **Manage form display** for a bundle that has an `entity_reference` field.
3. On that field's row change the widget to **Inline Entity Form Dialog**.
4. Click the gear icon to set widget options.

## Widget settings
| Setting | Default | Meaning |
|---|---|---|
| Form mode | `default` | Entity form display mode rendered inside the dialog. Create a trimmed mode (e.g. `inline_dialog`) for a focused UX. |
| Allow adding new entities | Yes | Shows the "Add" button (auto-hidden when field cardinality is reached). |
| Allow editing existing entities | Yes | Shows "Edit" on each item row. |
| Dialog width (px) | 800 | Modal width, clamped to a 300px minimum. |

## How it behaves
- **Add** opens the target entity's add form in a modal; on save the row is appended without a page reload.
- **Edit** opens the entity's edit form in a modal.
- **Remove** removes only the reference row, never deletes the entity.
- Rows are reorderable via `Drupal.tableDrag`; order is persisted on parent submit.
- The parent form stores only a JSON id array in a hidden input and is never rebuilt.

## Access caveat
The `add`/`edit` routes require only `access administration pages`. They do not re-check that the user may create the requested bundle or update the requested entity, so restrict that permission to trusted roles.
