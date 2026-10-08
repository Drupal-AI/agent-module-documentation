<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Node Form Overrides

## Global defaults
Route `node_form_overrides.settings` · `/admin/config/content/node-form-overrides`
Permission: `administer content types`. Keys in config `node_form_overrides.settings`:
- `insert_button` (default `Save`), `update_button` (default `Update`)
- `insert_title` (default `Add new [node:content-type:name]`)
- `update_title` (default `Edit this [node:content-type:name]`)
- `delete_form_title` (default `Are you sure you want to delete this [node:content-type:name]?`)
- `delete_form_description` (default `This action cannot be undone.`)

## Per content type
Edit any content type → **Label Overrides** tab (added by `hook_form_node_type_form_alter`).
Tick **Override global defaults**, then fill the same six fields. Stored as node_type
third-party settings under provider `node_form_overrides`. The entity builder only persists
the whitelisted keys (`override_global`, `insert_button`, `update_button`, `insert_title`,
`update_title`, `delete_form_title`, `delete_form_description`).

## Resolution order
`_node_form_overrides_get_setting($type, $key)`: if the type has `override_global` on and a
non-empty value, use it; otherwise fall back to global config.

## Tokens
If the Token module is enabled, values pass through the token service with `node` (and
`group` when a group route param exists) context — `replacePlain()` for titles/buttons,
`replace()` for the delete description. Without Token, raw strings are used. A token browser
link appears on the forms when Token is installed.

## Where each value applies
- New node form: `insert_button` (submit), `insert_title` (page title).
- Edit node form: `update_button`, `update_title`.
- Delete confirm form: `delete_form_title` (title), `delete_form_description` (description markup).
