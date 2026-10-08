<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body classes: base fields, form alters, validator, preprocess

All logic is in `custom_css_class_to_body.module` (procedural; no `src/`).

## Install / enable

- `composer require drupal/custom_css_class_to_body` then `drush en custom_css_class_to_body -y`.
- No configuration form and no permissions. Enabling installs the two node base fields
  automatically (via `hook_entity_base_field_info()`); no entity-update/field-install step beyond
  the normal module install. Requires the core **`node`** module to do anything useful.

## Base fields (on the `node` entity)

Added in `custom_css_class_to_body_entity_base_field_info(EntityTypeInterface $entity_type)`, only
when `$entity_type->id() === 'node'`:

| Field machine name    | Type      | Label                                                              | Widget             | Weight | Translatable |
|-----------------------|-----------|-------------------------------------------------------------------|--------------------|--------|--------------|
| `body_class`          | `string`  | "Add CSS class(es)"                                                | `string_textfield` | 36     | yes          |
| `specific_node_class` | `boolean` | "Please checked, if you need to add node type as class to body tag." | `boolean_checkbox` | 37     | yes          |

Both set `setDisplayConfigurable('form', TRUE)`. They are base fields, not configurable fields, so
they exist on every node bundle without a Field UI step. Values are read from
`$node->get('body_class')` / `$node->get('specific_node_class')`.

## Node form integration

`custom_css_class_to_body_form_node_form_alter(&$form, &$form_state, $form_id)`:

- Creates `$form['body_class_group']` — a `details` element titled *"Custom CSS Class to Body -
  Settings"*, `#group => 'advanced'` (the node form's vertical-tab sidebar), `#access => TRUE`,
  wrapper class `body-class-form`.
- Re-parents `$form['body_class']` and `$form['specific_node_class']` into that group via `#group`.
- Appends `_node_special_character_form_validate` to `$form['#validate']`.

Because `#access => TRUE` is hard-coded, the group is visible to **any** user who can access the
node form; there is no dedicated permission gating these fields (node edit access still applies to
the form as a whole).

## Content-type form integration

`custom_css_class_to_body_form_alter(&$form, FormStateInterface &$form_state, $form_id)` acts only
when `$form_id == 'node_type_edit_form'`:

- Reads the current default via `$type->getThirdPartySetting('node_type_class', 'classes', '')`.
- Adds `$form['nodetype_body_class_group']` (`details`, `#group => 'additional_settings'`) with
  `#attached` library `node_type_class/node_type_class.classes` (from the separate *node_type_class*
  module — absent here means the asset just does not load).
- Adds `nodetype_body_class_group['nodetype_class']` — a textfield ("CSS class(es)", "separate them
  with a space"), default = the stored classes.
- Registers `custom_css_class_to_body_form_node_type_form_builder()` on `#entity_builders`, which
  calls `$type->setThirdPartySetting('node_type_class', 'classes', $form_state->getValue('nodetype_class'))`
  to persist the value on the `NodeType` config entity.
- Appends the same `_node_special_character_form_validate` validator.

## Render-time output

`custom_css_class_to_body_preprocess_html(&$variables)`:

1. `$node = \Drupal::routeMatch()->getParameter('node')`; proceeds only if `$node instanceof NodeInterface`.
2. If `body_class` has a value, pushes `$custom[0]['value']` onto `$variables['attributes']['class']`.
3. If `specific_node_class` equals `1`, pushes `$node->gettype()` (the content-type machine name).
4. Loads the `NodeType` via `entityTypeManager()->getStorage('node_type')->load($node->getType())`
   and always pushes its `node_type_class.classes` third-party setting (empty string when unset).

Only pages whose route carries a `node` object (e.g. the canonical node view) get these classes;
listing/admin pages do not.

## Validator (`_node_special_character_form_validate`)

Runs `preg_match('/[\'^£$%&*()}{@#~?><>,|=_+¬]/', ...)` against `body_class[0][value]` and
`nodetype_class`. If a listed character is present it sets a form error ("Special character in
Custom CSS Body Class" / "... Settings"). The allowed set is therefore letters, digits, spaces,
hyphens and a few others; the blacklisted characters above cannot be saved. (Note the pattern is a
character blacklist, not a strict CSS-identifier validator.)

## Operating notes

- To add a class to one node: edit the node → open *Custom CSS Class to Body - Settings* in the
  right sidebar → type space-separated classes and/or tick the node-type checkbox → save.
- To add a class to every node of a type: edit the content type → *Custom CSS Class to Body -
  Settings* → fill "CSS class(es)" → save.
- Both node and content-type values combine on the rendered page (node value first, then type
  machine name if checked, then content-type classes).
- Fields are translatable, so per-language class values are possible on translated nodes.
