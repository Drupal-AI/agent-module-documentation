# Per-content-type settings & node-form behavior

## Where you configure it

Content type edit form (`/admin/structure/types/manage/<type>`) → **Menu link settings**
vertical tab (added by `required_menulink_form_alter` on `node_type_add_form` /
`node_type_edit_form`). Three checkboxes:

| Checkbox | Third-party setting key | Effect |
|---|---|---|
| Require menu link | `require_menulink` | Enforce a menu link for every node of this type. |
| Do not enforce menu link | `soft_require` | Only pre-enable the menu link by default; do **not** force it. (Shown only when Require is checked.) |
| Disable automatic menu title | `disable_auto_menutitle` | Stop core auto-filling the menu title from the node title. |

Stored as node-type third-party settings under the `required_menulink` provider by the entity
builder `required_menulink_nodetype_entity_builder()`. Schema:
`config/schema/required_menulink.schema.yml` → `node.type.*.third_party.required_menulink`
(`require_menulink`, `soft_require`, `disable_auto_menutitle` — all boolean). Note: `soft_require`
is only persisted while `require_menulink` is on; unchecking Require clears both.

Read a setting programmatically with
`$node_type->getThirdPartySetting('required_menulink', 'require_menulink')`.

## Node form enforcement

`required_menulink_form_node_form_alter()` (only acts when `$form['menu']` is present — i.e.
the editing user has `menu_ui` access and the type allows menus):

- `require_menulink` on **and** `soft_require` off (hard require):
  - `$form['menu']['#open'] = TRUE` (fieldset expanded),
  - `$form['menu']['enabled']['#disabled'] = TRUE` and `['#value'] = 1` (checkbox forced on),
  - `$form['menu']['link']['title']['#required'] = TRUE` (title mandatory).
- `require_menulink` on **and** `soft_require` on (soft require):
  - `$form['menu']['enabled']['#default_value'] = 1` only (checkbox defaults on, not forced).
- `disable_auto_menutitle` on: attaches library `required_menulink/menu_ui.required_menulink`,
  whose JS sets `menuLinkAutomaticTitleOverridden` so core stops mirroring the node title into
  the menu title.

Enforcement is UI-level (`#required` / `#disabled` / forced `#value`) on the standard node
form; there is no entity-level constraint plugin, so alternative save paths (REST/JSON:API,
programmatic node saves) are not covered.

## Libraries

- `required_menulink/menu_ui.required_menulink` (`js/menu_ui.required_menulink.js`) — disables
  core's automatic menu title.
- `required_menulink/required_menulink.content_types` (`js/content_types.js`) — updates the
  vertical-tab summary text on the content type form.
