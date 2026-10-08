<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API processors

Three `@SearchApiProcessor` plugins (all `add_properties` stage) that expose extra indexable
properties derived from this module's fields. Enable them per-index on the index's "Processors" tab;
they are implementations of Search API's plugin type, not a new plugin type defined here.

| Processor id | Class | Adds property | Purpose |
|---|---|---|---|
| `edtf_date_processor` | `EDTFDateProcessor` | `edtf_dates` (`datetime_iso8601`, list) | Indexes EDTF values as Solr date-type values (`…T00:00:00Z`) |
| `edtf_year_only` | `EDTFYear` | `edtf_year` (`integer`, list) | Indexes the year(s) an EDTF value covers (expands intervals to a year range) |
| `typed_relation_filtered` | `TypedRelationFiltered` | `typed_relation_filter__<field.id>` (`string`, list) | Indexes referenced term names from a typed_relation field, filtered to chosen relation types |

## `edtf_date_processor`

Config form lets you pick `edtf` fields (`entity_type|field_name`), an open-interval begin/end year
(defaults 1000 / 9999), and the month each season maps to (`spring_date`…`winter_date`). At index time
it sanitizes qualifiers (`~ ? %` stripped), normalizes `X` placeholders, converts single dates,
ranges, and `{…}` multi-dates into `Y-m-dT00:00:00Z`, filters by the open-start/open-end years, and
sorts ascending. Out-of-range months/days are logged (channel `edtf_date_processor`) but still
indexed.

## `edtf_year_only`

Config: pick fields (`entity_type|bundle|field_name`), `ignore_undated` (skip `XXXX`),
`ignore_open_start` / `ignore_open_end`, and `open_start_year` / `open_end_year`. Uses the
`professional-wiki/edtf` parser (`EDTF\EdtfFactory`) to derive min/max and emits `range(minYear,
maxYear)`; open intervals fill in the configured (or current) year. Supports EDTF values on referenced
`paragraph` fields. Parse failures are logged to the `controlled_access_terms` channel.

## `typed_relation_filtered`

For each `typed_relation` field on the datasource entity type it offers a per-index property; in the
field's config you choose which relation type keys to include (`TypedRelationFilteredProperty`
configuration form). At index time it emits the referenced taxonomy term names whose stored `rel_type`
is in the selected set. `requiresReindexing()` returns TRUE on any settings change.

See [../fields/edtf.md](../fields/edtf.md) and [../fields/typed-relation.md](../fields/typed-relation.md)
for the underlying fields.
