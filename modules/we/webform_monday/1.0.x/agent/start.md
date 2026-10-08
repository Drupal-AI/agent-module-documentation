<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Monday.com (webform_monday) — agent index

**Webform handler that creates Monday.com board items from submissions via the Monday GraphQL API.**

- **Version:** 1.0.x
- **Core:** ^10.6 || ^11
- **Dependencies:** webform, key
- **Configure:** `/admin/config/services/monday/settings` + instance collection `/admin/config/services/monday` (`administer webform_monday`, `restrict access: true`)
- **Entity:** `webform_monday_instance` (references a Key holding the API token)
- **Service:** `webform_monday.client` (`MondayClient` — create_item, boards, board details, testConnection)
- **Security:** API token comes from a Key entity (not stored in module config) and is sent over HTTPS via the default `@http_client` — **TLS verification is not disabled**. Outbound only: no inbound webhook/callback to verify. Admin surface gated by an access-restricted permission. No security findings.

See [configure/instances.md](configure/instances.md)
