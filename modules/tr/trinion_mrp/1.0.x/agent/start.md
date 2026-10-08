<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion MRP (trinion_mrp) — agent index
**Material Requirements Planning: BOM/MPS reports, MRP records, production orders and a production calendar for a Trinion ERP.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Depends:** trinion_tp
- **Configure:** `/admin/config/mrp/settings` (perm `administer site configuration`)
- **Routes:** `/bom-report` (perm `create mrp_specifikaciya content`); `/mrp-record-creator` (perm `create zapis_mrp content`); `/proizvodstvenniy-kalendar` (perm `trinion_mrp proizvodstvenniy kalendar`).
- **Permissions:** per-bundle view perms (`trinion_mrp zapis mrp`, `… specificatiya mrp`, `… zakaz_na_proizvodstvo`, `… mps`, `… rabochiy_centr`, …), all `restrict access: true`.
- **Service:** `trinion_mrp.helper` (`@database`) — MRP report/related-order lookups.

**Security:** Record bundles gated by per-bundle permissions in `hook_entity_access` (internal `stroka_zapisi_mrp`/`mrp_scenario` always forbidden); forms require node create/config permissions. Lookups use `entityQuery(...)->accessCheck()`; helper builds no raw SQL. No security findings.

See [configure/planning.md](configure/planning.md).
