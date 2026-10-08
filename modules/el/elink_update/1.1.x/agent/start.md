<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Link Update (elink_update) — agent index

**Bulk-adds `target`/`rel` attributes to external links in node body fields, via an admin batch form or a Drush command.**

- **Version:** 1.1.x
- **Core:** `^8.8.3 || ^9 || ^10`
- **Configure:** `/admin/config/elink-update` (`elink_update.external_link_update_form`, `access administration pages`, admin route).
- **Drush:** `elink-update:find-external-link` (`DrushExtLinkUpdateCommand`, service-tagged).
- **Batch callbacks:** `process_node()` / `finished_processing()` in the `.module`; `_update_external_links()` does the HTML rewrite.

**Security:** Single admin-gated form plus a Drush command; no anonymous or mutating public endpoints. Operates only on existing node body markup.

See [drush/find-external-link.md](drush/find-external-link.md).