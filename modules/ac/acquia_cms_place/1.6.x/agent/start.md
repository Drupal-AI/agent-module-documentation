<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_place — agent index

Feature module in the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit"). Ships a
ready-made **Place** node content type — its fields, form/view displays, a `place_type` taxonomy
vocabulary, a pathauto pattern, metatag defaults, content-translation settings, plus Search-API
views/facets/blocks and Site Studio templates — all as *installed config*. The only PHP is thin
glue in `acquia_cms_place.install`. There is **no settings page** and no routing/services/drush.

Core: `^9.4 || ^10 || ^11`. Depends on: `acquia_cms_image`, `address`, `path`, `scheduler`,
`telephone`, `field_group`, `geocoder:geocoder_address`, `geocoder:geocoder_geofield`. Designed to
sit alongside `acquia_cms_common` (whose workflow, metatag and utility layer it wires into) and the
rest of the `acquia_cms_*` family; on an unrelated site it is a strong set of assumptions to adopt.

- **Understand the Place content type, its fields and displays** → [fields/place.md](fields/place.md)
- **Grant/understand the Place node permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Set the Google Maps API key used to geocode addresses** → [configure/geocoder.md](configure/geocoder.md)
- **Understand the install/update glue and integrator hooks** → [hooks/install.md](hooks/install.md)
- **Understand the Places listing views, facets and blocks** → [views/places.md](views/places.md)

## Key facts
- Content type: `node.type.place` (machine name `place`), workflow `editorial`, subtype field `field_place_type`.
- Fields on `node.place`: `body`, `field_place_address` (required), `field_place_image` (required),
  `field_geofield`, `field_place_telephone`, `field_place_type`, `field_categories`, `field_tags`.
- Taxonomy vocabulary: `place_type` ("Place Type").
- View modes/displays: `default`, `card`, `horizontal_card`, `places`, `referenced_image`,
  `search_results`, `teaser`; extra view mode `node.places`.
- Pathauto pattern id `place_path`: `place/[node:field_place_type]/[node:title]`.
- Metatag defaults: `node__place` (schema.org Place, Open Graph, Twitter cards).
- Geocoder provider: `geocoder.geocoder_provider.googlemaps` (`apiKey` ships empty) — `field_geofield`
  is auto-geocoded from `field_place_address` (geocoder_field third-party setting, wkt dumper).
- Permissions (provider `node`): `create place content`, `edit own place content`,
  `delete own place content`, `edit any place content`, `delete any place content`.
- Views: `places` (Search-API index base), `places_fallback` (node base). Facets/blocks under
  `facets.facet.*`, `block.block.*` (Site Studio `dx8_hidden` region).
- Install hooks: `hook_content_model_role_presave_alter`, `hook_module_preinstall`; updates 8001–8005.
- No `config/schema/`, no `.module`, no permissions/settings UI beyond the above.
