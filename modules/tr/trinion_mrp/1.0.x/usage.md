<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Material Requirements Planning to a Trinion manufacturing ERP: bills of materials, master production schedules, MRP records, work centres/divisions and a production calendar.

---
The module works over a set of node bundles (`zapis_mrp`, `mrp_specifikaciya`, `mps`, `mrp_zakaz_na_proizvodstvo`, `mrp_rabochiy_centr`, etc.). Forms drive the planning workflow: `/bom-report` (BOMForm) builds a bill-of-materials report, `/mrp-record-creator` (MrpRecordCreatorForm) generates MRP records and their planned-order tables, and `/proizvodstvenniy-kalendar` renders a working-day production calendar stored in Drupal state. Two controllers turn MRP output into downstream documents — production orders (`SozdanieZakazaNaProizvodstvo`) and supplier purchase orders (`SozdanieZakazaPostavshiku`) — using the calendar to schedule release days. A `TrinionHelper` service (injected `@database`) reads the MRP report table and resolves related orders via entity queries.

Every record bundle is gated by its own view permission (all marked `restrict access: true`), enforced in `hook_entity_access`; internal bundles (`stroka_zapisi_mrp`, `mrp_scenario`) are always forbidden from direct view. The admin settings form at `/admin/config/mrp/settings` requires `administer site configuration`; the report/creator forms require the relevant `create … content` node permissions. Related-order lookups use `\Drupal::entityQuery(...)->accessCheck()` and the helper builds no raw SQL. Setup is: install `trinion_tp`, configure the production calendar, and grant the per-bundle permissions.
---
- Generate a bill-of-materials (BOM) report for a specification.
- Create MRP records with planned-order-release tables.
- Maintain a master production schedule (MPS).
- Build and store a working-day production calendar.
- Convert an MRP record into a production order.
- Convert an MRP record into a supplier purchase order.
- Schedule order-release days against the production calendar.
- Auto-number MRP documents via the trinion_tp helper.
- Restrict viewing of MRP records to permitted staff.
- Restrict viewing of MRP specifications by permission.
- Restrict viewing of production orders by permission.
- Restrict viewing of MPS documents by permission.
- Restrict viewing of work-centre records by permission.
- Show related supplier/production orders on an MRP record.
- Total the sum and count of related production/purchase orders.
- Configure the purchase-order date rule at `/admin/config/mrp/settings`.
- Mark non-working days that shift the calendar.
- Render the production calendar grouped by month.
- Grant per-bundle MRP view permissions to planners.
- Use as the planning layer of a Trinion manufacturing site.
