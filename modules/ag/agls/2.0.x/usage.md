<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AGLS extends the Metatag module with the AGLSTERMS.* meta tags of the AGLS (Australian Government Locator Service) Metadata Standard, so Australian government sites can emit standards-compliant descriptive metadata.

---

The AGLS Metadata Standard is a set of descriptive properties (and obligation rules) used by Australian government agencies to describe online resources and services so they are easier to find, manage and interoperate. This module is a thin extension of the Metatag module: it registers a Metatag group (`agls`) and a set of individual meta tag plugins under the `AGLSTERMS.*` namespace — jurisdiction, availability, function, mandate, category, aggregation level, document type, protective marking, service type, regulation, case, act, date licensed, is-based-on and is-basis-for — each rendered as a `<meta name="AGLSTERMS.…" content="…">` element. Because the tags are ordinary Metatag plugins, they inherit Metatag's whole configuration model: set defaults per entity type / bundle, override per node, and use tokens for values, all from Metatag's admin UI. The module also implements `hook_metatags_attachments_alter()` to add the two `schema.dcterms` and `schema.AGLSTERMS` `<link>` profile elements the AGLS HTML5 validation profile requires. AGLS Dublin Core-style properties (creator, title, publisher, date, identifier, etc.) are provided by Metatag's own Dublin Core submodule; this project supplies only the AGLSTERMS-specific tags on top. Version 2.0.x requires Metatag 2.0+ and PHP 8.0, on Drupal 9.3/10/11. It has no routes, permissions, services or config of its own — configuration is entirely through Metatag.

---

- Emit AGLS-compliant metadata on an Australian government website.
- Add an `AGLSTERMS.jurisdiction` tag naming the political/administrative entity a resource covers.
- Set `AGLSTERMS.availability` on offline resources (mandatory for offline resources under AGLS).
- Declare an agency `AGLSTERMS.function` when a Dublin Core subject is not used.
- Record the `AGLSTERMS.mandate` (legislation/authority) behind a service.
- Tag a resource's `AGLSTERMS.category` (service, document, or agency).
- Set `AGLSTERMS.documentType` for published document types.
- Add an `AGLSTERMS.protectiveMarking` security classification label.
- Describe an online service with `AGLSTERMS.serviceType`.
- Configure AGLS default tags per content type through Metatag.
- Override AGLS tags on an individual node, term or user.
- Use tokens (e.g. author, dates) as AGLS meta tag values via Metatag.
- Add the `schema.dcterms` / `schema.AGLSTERMS` profile links AGLS HTML5 validation expects.
- Improve discoverability of government resources in AGLS-aware catalogues.
- Meet whole-of-government metadata policy requirements.
- Pair AGLSTERMS tags with Metatag's Dublin Core tags for full AGLS coverage.
- Record `AGLSTERMS.dateLicensed` for licensed content.
- Express relationships with `AGLSTERMS.isBasedOn` / `AGLSTERMS.isBasisFor`.
- Set `AGLSTERMS.aggregationLevel` to indicate item vs. collection.
- Standardise metadata across a multi-agency Drupal platform.
