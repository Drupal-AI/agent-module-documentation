<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Geofield provides one field taking latitude and longitude together.

---

Coordinates belong together. Splitting them into two number fields means two chances to enter one and forget the other, no validation that the pair is coherent, and every consumer having to recombine them.

This submodule supplies a single field for the pair, which is a small piece of data modelling with a real effect on data quality in a collection where location is recorded by hand.

Two things worth stating whenever coordinates are collected. **Precision is a claim.** Six decimal places asserts sub-metre accuracy; if the source was a map reference or a modern town centre, that claim is false and will be believed by whoever uses the data later. Record precision honestly, or record it separately.

And **coordinates can be sensitive.** For archaeological findspots, protected species records and sites of cultural significance, publishing a precise location is a real-world harm — looting, disturbance, trespass. A collection that makes location machine-readable should decide, deliberately and per category, what is published at what precision. That decision is easier to make when the coordinate is one field with a known meaning than when it is two numbers scattered through a form.

---

- Record a location as one field.
- Enter latitude and longitude together.
- Validate a coordinate pair.
- Avoid half-entered coordinates.
- Map records from a collection.
- Record precision honestly.
- Avoid asserting false accuracy.
- Withhold precise archaeological findspots.
- Protect sensitive species locations.
- Decide publication precision per category.
- Export coordinates to a mapping tool.
- Join location data with a gazetteer.
- Audit records with suspicious precision.
- Plan a location data policy.
- Reduce data entry errors.
