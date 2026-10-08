<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Campaign (drutopia_campaign) — agent index

**Provides a Campaign content type and related configuration: background information plus the ability to list demands and updates.**

- **Version:** 2.0.x (dev checkout, branch `2.0.x`)
- **Core:** `^10.2 || ^11 || ^12`
- **Package:** Drutopia (config-only base feature)

Installs the **`campaign`** content type + fields, form/view displays, the **`campaign_type`** vocabulary, a Views listing (`view.campaign.page_listing`) with an "Add campaign" action link (`node.add/campaign`), a Pathauto pattern, and Metatag/SEO + search/facet config. Augments Drutopia editorial roles via `config/actions`.

**Security:** No PHP code, routes, controllers, services or `permissions.yml` — the module ships only configuration. Access is governed by core node permissions and Drutopia roles. No anonymous or mutating endpoints, no dangerous sinks. No security findings.
