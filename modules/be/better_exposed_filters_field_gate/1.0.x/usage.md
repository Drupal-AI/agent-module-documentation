<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Better Exposed Filters widget that limits a taxonomy-term exposed filter's options to terms whose chosen boolean field is enabled.

---

Better Exposed Filters Field Gate adds one BEF widget, `FieldGateCheckboxesRadioButtons` (id `bef_field_gate`), that extends BEF's RadioButtons and applies only to Views `TaxonomyIndexTid` exposed filters. In the filter's BEF settings a site builder enables "field gate" and picks a boolean field on the vocabulary; at render time `exposedFormAlter()` runs an entity query for the terms whose boolean field is set to 1 (with `accessCheck(TRUE)`) and removes the non-matching term options from the exposed form, while preserving non-term options like "- Any -". It is display-level curation of which terms appear as filter options — the Views query and taxonomy/node access still govern the actual results, so it is a UX/curation feature rather than an access-control mechanism. Configuration is entirely per exposed filter inside the View; there is no global settings page, no route, and no permission of its own.

---

- Show only terms flagged with a boolean field in an exposed taxonomy filter
- Present a "featured categories" filter without maintaining a separate vocabulary
- Gate checkbox/radio taxonomy filter options by an editorial boolean flag
- Choose which boolean term field controls option visibility, per filter
- Hide inactive or draft-style terms from an exposed filter's option list
- Keep "- Any -" / "All" and other non-term options intact while trimming terms
- Reuse one vocabulary across several Views, exposing a different subset in each
- Curate a long taxonomy list down to the relevant terms for one filter
- Toggle field gating on or off independently per exposed filter
- Drive filter option visibility from a "show in filter" boolean on the term
- Reduce clutter in faceted taxonomy filters without touching term data
- Let editors control filter options by ticking a boolean on individual terms
- Combine gate curation with standard BEF radio/checkbox styling
- Restrict a public exposed filter to terms marked as publicly relevant
- Build a "promoted tags" filter driven by a boolean term field
- Apply gating only where the exposed filter is a TaxonomyIndexTid filter
- Validate at config time that a real boolean field is chosen when gating is on
- Configure the whole feature within the Views exposed-form UI, no code
- Swap curated term subsets by changing the term boolean rather than the View
- Avoid duplicate vocabularies whose only difference is which terms are filterable
