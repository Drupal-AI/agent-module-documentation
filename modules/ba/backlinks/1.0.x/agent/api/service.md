<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backlinks services

- **`backlinks.entity`** → `Drupal\backlinks\Service\EntityLinkService` — invoked on
  `hook_node_presave`; reads `backlinks.settings` for the source fields, extracts links,
  and writes node ids into the `linked_node` field (and URLs into `linked_url`).
- **`backlinks.links`** → `BackLinkService`
  - `getLinks($field_list)` — renders fields, DOM-parses `<a href>`, skips file/mailto/js.
  - `getNodeLinks($field_list, $bundles=[])` — resolves hrefs to `Url`, keeps only
    `entity.node.canonical` targets, returns unique node ids (optionally bundle-filtered).
- **`backlinks.trusted_hosts`** → `TrustedHostService::isTrustedHost($host)` — matches the
  host against `Settings::get('trusted_host_patterns')` to decide internal vs external.

Setup: add `linked_node`/`linked_url` fields, configure scanned fields at
`/admin/config/content/backlinks`, then run the bulk rebuild at `.../backlinks/update`.