<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Region Permissions — agent index

Adds one dynamic permission **per theme region** so a role can administer blocks in only
certain regions of the **Block layout** page, instead of core's all-or-nothing
"Administer blocks". No config form, no settings, no Drush, no dependencies beyond core Block.

- **[permissions](permissions/permissions.md)** — the generated `administer {theme} {region}`
  permissions, how they are named and titled, what each gates, how enforcement works
  (form alters, `hook_block_access`, route `_custom_access`), and the important caveat that
  core "Administer blocks" is still required and still leaks unmanaged block pages.
