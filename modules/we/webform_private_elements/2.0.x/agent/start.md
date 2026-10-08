<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Private Elements (webform_private_elements) — agent index

**Admin setting that auto-enables Webform's built-in "private" flag for chosen element types on creation; it adds no enforcement of its own.**

- **Version:** 2.0.x (info.yml: 2.0.1)
- **Core:** `^10 || ^11` · **Depends:** `webform` · **Package:** Webform
- **Route:** `webform_private_elements.config` — `/admin/structure/webform/config/private`, permission `administer webform` (local task under Webform config).
- **Config:** `webform_private_elements.settings:private` — map of element-plugin ids to auto-mark private (defaults: address, email, tel, webform_address, webform_contact, webform_email_confirm, webform_email_multiple, webform_name).
- **Mechanism:** `hook_webform_element_default_properties_alter` sets `$properties['private'] = TRUE` for listed element ids; `hook_webform_element_configuration_form_alter` sets the private default to FALSE so it's stored only when TRUE.
- **Security:** No independent access enforcement — the module only pre-checks Webform core's `private` property. Actual protection of private values in submission views/exports/REST/tokens is Webform core's responsibility; this module introduces no new leak and no new guard. Single route is admin-gated (`administer webform`) and writes only config. No anonymous/mutating data endpoints.

See [configure/private-defaults.md](configure/private-defaults.md)
