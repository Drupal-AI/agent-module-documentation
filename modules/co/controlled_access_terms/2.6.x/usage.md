<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Controlled Access Terms provides three custom Drupal field types for rigorous library, archival, and digital-collection metadata: EDTF dates (uncertain, approximate, partial, and open-ended dates), Authority Links (a URL plus the authority it comes from, e.g. LCNAF or VIAF), and Typed Relations (an entity reference that also records the relationship type, e.g. Author or Publisher).

---

Cultural-heritage and scholarly metadata needs shapes that ordinary Drupal fields cannot express: dates that are uncertain or only partially known, references to external authority records, and relationships that must be typed (this person is the *author*, that one the *publisher*). This module (part of the Islandora ecosystem) supplies exactly those primitives as reusable field types with matching widgets and formatters. The EDTF field implements the Library of Congress Extended Date/Time Format (2018 / ISO 8601-2019), with a validating widget and a human-readable formatter that renders intervals, seasons, and uncertainty qualifiers. The Authority Link field is a core link field extended with a configurable "source authority" selector, and the Typed Relation field is an entity reference extended with a per-value relation type drawn from a configurable list (schema.org / MARC relators). Beyond the fields, it ships EDTFUtils/EDTFConverter helpers for validating and normalizing EDTF strings, Search API processors that index EDTF dates and years and typed relations for faceting, and RDF/JSON-LD normalization so the data emits as linked data. It depends on Geolocation and Token and requires the professional-wiki/edtf library. It has no settings page — everything is configured per field through the standard Field UI — and the companion controlled_access_terms_defaults submodule ships ready-made vocabularies and fields to start from.

---

- Store an uncertain or approximate date like "1984?" or "circa 1900".
- Record a partially known date such as "19XX" or "1900-06-XX".
- Model an open-ended date range ("1900/.." or "../1950").
- Capture a season or sub-year grouping (Spring 2020 as "2020-21").
- Display EDTF dates human-readably with configurable order and separators.
- Validate EDTF strings on entry, or strictly require real calendar dates.
- Link a term to its Library of Congress authority record.
- Link an agent to a VIAF or geonames identifier.
- Offer catalogers a dropdown of authority sources per field.
- Reference a person as "Author" and another as "Publisher" on one field.
- Model schema.org relationships (spouse, member of, works for) between terms.
- Deduplicate repeated references while merging their relation labels.
- Join Views from either side of a typed relation.
- Facet a Solr index by EDTF year or by typed-relation type.
- Index EDTF dates as Solr date-type values.
- Normalize EDTF values to ISO 8601 in code.
- Emit authority links and dates as JSON-LD / RDF linked data.
- Build Islandora tokens for authors, contributors, publishers, and creation dates.
- Migrate legacy text_edtf fields to the EDTF field type.
- Support ArchivesSpace-to-Drupal metadata workflows.
- Provide standards-based date entry for a research repository.
- Avoid free-text tagging in favor of controlled authorities.
- Start from default vocabularies via the defaults submodule.
- Extend a core link field with provenance metadata.
- Add typed relationships to a taxonomy of agents.
