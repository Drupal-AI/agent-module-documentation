<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Existing Values Autocomplete Widget turns a plain single-line text field into an autocomplete that suggests values already entered in that same field elsewhere on the site, so free-text fields stay consistent without being converted to taxonomy references.

---

Free-text fields drift: "Manchester", "manchester" and "Manchester " all accumulate because nothing showed the editor what already existed. Converting the field to a taxonomy reference fixes consistency but adds a vocabulary to maintain and changes the data model; this widget is the middle path — the field stays a `string` text field, but typing into it suggests what has been used before. It is implemented as a field widget (`existing_autocomplete_field_widget`, extending core `StringTextfieldWidget`) plus a JSON autocomplete route, `/existing-values/autocomplete/{entity_type_id}/{bundle}/{field_name}`. The controller reads the bundle's form display, serves only fields whose active widget is this one, prefix-matches the typed text case-insensitively against distinct stored values, and returns a value only for entities and fields the current user may view. A per-widget `suggestions_count` setting (default 15) caps how many suggestions come back. There is no module settings page — you enable it per field on Manage Form Display. Dependencies are core `field` and `text`; the branch's current release is 2.0.0-rc1.

---

- Suggest previously used values while typing in a text field.
- Keep free-text fields consistent without a vocabulary.
- Reduce spelling and casing variants in editorial metadata.
- Help editors reuse an existing label instead of inventing a new one.
- Avoid converting a field to a taxonomy reference just for consistency.
- Standardise a department, location, or category text field.
- Show already-used values for a rarely edited field.
- Cap how many suggestions appear via `suggestions_count`.
- Improve data quality in reports and views built on a text field.
- Onboard new editors to a site's existing naming conventions.
- Cut duplicate values before they are created.
- Keep the data model unchanged while improving input ergonomics.
- Apply the widget to any `string` field via Manage Form Display.
- Reduce cleanup work in a later content migration.
- Make faceted filtering on a text field more usable.
- Limit suggestions to content the current editor can view.
- Give a legacy free-text field better input assistance.
- Support a bounded but unmanaged set of values.
- Configure suggestion count per field, per form mode.
- Map D7 CCK autocomplete widgets to this widget during migration.
