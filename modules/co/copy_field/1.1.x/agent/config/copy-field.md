<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copy field — how it works & operation

Grounded in `copy_field.module`, `copy_field.routing.yml`, `copy_field.services.yml`,
`copy_field.links.task.yml`, `copy_field.libraries.yml`,
`src/Access/ConfigConditionCheck.php`, `src/Controller/CopyFieldListingController.php`.

## Install / enable

`drush en copy_field`. Requires core `node` (not declared in `copy_field.info.yml`,
but the module alters `node_type_edit_form` and upcasts `entity:node_type`).
clipboard.js is vendored under `clipboardjs/` — no external library to download.

## Enable per content type (opt-in)

The feature is off by default and enabled per bundle:

- `copy_field_form_alter()` (in `copy_field.module`) adds a `use_copy_field` checkbox
  ("Use copy field") to `node_type_edit_form`, defaulting to the current value of
  `node.type.<bundle>:use_copy_field`.
- `copy_field_node_type_form_submit()` saves the checkbox value back onto that same
  config object via `config.factory` `getEditable()`.

There is **no** module-owned settings form or config object; the flag lives on each
node type's own config (`node.type.<bundle>`), so it is exported/imported with the
content type. The module ships no `config/install` and no config schema for the key.

## Route, tab, and access

Route `copy_feld.entity_field_copy` (id contains the original "feld" typo):

```
path: /admin/structure/types/manage/{node_type}/copy-field
_controller: CopyFieldListingController::copyField
requirements:
  _permission: 'administer content types'          # core admin permission
  _custom_access: 'copy_field.config_condition_check::access'
options.parameters.node_type.type: entity:node_type
```

Both requirements must pass. The local task `copy_field.copy_field_tab`
("Manage Copy fields") is attached under `entity.node_type.edit_form`.

Custom access is the `copy_field.config_condition_check` service
(`Access\ConfigConditionCheck`, constructed with `@config.factory`, tagged
`access_check`). Its `access($node_type)` reads `node.type.<bundle>:use_copy_field`
and returns `AccessResult::allowed()` when truthy, else `forbidden()`, with cache
max-age 0 so toggling the checkbox takes effect immediately. Net effect: the tab is
reachable only by users with `administer content types` **and** only while the
bundle has the feature enabled.

## Controller output

`CopyFieldListingController::copyField($node_type)`:

- Injects `entity_field.manager` and `extension.list.module` (via `create()`).
- For a `NodeTypeInterface`, calls `getFieldDefinitions('node', $bundle)` and keeps
  only fields whose name starts with `field_` (custom/attached fields; base fields
  like `title`, `status` are excluded).
- Renders a `#theme => 'table'` render array with columns **Label**
  (`$field->getLabel()`) and **Machine name**. Each machine-name cell is built with
  `$this->t()` using `@key` (the field machine name) and `@module_path`
  placeholders, wrapping the name in a `<span id='copy_…'>` plus an
  `<a class='copy-to-clipboard' data-clipboard-target='#copy_…'>` anchor containing
  `image/clippy.svg`. `#empty` is "No data available".

Field labels and machine names come from the field definitions of the requested
bundle (not from request input), and placeholder substitution via `t()` escapes the
inserted values.

## Client behavior (library)

`hook_page_attachments()` attaches `copy_field/clipboard` only on the copy route.
The library loads `css/style.css` and the vendored
`clipboardjs/clipboard.min.js` + `clipboardjs/copy-to-clipboard.js`.
`copy-to-clipboard.js` instantiates `ClipboardJS('.copy-to-clipboard')` and, on a
successful copy, shows a transient "Copied!" popup near the clicked icon.

## Uninstall

`copy_field_uninstall()` iterates every config named `node.type.*` and, where the
`use_copy_field` key exists, clears it and saves — cleaning up the per-bundle flags.

## Operating notes

- No fields are modified or written by this module; the tool only reads field
  definitions and copies machine-name strings to the clipboard.
- To roll it out only in dev/staging, manage the module's enabled state with
  Config Split (the per-bundle `use_copy_field` flag otherwise travels with the
  content type's config export).
