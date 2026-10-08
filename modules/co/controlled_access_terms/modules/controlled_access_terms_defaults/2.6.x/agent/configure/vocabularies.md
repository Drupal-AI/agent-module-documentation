<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installed vocabularies, fields, and RDF mappings

This submodule ships default configuration only. On enable, Drupal imports everything in
`config/install`; items in `config/optional` import only when their dependencies (e.g. the `rdf`
module) are also enabled. After install these are ordinary config entities — edit or delete them in
the Taxonomy and Field UI like any site config.

## Vocabularies (taxonomy bundles)

`person`, `family`, `corporate_body`, `subject`, `geo_location`, `genre`, `language`,
`physical_form`, `resource_types`, `temporal_subjects` (config `taxonomy.vocabulary.<vid>`). Each is
set up for content translation (`language.content_settings.taxonomy_term.<vid>`) and has default
form + view displays (`core.entity_form_display.*` / `core.entity_view_display.*`).

## Fields attached (all on `taxonomy_term`)

| Field | Type | Attached to (bundles) | Notes |
|---|---|---|---|
| `field_authority_link` | `authority_link` | all ten vocabularies | Link to an external authority record |
| `field_cat_date_begin` | `edtf` | person, family, corporate_body | Birth / founding / begin date |
| `field_cat_date_end` | `edtf` | person, family, corporate_body | Death / dissolution / end date |
| `field_relationships` | `typed_relation` | person, family, corporate_body | schema.org relations (see below) |
| `field_type` | `list_string` | corporate_body | schema.org / org: organization types |
| `field_geo_geolocation` | `geolocation` | geo_location | Latitude/longitude (WGS 84) |
| `field_geo_broader` | `entity_reference` | geo_location | Broader place term |
| `field_geo_alt_name` / `field_corp_alt_name` / `field_alternate_name` | `string` | geo/corp/person | Alternate names |
| `field_person_preferred_name` / `field_person_alternate_names` | `string` (optional) | person | Structured names |

The `field_relationships` typed-relation field ships a `rel_types` list of schema.org relations
(`schema:knows`, `schema:spouse`, `schema:parent`, `schema:memberOf`, `schema:worksFor`, …) and
references the person/family/corporate_body vocabularies. See the parent field docs:
[typed-relation](../../../2.6.x/agent/fields/typed-relation.md),
[edtf](../../../2.6.x/agent/fields/edtf.md),
[authority-link](../../../2.6.x/agent/fields/authority-link.md).

## RDF mappings (optional)

`config/optional/rdf.mapping.taxonomy_term.<vid>.yml` map each bundle to a schema.org type (e.g.
`person` → `schema:Person`) and its fields to properties — `field_authority_link` → `schema:sameAs`,
`field_cat_date_begin` → `schema:birthDate`, `field_cat_date_end` → `schema:deathDate`, `changed` →
`schema:dateModified` via `CommonDataConverter::dateIso8601Value`. These import only with the `rdf`
module enabled and feed the parent module's JSON-LD normalization.

## Reusing without the defaults

You do not need this submodule to use the fields — it only pre-builds structures. To reuse a single
vocabulary's config on another site, export it (`drush config:get taxonomy.vocabulary.person`) or
build equivalent fields with the snippets in the parent field docs. Uninstalling the submodule does
not remove the created config or content; delete the vocabularies/fields manually if unwanted.
