<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Filtering Link (entity_ref_filtering_link) — agent index

Field formatter for **entity_reference** fields that renders each referenced entity's label as a
link to a **pre-filtered view/page** (query arg or facet syntax) instead of to the entity's own
canonical page. Version **1.1.2**. Core `^9 || ^10 || ^11`. Package *Fields*.
**No** module dependencies, routes, permissions, services, hooks, install file, or config/install
defaults. Provides config **schema** only.

## Plugins (both apply to `field_types = { "entity_reference" }`)

- `Plugin/Field/FieldFormatter/EntityReferenceFilteredLinkFormatter` — id
  `entity_reference_filtered_link`, label *"Filter Link"*. Extends
  `EntityReferenceFormatterBase`. Does all the work.
- `Plugin/Field/FieldFormatter/EntityReferenceFilteredLinkDisableFormatter` — id
  `entity_reference_filtered_link_disable`, label *"Filter Link Disable"*, **`no_ui = true`**.
  An **empty subclass** of the above — *identical behaviour*, just hidden from the Field UI
  (programmatic/legacy display configs). It does **not** by itself suppress the link; link
  suppression is the `disable` setting, present in both plugins.

## Configuration & how it works

Configured per field display on *Manage Display* (no admin route of its own). Settings:
`view_url` (required base path), `argument_name` (defaults to the field machine name), `mode`
(7 URL shapes), `skip_access_check`, `disable` (comma-separated labels rendered as plain text),
`permission` (gate linking behind a permission). See:

- [agent/fields/formatter.md](fields/formatter.md) — plugin ids, every setting, the seven URL
  modes, `viewElements()` render logic, access/cache behaviour, and the stale config schema.
