# Attribution — agent index

Attach author/source/license metadata to fieldable entities via an `attribution` field type
(4 widgets, 6 formatters), plus site-wide **Attribution** and **Copyright** blocks. Licenses are
`attribution_license` config entities imported from the SPDX list. Config UI at
`/admin/structure/attribution-license` (`configure` = `entity.attribution_license.collection`,
perm `administer attribution_license`). No Drush, no custom plugin types.

- **License config entity, importing SPDX licenses, the admin UI + permission, default licenses** → [configure/licenses.md](configure/licenses.md)
- **The `attribution` field type (properties/schema), widgets, formatters, and the two blocks** → [api/field-and-blocks.md](api/field-and-blocks.md)

Key facts:
- Field type `attribution` (`src/Plugin/Field/FieldType/AttributionItem.php`): properties
  `source_name`, `source_link` (uri), `author_name`, `author_link` (uri), `license` (license id).
  Default widget `attribution_source_author_license`; default formatter `attribution_creative_commons`.
- Config entity `attribution_license` (config prefix `attribution.attribution_license`): `id`,
  `identifier` (SPDX), `name`, `osiCertified` bool, `deprecated` bool, `link`.
- Import form `AttributionLicensesForm` reads `composer/spdx-licenses` (400+ licenses) into config
  entities; 9 defaults ship in `config/install`.
- Blocks `attribution` and `attribution_copyright` (`src/Plugin/Block/`) render a disclaimer with
  Token + `@name`/`@link` placeholders. Depends only on core (+ optional `token`).
