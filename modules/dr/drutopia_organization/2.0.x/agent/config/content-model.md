<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Organization content model, listing & role grant

Everything here is shipped configuration (`config/install/`, `config/optional/`, `config/actions/`) plus `drutopia_organization.links.action.yml` and `drutopia_organization.features.yml`. There is no PHP. Install/enable the module (`drush en drutopia_organization`) to import the config; the Features manifest bundle is `drutopia`, with `core.entity_view_display.node.organization.search_index` marked required.

## Content type
`node.type.organization` — machine name `organization`, name "Organization". `new_revision: true`, `preview_mode: 1`, `display_submitted: false`. `third_party_settings.menu_ui` enables the `main` menu (parent `main:`), so organizations can be placed in the main menu.

## Fields (bundle organization)
- `title` — base field override `core.base_field_override.node.organization.title`: label **"Organization name"**, required.
- `promote` — base field override: label "Promoted to front page", default 0.
- `field_summary` (`text_long`, **required**, translatable) — short description shown on teasers/cards. From storage in drutopia_core.
- `body` (`text_with_summary`, `display_summary: true`) — hidden on every view display (see below), kept but unused in output.
- `field_body_paragraph` (`entity_reference_revisions` → paragraph), label **"Description"** — `negate: 1` with all `target_bundles_drag_drop` disabled, i.e. all paragraph bundles allowed by negation.
- `field_image` (`image`) — `alt_field_required: true`, extensions `png gif jpg jpeg`, file dir `[date:custom:Y]-[date:custom:m]`.
- `field_organization_type` (`entity_reference` → taxonomy_term) — storage `field.storage.node.field_organization_type` (defined in this module, cardinality 1), target bundle `organization_type`, `auto_create: false`. Description points editors to `/admin/structure/taxonomy/manage/organization_type/overview`.
- `field_topics` (`entity_reference` → taxonomy_term) — target bundle `topics` (vocab from drutopia_core), sorted by name asc.
- `field_meta_tags` (`metatag`) — SEO meta tags.

Storage note: `field.storage.node.field_organization_name` (entity_reference → taxonomy_term, cardinality 1) is shipped **without any matching `field.field` instance** — it is vestigial/orphaned in this release, as is the `organization` vocabulary that would back it.

## Form display
`core.entity_form_display.node.organization.default` — fields ordered: title, organization_type (options_select), image (`image_focal_point`, preview `thumbnail`), summary (textarea 5 rows), body_paragraph (`entity_reference_paragraphs`, edit_mode open, add_mode button, default paragraph type `text`), uid, created, promote, sticky, path, status, meta_tags (`metatag_firehose`), topics (autocomplete), url_redirects. `body` is hidden. Also ships form mode `core.entity_form_mode.node.inline` ("Inline").

## View displays (Display Suite)
- `default` — DS `ds_1col`; shows only `field_topics` (entity_reference_label, linked); most fields hidden.
- `full` — DS `ds_2col`; left = image (responsive `tall`), right = body_paragraph (rendered), organization_type (linked label), links.
- `teaser` — DS `ds_2col`; left = image (responsive `narrow`), right = node_title (h2 link), summary. Note the DS region references `field_organization_position` (a field not defined by this module; carried over from a shared template — has no effect here).
- `small_card` — DS `ds_1col` + field_group `group_card_content`; image (responsive `short`) + card group (node_title). Used as the listing row view mode.
- `search_index` — DS `ds_1col`; image, body_paragraph, organization_type — used for the Search API `rendered_item`.

## Listing: Search API index + view + facet
- `search_api.index.organization` — server `database`, indexes bundle `organization`; fields include title (boost 8), field_summary, field_organization_type, name (author), rendered_item (view mode `search_index`), status/uid/node_grants (locked). Processors: content_access, html_filter, ignorecase, stopwords, tokenizer, transliteration, add_url, rendered_item. `index_directly: true`, cron_limit 50.
- `views.view.organization` — base table `search_api_index_organization`, title "Our organization". Master + `page_listing` (page at path `organization`, main-menu link "Organization"). Row plugin `search_api` using `small_card` view mode; results **grouped by** `field_organization_type`; pager none; sorts by organization_type asc then created desc. **Access:** `type: perm`, `perm: access content` (read-only listing of published content; `content_access` processor still enforces node grants).
- `facets.facet.organization` — id `organization`, field `field_organization`, checkbox widget with counts, `min_count: 1`, `query_operator: or`. Its `facet_source_id` is `search_api:views_page__event__page_listing` — i.e. this facet filters the **Event** listing by referenced organization, not the organization listing.

## Taxonomies & pathauto
- Vocabularies `organization` ("Organization name.") and `organization_type` ("For categorizing organization content.").
- `pathauto.pattern.organization_node` — `organization/[node:title]` for bundle organization (weight -5).
- `pathauto.pattern.organization_type` — `[term:vocabulary]/[term:name]` for organization_type terms (weight -5).

## Optional: Event → Organization reference
`config/optional/` (installed only if the Event type exists): `field.storage.node.field_organization` (node ref, cardinality -1) + `field.field.node.event.field_organization` labelled "Organization", target bundle organization. Lets an Event name one or more host organizations; this is what the organization facet on the event listing filters on.

## Contributor role grant (config action)
`config/actions/user.role.contributor.yml` uses the config_actions `add` plugin on `path: [permissions]` of `user.role.contributor`, appending exactly these three permissions:
- `create organization content`
- `edit own organization content`
- `delete own organization content`

Scope is limited to own content plus create — no "edit any"/"delete any", no administrative permission. Only the `contributor` role is touched (unlike some sibling features that also grant editor/manager). The permission strings are the standard core node-type permissions generated for the `organization` bundle; this module defines no permissions of its own.
