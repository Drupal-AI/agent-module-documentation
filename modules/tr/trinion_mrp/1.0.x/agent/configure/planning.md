<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MRP planning workflow

## Bundles
`zapis_mrp` (MRP record), `mrp_specifikaciya` (BOM/spec), `mps`, `mrp_zakaz_na_proizvodstvo`
(production order), `mrp_rabochiy_centr` (work centre), `mrp_rabochee_podrazdelenie`
(work division), plus internal `stroka_zapisi_mrp` / `mrp_scenario`.

## Steps
1. Install `trinion_tp`; grant the per-bundle view permissions and the
   `create zapis_mrp content` / `create mrp_specifikaciya content` node perms.
2. Configure the production calendar (stored in state
   `trinion_mrp_proizvodstvenniy_kalendar`; non-working days in
   `trinion_mrp_ne_rabochie_dni`) via `/proizvodstvenniy-kalendar`.
3. Set the purchase-order date rule at `/admin/config/mrp/settings`.
4. Build a BOM at `/bom-report`, generate MRP records at `/mrp-record-creator`.
5. From an MRP record, create downstream production orders
   (`SozdanieZakazaNaProizvodstvo`) and supplier purchase orders
   (`SozdanieZakazaPostavshiku`); the helper `getItemsFromMrpReportForOrder()`
   uses the calendar to schedule release days.

## Service
`trinion_mrp.helper`:
- `getItemsFromMrpReportForOrder($node, $source)` — planned releases grouped by day/vendor.
- `getMrpRalatedOrders($node, $type)` — related orders (entityQuery, access-checked).
