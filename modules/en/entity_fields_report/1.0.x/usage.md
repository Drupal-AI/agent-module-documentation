<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Fields Report adds an admin report at /admin/reports that lists every configured entity field, how it is configured, and how many entities actually use it.

---

Entity Fields Report is a site-auditing tool for administrators and developers. It walks every `field_storage_config` / `field_config` in the site and builds a table showing each field's machine name, label, target entity type, bundle, field (widget) type, and the module that provides that type. For each field/bundle combination it runs an access-checked entity query and reports a usage count plus the list of entities that carry the field. The main report can be grouped by field, entity type, bundle, widget type, or widget module, and filtered on any of those dimensions. From a usage count you can drill into a per-field listing of the individual entities (title, ID, status, created/changed dates, edit link) that use the field, and you can export the whole report, one group, or a single field to CSV. It depends on core Node and the contrib Paragraphs module, provides its own restricted `view entity_fields_report report` permission, and lives in the Content package. It adds no configuration form — it is purely a read/report tool.

---

- Audit which fields exist across every entity type and bundle on a site.
- Find how many nodes actually use a given field before removing it.
- Identify unused or near-unused fields that are candidates for cleanup.
- List every field that uses a particular widget/field type (e.g. all `entity_reference` fields).
- List every field provided by a specific module to gauge that module's field footprint.
- Group the report by entity type to review one content type's field set at a time.
- Group by bundle to compare field usage across bundles.
- Group by widget module to plan a module removal and see which fields would break.
- Filter the report to a single field machine name to see everywhere it is reused.
- Filter by entity type + bundle to scope an audit to one content type.
- Drill from a field's usage count into the exact entities that carry the field.
- See the title, ID, publish status, and created/changed dates of entities using a field.
- Jump straight to the edit form of a listed entity (when you may edit that bundle).
- Export the full field report to CSV for spreadsheet analysis or documentation.
- Export just one group (e.g. one entity type) to CSV.
- Export a single field's usage row to CSV.
- Document a site's content model for onboarding or handover.
- Support data-migration planning by mapping fields to their real usage.
- Verify a field rollout by confirming the new field appears with expected usage.
- Review Paragraphs fields alongside node and other entity fields in one place.
- Give site builders a quick read-only overview without opening each bundle's Manage fields page.
- Spot fields duplicated across bundles that could be consolidated.
- Feed a periodic content-model health check or governance review.
- Provide developers a fast reference for which entity types a shared field storage spans.
