<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Fields Search (entitytype_filter) adds admin pages that list the configurable fields on a site's bundles, searchable by bundle title or by field type.

---

Entity Fields Search gives site builders and developers two administration pages for inspecting how fields are configured across a site. The first page (`/admin/entitytypes-filter`) lets you pick a bundle config entity type — Content types, Block types, Paragraph types, Media types, ECK types, or any module that defines a bundle config entity — then autocomplete a specific bundle by title and see every configurable field on it, each linked to its Field UI edit page. The second page (`/admin/fieldtypes-filter`) lists the configurable fields across all bundles of a chosen entity type at once, optionally filtered to a single field type ("All" by default), and offers a one-click CSV export of the result. Both pages read live entity and field definitions through core's entity type manager, entity field manager, and field type plugin manager, so results always reflect the current field configuration. The module ships no configuration, no permissions of its own (both pages are gated by the `administer content` permission), and no content model — it is purely a read-only inspection tool.

---

- Audit which configurable fields exist on a specific content type before editing it.
- Search a single Paragraph type by name and list all of its fields.
- Inspect Block type fields without clicking through each Field UI tab.
- List every field on all Media types of the site at once.
- Find which bundles use a particular field type (for example, all Entity reference fields).
- Filter a field listing down to just Image, Text (formatted), or Datetime fields.
- Export the filtered field list to CSV for a spreadsheet-based audit.
- Produce a field inventory to support a content migration plan.
- Review field configuration across ECK entity types alongside core ones.
- Jump straight to a field's Field UI edit page from the search results link.
- Check whether two content types share the same field machine names.
- Confirm the field type of a reference field, including its target handler.
- Help onboard a developer by giving them a quick map of the site's fields.
- Prepare documentation of a site's data model from the exported CSV.
- Spot orphaned or duplicated fields across bundles before refactoring.
- Verify a newly added field appears on the intended bundle.
- Compare field types used across taxonomy vocabularies.
- Look up the bundle machine name and field machine name together in one table.
- Support a theming task by listing which fields render on a bundle.
- Cross-check field configuration after importing configuration.
- Review the field footprint of a custom bundle-based entity type.
- Give a content strategist a readable list of fields per content type.
- Assist a site cleanup by identifying which field types are actually in use.
- Generate a quick reference of reference-field target types across bundles.
- Speed up QA by confirming expected fields exist on each bundle.
