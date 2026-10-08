<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Loqate permissions

From `loqate.permissions.yml` — one permission:

| Permission | Gates |
|---|---|
| `administer loqate api` | Both admin config forms: the API-key selection form (`loqate.loqate_api_key_config_form`) and the PCA field-mapping form (`loqate.settings_form`). |

Notes:
- It is **not** declared `restrict access: TRUE`, but it only grants access to the module's own
  configuration (which Key entity to use for the Loqate key, and how to map Loqate response fields to
  address elements). It does not expose a state-changing endpoint or the key value beyond normal admin
  config handling.
- The `pca_address` element and submodule widgets are used on ordinary content/Webform forms — their
  availability is governed by the host form/field access, not by this permission.
- The update hook `loqate_update_8004` grants this permission to any role that previously had
  `access administration pages` (one-time migration on update).
