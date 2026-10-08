<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contribute (contribute) — agent index
**Adds a "Community Information" section to `/admin/reports/status` showing the site's Drupal.org account, Drupal Association membership, and contribution status, encouraging owners to join and give back.**

- **Version:** 6.0.x (documented release 6.0.0-beta1 — beta).
- **Core:** `^10.3 || ^11`. No non-core dependencies. No custom permissions (uses core `administer site configuration`).
- **Config:** single object `contribute.settings` — `status` (bool), `account_type` (`user`|`organization`), `account_id` (Drupal.org name). Has config schema.
- **Routes:** `contribute.settings` → `/admin/reports/status/contribute/configure` (settings form, modal-capable); `contribute.autocomplete` → `/admin/reports/status/contribute/autocomplete/{account_type}` (proxies Drupal.org user autocomplete). Both require `administer site configuration`.
- **Service `contribute.manager`** (`ContributeManager`): `getStatus()`, `getAccount($display_type=TRUE)`, `getMembership()`, `getContribution()`, plus account type/id getters+setters. Queries drupal.org api-d7 + scrapes profile pages; caches results 1h under tag `contribute`.
- **Display:** `hook_preprocess_status_report_page` injects blocks; `hook_page_attachments` adds inline icon CSS (only on the `system.status` route); `community_information_block` Block plugin renders the same; theme hook + template `contribute_status_report_community_info`.

See [configure/settings.md](configure/settings.md) and [api/manager.md](api/manager.md).
