<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SharpSpring CRM (sharpspring_crm) — agent index
**Sends Webform submissions to the SharpSpring marketing CRM as leads or list members via its JSON Public API.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 · **Package:** Marketing
- **Config route:** `sharpspring_crm.admin_settings_form` → `/admin/config/sharpspring_crm/settings` (perm `administer sharpspring settings`)
- **Permission:** `administer sharpspring settings`
- **Service:** `SharpSpringCrm` (getActiveLists / getFields / addListMemberEmailAddress / createLeads)
- **Plugins:** `SharpSpringCrmLeadHandler`, `SharpSpringCrmListHandler` (Webform handlers)

**Security:** Admin config route is permission-gated and lead push happens server-side on webform submit. NOTE: all API calls go to `http://api.sharpspring.com` over plain HTTP with `accountID` + `secretKey` in the query string (SharpSpringCrm.php) — the API secret is transmitted in cleartext.

See [configure/settings.md](configure/settings.md) and [plugins/webform-handlers.md](plugins/webform-handlers.md)
