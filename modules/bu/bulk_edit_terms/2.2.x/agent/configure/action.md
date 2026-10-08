<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The action, confirm form, update modes & settings

## Run it (UI)

1. Go to **Content** (`admin/content`), tick the nodes to change.
2. In **Action** choose *"Update term references for the selected content."*, click **Apply**.
3. On the confirm form (`/admin/node/select/terms`) each **taxonomy-term entity-reference field**
   that exists on at least one selected node is listed. For each field pick an **update mode** and,
   where relevant, the term value(s).
4. Submit. Changes apply only to nodes that have the field.

## Action plugin

`src/Plugin/Action/EditTermsNode.php` — `#[Action(id: 'node_edit_terms_action', type: 'node',
confirm_form_route_name: 'node.select_taxonomy_terms')]`.
- `executeMultiple()` stores the selected node IDs in `tempstore.private` collection
  `node_edit_terms` keyed by current user id, then the confirm form reads them.
- `access()` loads the node's **latest revision** and returns `$node->access('update', $account)` —
  so the action is only offered/allowed on nodes the user can update.

The optional config `config/optional/system.action.node_edit_terms_action.yml` provides the ready-made
action entity (id `node_edit_terms_action`, label "Update taxonomy terms", depends on `node`).

## Update modes (`UpdateAction` enum)

`src/UpdateAction.php`: `none` (leave unchanged), `clear` (empty the field), `replace` (set to the
chosen value), `append` (add to existing multi-values), `remove` (delete a specific value).
Default behaviour: multi-value fields append; single-value fields are replaced.

## Access enforcement

In `NodeSelectTerms` the field list and the apply loop both check
`$node->get($fieldName)->access('edit', $currentUser)` — a field is skipped for any node where the
user lacks field-edit access. Combined with the action's node `update` check, an editor can only
change term fields on nodes/fields they are already permitted to edit.

## Settings

- Route `bulk_edit_terms.config_form` → `/admin/config/content/bulk_edit_terms`
  (`BulkEditTermsConfigForm`), permission **`administer bulk edit terms`**, linked under
  *Configuration › Content authoring*.
- Config object `bulk_edit_terms.settings`:
  - `multi_value_widget_type` (string, default `entity_autocomplete`) — the form widget used to
    collect values for multi-value term fields on the confirm form.

```yaml
# config: bulk_edit_terms.settings
multi_value_widget_type: 'entity_autocomplete'
```

## Permissions

- `administer nodes` (core, `restrict access: true`) — gates the action and the confirm form.
- `administer bulk edit terms` (this module) — gates only the widget-type settings form.
