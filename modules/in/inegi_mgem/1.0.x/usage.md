<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blocks that query Mexico's INEGI geo-statistical web service (AGEE/AGEM) to display state, municipality and locality records by key.

---

INEGI MGEM Integration consumes Mexico's INEGI single geo-statistical keys web service (AGEE/AGEM) and renders state, municipal and locality records into configurable Drupal blocks.

Two client services (`InegiClientService`, `InegiMunicipalLocalityService`) call the public INEGI endpoints over HTTPS (`https://gaia.inegi.org.mx/wscatgeo/v2/mgem/` and `.../lgev/`) with a 5-second timeout, zero-padding the state (`cve_ent`, 2 digits), municipality (`cve_mun`, 3 digits) and optional locality (`cve_loc`) keys before requesting, and decode the JSON response (failures are logged and return an empty array). Two block plugins expose this: a State/MGEM lookup block and a Municipal/Locality lookup block, configured with the relevant keys. No API key or authentication is required — the INEGI service is public — so there are no secrets to store. A Spanish translation (`es.po`) ships in `translations/`.

Typical setup: enable the module, place either block via Structure > Block layout, and enter the state (and municipality/locality) codes to display.
---
- Display municipality data for a Mexican state by `cve_ent`.
- Show locality data for a municipality by compound `cvegeo` key.
- Place a State/MGEM lookup block in a region.
- Place a Municipal/Locality lookup block in a region.
- Configure the 2-digit state code on a block.
- Configure the 3-digit municipality code on a block.
- Optionally filter to a specific 4-digit locality.
- Present INEGI indicators to site visitors.
- Import the bundled Spanish (es) translation.
- Fetch data live from the public INEGI API.
- Rely on a 5-second timeout to avoid slow pages.
- Log connection failures without breaking the page.
- Build geo-statistical dashboards for Mexican regions.
- Reuse the client services from custom code.
- Zero-pad partial keys to the required digit width.
- Look up an entire municipality's localities at once.
- Display official INEGI indicators without an API key.
