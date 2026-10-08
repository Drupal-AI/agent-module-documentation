<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Link Blocklist (elb) — agent index

**Blocks configured external-link URL patterns in link fields and the Linkit dialog via widget/element validation.**

- **Version:** 2.1.x (2.1.2)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Requires:** link
- **Route:** `elb.ext_link_blocklist_settings_form` → `/admin/config/content/elb` (admin route)
- **Permission:** `access the external links blocklist page`
- **Widget:** `ext_link_blocklist_field_widget`
- **Service:** `elb.blocklist` (BlocklistService: getBlocklist/getExceptions/isBlocklisted)
- **Config:** `elb.settings` (blocklist, blocklist_exceptions — comma-separated strings)
- **Linkit:** hook_form_linkit_editor_dialog_form_alter adds an href element validator

**Security:** Settings form is permission-gated on an admin route. Matching is substring containment, not URL parsing (a limitation, not a vuln). Note: `elb_update_8004` auto-grants the settings-page permission to any role holding "access administration pages" — review role permissions after updating.

See [configure/elb.md](configure/elb.md)