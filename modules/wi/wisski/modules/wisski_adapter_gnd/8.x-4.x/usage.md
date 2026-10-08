<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI GND Adapter reads the German National Library's Gemeinsame Normdatei directly, so records can reference authority-controlled names.

---

The GND is the German-speaking world's authority file for people, corporate bodies, places, works and subject terms, and it is the reference point most German museums, archives and libraries catalogue against. Referencing a GND identifier rather than typing a name is what makes a record joinable with every other institution that does the same.

This adapter queries it live through SALZ, so a GND record appears as data alongside the project's own rather than being copied in and going stale.

Two practical consequences of live querying. **The service's availability becomes yours** — a slow or unreachable GND affects cataloguing, so check what the adapter does on failure. And **an authority record can change**: names are corrected, entities are merged, identifiers are deprecated. Referencing by identifier is what makes those corrections propagate, which is the argument for doing it, but it also means the label a record displays is not under the project's control.

Note there are two GND adapters, this and `wisski_adapter_gnd_new` — establish which one a project uses.

---

- Reference a person by GND identifier.
- Catalogue against a German authority file.
- Join records with other German institutions.
- Look up a corporate body in the GND.
- Reference a place from the GND.
- Keep authority data current automatically.
- Propagate an authority correction.
- Check adapter behaviour when GND is unreachable.
- Understand which GND adapter a project uses.
- Avoid typing names free-text.
- Improve data joinability across institutions.
- Handle a deprecated GND identifier.
- Audit records lacking authority references.
- Plan for authority service downtime.
- Compare the two GND adapters.
