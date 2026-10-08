<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce License Access Control (commerce_license_access_control) — agent index

Provides a **Commerce License type** that grants a customer view/update/delete access to specific
**node(s)** through the contrib **ACL** module, enforced by Drupal core **node grants**. Selling
paid/members-only content on top of Drupal Commerce. Version **8.x-1.2** (`8.x-1.x`).

## Facts
- **Type:** module. `core_version_requirement: ^9 || ^10 || ^11`. Package `Commerce (contrib)`.
- **Dependencies:** `acl:acl`, `commerce_license:commerce_license` (composer: `drupal/acl ^2.0@beta`,
  `drupal/commerce_license ^3.0`).
- **No** routes, no permissions, no admin settings form, no config schema, no Drush, no submodules.
- **Provides one plugin instance:** `AccessControl` — a `@CommerceLicenseType` (id
  `commerce_license_access_control`, `activation_order_state = "complete"`), not a new plugin type.
- **Service:** `logger.channel.commerce_license_access_control` (logger channel only).
- **Module file:** `commerce_license_access_control_enabled($set)` — a static flag toggled off on
  uninstall (`hook_uninstall`), read by ACL's `acl_node_access_records()`.

## How it works (one line)
License config creates/maps an ACL to node(s) (`acl_create_acl` / `acl_node_add_acl`); on license
activation the buyer is added to the ACL and node grants are rebuilt; on revoke they are removed —
core node grants do the actual enforcement.

## Solution docs
- [License type plugin & operation](agent/plugins/access_control_license_type.md) — the `AccessControl`
  class: configuration form fields, grant/revoke/existing-rights lifecycle, ACL + node-grant mechanics,
  install/enable, and the node-access-rebuild operator note.
