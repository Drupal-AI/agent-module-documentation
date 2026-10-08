<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Nid (custom_nid) — agent index

Adds a **"Nid"** text field to the node **create** form so a permitted user can type the
node ID the new node should get, instead of taking the next auto-increment value. On a new
node the typed value is applied to `nid` at save time. Only applies to node creation, never
to editing an existing node.

- Dependencies: none (the info.yml declares no `dependencies:`). Core `^9.2 || ^10 || ^11`.
- Configure route: **none** — no settings form, no config object, no config schema.
- Provides: one **permission**, no drush commands, no plugin types, no services.

Solutions:
- **Who may set a custom nid, and the exact permission** → [permissions/permissions.md](permissions/permissions.md)
- **How the field is added, validated, and applied to `nid` (form_alter + presave)** → [hooks/behavior.md](hooks/behavior.md)

Key facts:
- Whole module: `custom_nid.module`, `custom_nid.info.yml`, `custom_nid.permissions.yml`,
  `README.md`, `LICENSE.txt`. No `src/`, no routing, no services, no config.
- Permission string: **`custom_nid access`** (title "Adminster Custom Nid", `restrict access: true`).
  Not granted to any role by default.
- The added form element is a plain Form-API `textfield` named **`custom_nid_field`**
  (title "Nid", `#size`/`#maxlength` 15, `#weight` -50). It is NOT a Field-API field.
- Hooks implemented: `hook_form_alter` (`custom_nid_form_alter`) and
  `hook_entity_presave` (`custom_nid_entity_presave`).
- Validation (form `#validate` `custom_nid_form_validate`): value must be numeric ("Nid is
  not numeric.") and must not match an existing `node.nid` ("Nid already exists.").
- The field appears only when the form object is a `Drupal\node\NodeForm`, the current user
  has `custom_nid access`, and the node has no `nid` yet (i.e. a new node).
