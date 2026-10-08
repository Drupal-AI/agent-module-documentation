<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Controlled Access Terms Defaults (controlled_access_terms_defaults) — agent index

Config-only submodule of **controlled_access_terms**. Enabling it installs a ready-made set of
taxonomy **vocabularies** (bundles) for archival/library authorities — person, family, corporate
body, subject, geographic location, and more — each pre-wired with the parent module's fields
(EDTF dates, authority links, typed relations) plus form/view displays, language settings, and
optional RDF mappings. There is no code and no settings page; it exists to save you from building
these structures by hand.

- **No settings page** (`configure` = null). Everything is shipped as `config/install` (installed on
  enable) and `config/optional` (installed if the relevant modules are present).
- No permissions, no Drush, no config schema, no plugins — pure default content configuration.
- Requires the parent [controlled_access_terms](../../../2.6.x/agent/start.md) plus core `field`,
  `taxonomy`, `node`, `text`, `options`, `language`, `content_translation`, `menu_link_content`,
  `path`, `user`, and `geolocation`.

## Solution docs

- **What vocabularies/fields get installed, and how to reuse/override them** → [configure/vocabularies.md](configure/vocabularies.md)

## Key facts

- Vocabularies (`vid`): `person`, `family`, `corporate_body`, `subject`, `geo_location`, `genre`,
  `language`, `physical_form`, `resource_types`, `temporal_subjects`
- Shared fields: `field_authority_link` (authority_link), `field_cat_date_begin` /
  `field_cat_date_end` (edtf), `field_relationships` (typed_relation), plus `field_type`
  (list_string), `field_geo_geolocation` (geolocation), `field_geo_broader` (entity_reference), and
  several `string` alternate-name fields
- Optional config: `rdf.mapping.taxonomy_term.*` (schema.org types) and the person
  `field_person_preferred_name` / `field_person_alternate_names` fields
