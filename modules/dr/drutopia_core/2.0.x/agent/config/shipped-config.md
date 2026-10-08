<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped configuration (grouped)

`config/install/` holds ~155 YAML files (plus 5 config-action files in `config/actions/`). This is a grouped summary — not a file-by-file dump. Roles are covered separately in [roles.md](roles.md).

## Roles & permissions
- 4 base role entities in `config/install` (`administrator` with `is_admin: true`, `contributor`, `editor`, `manager`) + 5 permission-adding config actions (`anonymous`, `authenticated`, `contributor`, `editor`, `manager`). Details in [roles.md](roles.md).
- 2 `config_perms.custom_perms_entity.*` (Config Perms custom permissions): `administer_site_information`, `edit_contact_form`.

## Media (5 types)
- `media.type.*`: `image`, `document`, `audio`, `video`, `remote_video` (oEmbed).
- Per media type: `field.field.media.*` source fields (`field_media_image`, `field_media_document`, `field_media_audio_file`, `field_media_video_file`, `field_media_oembed_video`) with matching `field.storage.media.*`.
- Media entity form/view displays: `default`, `media_library` (a `main` image form mode too), plus `narrow` and `wide` image view modes/displays. One `core.entity_form_mode.media.main`.

## Paragraphs (7 types)
- `paragraphs.paragraphs_type.*`: `text`, `image`, `file`, `faq`, `slide`, `video`, `update`.
- Their fields (`field.field.paragraph.*` + `field.storage.paragraph.*`): `field_text`, `field_image`/`field_media_image`, `field_file`/`field_media_document`, `field_faq` (FAQ Field), `field_link`, `field_update_date`, `field_video_embed` (Video Embed Field).
- Form displays (7) and view displays (8, incl. a `slide.columnar`) plus a `paragraph.columnar` view mode.

## Node fields
- `field.storage.node.*`: `body`, `field_body_paragraph`, `field_paragraph`, `field_image`, `field_media_image`, `field_summary`, `field_tags`, `field_topics`.
- Node view modes (`core.entity_view_mode.node.*`): `box`, `card`, `media`, `micro`, `search_index`, `simple_card`, `small_card`, `tile`. (Also `block_content.columnar` view mode and a `block_content` `field_slide` storage.)

## Image & responsive image styles
- 27 `image.style.*`: the `drutopia_*` family (square / wide / extra-wide in extra_small→extra_large sizes, plus `drutopia_wide`), the `focal_point_*` family (e.g. `focal_point_1300x650`, `focal_point_220_square`, `focal_point_780x1040`), plus `small_square` and `square_thumbnail`.
- 7 `responsive_image.styles.*`: `drutopia_card`, `drutopia_main`, `drutopia_wide`, `narrow`, `short`, `square`, `tall`.
- 3 `crop.type.*`: `square`, `wide_rectangle`, `extra_wide_rectangle`.

## Taxonomy & RDF
- 2 vocabularies (`taxonomy.vocabulary.*`): `tags`, `topics`.
- 2 `rdf.mapping.taxonomy_term.*` for those vocabularies.

## URLs, dates & search
- 2 `pathauto.pattern.*`: `generic_content` (`[node:content-type]/[node:title]`) and `generic_term`.
- 1 `core.date_format.month_day_year` (`F j, Y`).
- 1 `search_api.server.database` — a Search API "Database Server" using the `search_api_db` backend on Drupal's `default:default` database (no external endpoint, no credentials; `min_chars: 3`, whole-word matching).

## Breakpoints
- `drutopia_core.breakpoints.yml` defines six breakpoints used by the responsive image styles: `all`, `mobile` (≤768px), `tablet` (769–999px), `desktop` (1000–1191px), `widescreen` (1192–1383px), `fullhd` (≥1384px), each with 1x/2x multipliers.

## Not shipped
- **No text formats** (`filter.format.*`) and no editor config — CKEditor 5 and text formats are provided by core / the install profile, not by this module.
- No `config/schema/` (`provides_config_schema=false`), no routes, services or permission definitions.

## Features metadata
`drutopia_core.features.yml`: `bundle: drutopia`, `required: true`, with an `excluded` list of the auto-generated `*.token` entity view modes and the `administer_groups` custom-perms entity (so Features does not manage those).
