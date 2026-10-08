<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behavior: how a custom nid is added, validated, and applied

All logic lives in procedural functions in `custom_nid.module`. There is no service, form
class, or route to call — the module works entirely through two hooks plus two callbacks.

## 1. The field is added — `custom_nid_form_alter()` (hook_form_alter)

Runs on every form. It acts only when **all** of these hold:

- `$form_state->getFormObject()` is an instance of `Drupal\node\NodeForm` (any node add/edit
  form, any bundle), and
- the current user has permission **`custom_nid access`**, and
- `!isset($node->nid->value)` — i.e. the node is new (no ID yet), so the field never shows on
  an edit form.

When they hold it adds a Form-API element:

| Property | Value |
|---|---|
| key | `custom_nid_field` |
| `#type` | `textfield` |
| `#title` | `Nid` |
| `#default_value` | `''` |
| `#size` / `#maxlength` | `15` / `15` |
| `#weight` | `-50` (renders near the top of the form) |
| `#element_validate` | `['attach_custom_nid_field_to_node']` |

It also appends `custom_nid_form_validate` to `$form['#validate']`.

Because the element is only present in the form structure for permitted users, Form API
ignores any `custom_nid_field` value posted by a user for whom the element was not added —
there is no way to inject the value through the normal node form without the permission.

## 2. The value is validated — `custom_nid_form_validate()`

Runs only for the submitted value (empty is allowed = fall back to auto-increment). When the
value is non-empty it enforces two rules:

1. **Numeric:** `is_numeric($custom_nid)` — otherwise sets error "Nid is not numeric."
2. **Unused:** a parameterized `SELECT` on the `{node}` table
   (`->condition('nid', $custom_nid, '=')`); if any row is returned it sets error
   "Nid already exists." The query is built with the database API's placeholders (no string
   concatenation), so the value is not interpolated into SQL.

## 3. The value is stashed on the entity — `attach_custom_nid_field_to_node()`

The `#element_validate` callback copies the submitted value onto the entity as a public
property: `$node->custom_nid_field = $form_state->getValue('custom_nid_field');`. This is a
plain object property, not a stored field, so it survives only for the current save.

## 4. The nid is applied — `custom_nid_entity_presave()` (hook_entity_presave)

Fires for every entity save. It acts only when `$entity->isNew()` **and**
`$entity->getEntityTypeId() == 'node'`. When the stashed `custom_nid_field` is non-empty and
numeric it calls `$entity->set('nid', $entity->custom_nid_field)` so the INSERT uses the
chosen ID. Because it is gated on `isNew()`, it can only ever set the ID on a brand-new
node — it never rewrites the ID of an existing node.

## Integrator notes

- No public API. To set a node's ID programmatically you do not need this module — call
  `Node::create(['type' => 't', 'nid' => 4217, ...])->save()` directly; this module exists to
  expose that on the node create UI behind a permission.
- The uniqueness check is a UI convenience in the form validator. When a node is created by
  code (not via this form), `custom_nid_entity_presave()` does not run a uniqueness check
  (the property is unset in that path anyway), and node IDs remain subject to the database's
  primary-key constraint.
