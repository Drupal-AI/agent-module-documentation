<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity References Finder is an admin report that lists which entity reference field configurations point at a chosen content entity type and bundle.

---

Entity References Finder adds a single report at `admin/reports/entity_reference_finder`. You pick a
content entity type (node, taxonomy term, media, user, etc.) and one of its bundles, and the page
lists every `entity_reference` and `entity_reference_revisions` field whose configuration targets
that entity type and includes that bundle in its allowed target bundles. Each result row shows the
field machine name, the entity type that owns the field, and the owning bundle label. The lookup is
at the field-configuration level (which fields *can* reference the bundle), not a scan of stored
content, so it answers "what in my site is set up to reference this bundle?" — useful when auditing
how bundles are wired together before renaming, restructuring, or removing them. It has no
configuration of its own and provides one permission that gates the report page.

---

- Find which entity reference fields target a given content entity type and bundle.
- Audit how bundles are wired together across the site's field configuration.
- List the fields that point at an image or file media bundle.
- Discover which content types reference a specific taxonomy vocabulary bundle.
- See the field name, owning entity type, and owning bundle for each matching field.
- Check entity_reference_revisions fields (e.g. Paragraphs) alongside plain entity_reference fields.
- Review field wiring before renaming a bundle.
- Review field wiring before deleting a bundle or content type.
- Understand a bundle's incoming reference footprint during a content model review.
- Plan a migration by mapping which fields target which bundles.
- Onboard onto an unfamiliar site by exploring its reference relationships.
- Verify that a newly configured reference field targets the intended bundle.
- Spot leftover reference fields still targeting a bundle you meant to retire.
- Confirm which content types can reference a media bundle.
- Trace paragraph-type references via entity_reference_revisions fields.
- Document the reference structure of a content model.
- Support safe restructuring of content types and vocabularies.
- Inspect reference wiring without writing custom code or database queries.
- Use the AJAX-driven form to switch entity type and bundle without page reloads.
- Restrict access to the report to trusted roles via its dedicated permission.
