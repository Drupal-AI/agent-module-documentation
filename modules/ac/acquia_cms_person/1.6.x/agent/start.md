<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_person — agent index

Feature module in the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit"). Ships a
ready-made **Person** node content type — its fields, form/view displays, a `person_type` taxonomy
vocabulary, a pathauto pattern, metatag defaults, content-translation settings, plus Search-API
views/facets/blocks and Site Studio templates — all as *installed config*. The only PHP is thin
glue in `acquia_cms_person.install`. There is **no settings page** and no routing/services/drush.

Core: `^9.4 || ^10 || ^11`. Depends on: `acquia_cms_place:acquia_cms_place`, `scheduler:scheduler`.
It wires into `acquia_cms_common` (workflow, metatag, `acquia_cms_common.utility` service) which it
pulls in transitively through `acquia_cms_place` — `acquia_cms_common` is a hard runtime dependency
even though it is not named in the `.info.yml`. On an unrelated site this is a strong set of
assumptions to adopt (it expects the `place`, `categories` and `tags` types to exist).

- **Understand the Person content type, its fields and displays** → [fields/person.md](fields/person.md)
- **Grant/understand the Person node permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Understand the install/update glue and integrator hooks** → [hooks/install.md](hooks/install.md)
- **Understand the People listing views, facets and blocks** → [views/people.md](views/people.md)

## Key facts
- Content type: `node.type.person` (machine name `person`), workflow `editorial`, subtype field
  `field_person_type`; node `title` relabeled "Name".
- Fields on `node.person`: `body` (Bio, required), `field_job_title`, `field_person_image` (required),
  `field_person_type`, `field_place` (→ `place` node), `field_email`, `field_person_telephone`,
  `field_categories`, `field_tags`.
- Ships storages for `field_email`, `field_job_title`, `field_person_image`,
  `field_person_telephone`, `field_person_type` (all cardinality 1); `body`/`field_categories`/
  `field_tags`/`field_place` reuse storages from core/`acquia_cms_common`.
- Taxonomy vocabulary: `person_type` ("Person Type").
- View displays: `default`, `card`, `horizontal_card`, `referenced_image`, `search_results`, `teaser`.
- Pathauto pattern id `person`: `person/[node:field_person_type]/[node:title]`.
- Metatag defaults: `node__person` (schema.org Person, Open Graph, Twitter cards).
- Permissions (provider `node`): `create person content`, `edit own person content`,
  `delete own person content`, `edit any person content`, `delete any person content`.
- Views: `people` (Search-API index base, page path `people`), `people_fallback` (node base).
  Facets `people_category`/`people_person_type`/`search_person_type`; matching `facet_block:*` blocks
  in the Site Studio `dx8_hidden` region.
- Install hooks: `hook_content_model_role_presave_alter`, `hook_module_preinstall`; updates 8001–8005.
- No `config/schema/`, no `.module`, no permissions/settings UI beyond the above.
