<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion CRM (trinion_crm) — agent index

**A node-based sales CRM: leads, contacts, companies and deals, with PDF export and lead capture from contact forms.**

- **Version:** 1.0.x
- **Core requirement:** ^9 || ^10 (Drupal 10 module)
- **Dependencies:** trinion_base, contact, taxonomy, options
- **Configure:** `/admin/config/crm/settings` (`trinion_crm.settings`, permission `administer site configuration`)

## Bundles
`lead`, `contact`, `kompanii` (company), `sdelki` (deal).

## Key routes
- `trinion_crm.settings` — settings form; `administer site configuration`.
- `trinion_crm.lead_convert` `/lead-convert` — lead→contact/company form; `create contact content`.
- `trinion_crm.pdf.kompaniya|kontakt|lead|sdelki` — Dompdf export of a node; gated by `create <bundle> content`.
- `trinion_crm.utverdit` `/utverdit_crm/{node}/{op}` — approve(1)/annul(0) a deal; custom access checker (owner or `trinion_base edit all`).

## Permissions
`trinion_crm contact`, `trinion_crm company`, `trinion_crm lead`, `trinion_crm sdelki` — control list/view of each bundle (enforced in `hook_entity_access`).

## Services
`trinion_crm.helper` (CRMHelper — contact/company lookup, per-year document numbering); `access_check.trinion_crm.utverdit_documen` (deal-approval access checker).

**Access:** Settings route is admin-gated; view/list of each bundle is permission-gated. The deal approve/annul endpoint is limited to the responsible user or `trinion_base edit all`.

See [configure/settings.md](configure/settings.md).
