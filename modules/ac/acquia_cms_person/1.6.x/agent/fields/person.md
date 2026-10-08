<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Person content type

Everything here is shipped as **installed config** (under `config/optional/`), not built by code.
Enabling the module creates the type and all of the below; it travels with a normal config export.
There is no `config/schema/` and no `.module` — the only PHP is `acquia_cms_person.install`.

## Content type — `node.type.person`

- Machine name: `person`; name "Person"; description "A structured content type used for creating
  various types of people."
- `new_revision: true`, `preview_mode: 0`, `display_submitted: false`.
- The node `title` base field is relabeled **"Name"** via
  `core.base_field_override.node.person.title`.
- Third-party settings wire it into the rest of the family:
  - `acquia_cms_common`: `workflow_id: editorial`, workbench email templates, metatag tag types
    (`basic`, `open_graph`, `schema_person`, `twitter_cards`), `subtype` → field `field_person_type`
    / facet `people_person_type`, `sitemap_variant: default`, `search_index: content`.
  - `menu_ui`: available menu `main`, parent `main:`.
  - `scheduler`: publish/unpublish enabled, vertical-tab fields, `publish_past_date: error`,
    `publish_touch: true`.
- Enforced dependency on `acquia_cms_person`, so the type is removed on uninstall.

## Fields (bundle `node.person`)

| Field | Label | Storage type | Target | Required | Form widget |
|-------|-------|--------------|--------|----------|-------------|
| `body` | Bio | text_with_summary | — | **yes** | `text_textarea_with_summary` |
| `field_job_title` | Job Title | `string` | — | no | `string_textfield` |
| `field_person_image` | Image | entity_reference | `media` | **yes** | `media_library_widget` |
| `field_person_type` | Person Type | entity_reference | taxonomy_term (`person_type`) | no | `options_select` |
| `field_place` | Place | entity_reference | node (`place`) | no | `options_select` |
| `field_email` | Email | `email` | — | no | `email_default` |
| `field_person_telephone` | Telephone | `telephone` | — | no | `telephone_default` |
| `field_categories` | Categories | entity_reference | taxonomy_term (`categories`) | no | `options_select` |
| `field_tags` | Tags | entity_reference | taxonomy_term (`tags`) | no | `entity_reference_autocomplete_tags` (auto-create) |

All field storages are cardinality 1. Only `field_email`, `field_job_title`, `field_person_image`,
`field_person_telephone` and `field_person_type` ship their `field.storage.node.*` here; `body`,
`field_categories`, `field_tags` and `field_place` reuse storages provided elsewhere (core /
`acquia_cms_common`), so those vocabularies/types (`categories`, `tags`, `place`) must exist —
`field_place` in particular references the `place` node type from `acquia_cms_place`.

## Taxonomy

Vocabulary `person_type` ("Person Type"), enforced-dependency on the module. `field_person_type`
references it and doubles as the content type's `subtype` (used by the search facet
`people_person_type` and the pathauto pattern). `field_categories` / `field_tags` reference the
shared `categories` / `tags` vocabularies.

## Displays & view modes

- Form display: `node.person.default` (widgets in the table above, grouped by `field_group` into a
  **Media** fieldset (`field_person_image`) and a **Taxonomy** fieldset
  (`field_categories`/`field_tags`/`field_person_type`), plus scheduler `publish_on` /
  `unpublish_on` / `publish_state` / `unpublish_state` / `scheduler_settings`, moderation, path,
  sitemap).
- View displays: `default`, `card`, `horizontal_card`, `referenced_image`, `search_results`,
  `teaser`. No extra `core.entity_view_mode` is defined by this module (the view modes it targets
  come from `acquia_cms_common`).

## Path, metatag, translation, GDPR

- Pathauto pattern id `person`: `person/[node:field_person_type]/[node:title]`, scoped to bundle
  `person` via an `entity_bundle:node` selection condition.
- Metatag defaults `node__person`: basic (keywords/description), Open Graph, Twitter cards, and
  schema.org `Person` (`schema_person_name/description/email/telephone/type/image` built from the
  fields).
- `language.content_settings.node.person`: content translation enabled, `language_alterable: true`.
- `gdpr_fields.gdpr_fields_config.node` ships a placeholder GDPR-field map for node (all
  `rtf/rta: 'no'`, no anonymizer) — present for the `gdpr` module but not actively flagging fields.

## Extending

Add fields and adjust displays exactly as for any content type; there is no module API to hook. The
whole model is Acquia's opinion of a "person" — reuse it as a starting point and export your changes
with the site's config.
