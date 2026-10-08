<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Place content type

Everything here is shipped as **installed config** (under `config/optional/`), not built by code.
Enabling the module creates the type and all of the below; it travels with a normal config export.

## Content type — `node.type.place`

- Machine name: `place`; name "Place"; description "A structured content type used for creating
  various types of places."
- `new_revision: true`, `preview_mode: 0`, `display_submitted: false`.
- Third-party settings wire it into the rest of the family:
  - `acquia_cms_common`: `workflow_id: editorial`, workbench email templates, metatag tag types
    (`basic`, `open_graph`, `schema_place`, `twitter_cards`), `subtype` → field `field_place_type`
    / facet `places_place_type`, `sitemap_variant: default`, `search_index: content`.
  - `menu_ui`: available menu `main`, parent `main:`.
  - `scheduler`: publish/unpublish enabled, vertical-tab fields, `publish_past_date: error`.
- Enforced dependency on `acquia_cms_place`, so the type is removed on uninstall.

## Fields (bundle `node.place`)

| Field | Label | Storage type | Target | Required | Form widget |
|-------|-------|--------------|--------|----------|-------------|
| `body` | Description | text_with_summary | — | no | `text_textarea_with_summary` |
| `field_place_address` | Address | `address` | — | **yes** | `address_default` |
| `field_geofield` | Geofield | `geofield` | — | no | `geofield_latlon` |
| `field_place_image` | Image | entity_reference | `media` | **yes** | `media_library_widget` |
| `field_place_telephone` | Telephone | `telephone` | — | no | `telephone_default` |
| `field_place_type` | Place Type | entity_reference | taxonomy_term (`place_type`) | no | `options_select` |
| `field_categories` | Categories | entity_reference | taxonomy_term | no | `options_select` |
| `field_tags` | Tags | entity_reference | taxonomy_term | no | `entity_reference_autocomplete_tags` |

All field storages are cardinality 1. `field.storage.node.field_place` (a node entity_reference)
also ships but is not attached to the Place form/displays in this release.

### Address → Geofield geocoding

`field_geofield`'s `geocoder_field` third-party settings auto-populate the point from
`field_place_address` on save: `method: geocode`, `field: field_place_address`,
`providers: [googlemaps]`, `dumper: wkt`, `delta_handling: s_to_m`, failure handling `preserve`
(logs + status message). The provider's API key must be set — see
[../configure/geocoder.md](../configure/geocoder.md).

## Taxonomy

Vocabulary `place_type` ("Place Type"), enforced-dependency on the module. `field_place_type`
references it and doubles as the content type's `subtype` (used by search facets and the pathauto
pattern). `field_categories` / `field_tags` reference other (shared) vocabularies.

## Displays & view modes

- Form display: `node.place.default` (widgets in the table above, plus scheduler `publish_on` /
  `unpublish_on` / `publish_state` / `unpublish_state`, moderation, path, sitemap).
- View displays: `default`, `card`, `horizontal_card`, `places`, `referenced_image`,
  `search_results`, `teaser`.
- Extra view mode defined: `core.entity_view_mode.node.places` ("Places", cached).

## Path, metatag, translation

- Pathauto pattern `place_path`: `place/[node:field_place_type]/[node:title]`, scoped to bundle
  `place` via an `entity_bundle:node` selection condition.
- Metatag defaults `node__place`: Open Graph (`og_type: place`), Twitter `summary_large_image`, and
  schema.org `Place` (name/description/address/image/telephone built from the fields).
- `language.content_settings.node.place`: content translation enabled, `language_alterable: true`.

## Extending

Add fields and adjust displays exactly as for any content type; there is no module API to hook. The
whole model is Acquia's opinion of a "place" — reuse it as a starting point and export your changes
with the site's config.
