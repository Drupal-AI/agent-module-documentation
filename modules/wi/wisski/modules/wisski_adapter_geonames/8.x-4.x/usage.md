<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI GeoNames Adapter reads GeoNames.org, so places in a collection are referenced against a gazetteer rather than typed as text.

---

Place is the field that free text damages most. "Cambridge" is two well-known cities and several small ones; "Springfield" is dozens; historical place names change, and administrative boundaries move. A collection whose findspots and origins are free text cannot be mapped, cannot be filtered by region and cannot be joined with anyone else's data.

GeoNames is the general-purpose gazetteer for resolving that: an identifier per place, with coordinates, hierarchy and alternate names. This adapter queries it live so places appear as data.

**Two things a research project should decide.** Coordinates in a gazetteer are approximate and modern, which is fine for an origin and wrong for an archaeological findspot recorded to the metre — know which precision a field needs. And for sensitive material, precise location is exactly what should not be published: findspots of portable antiquities, nesting sites, sacred places. Referencing a gazetteer makes location machine-readable, which makes deciding what to expose more urgent, not less.

---

- Reference a place against a gazetteer.
- Disambiguate two places with the same name.
- Get coordinates for a place.
- Map a collection's origins.
- Filter a collection by region.
- Join place data with other collections.
- Handle a historical place name.
- Record a place hierarchy.
- Decide the precision a field needs.
- Withhold precise findspots for sensitive material.
- Avoid publishing sensitive locations.
- Get alternate place names in other languages.
- Check adapter behaviour when GeoNames is unreachable.
- Audit free-text place fields.
- Plan location data policy for a project.
