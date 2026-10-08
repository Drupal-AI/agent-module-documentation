<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Article content type, fields, and displays

All items below are YAML in `config/install/`. This is a config feature installed via the
Drutopia distribution (`composer require drupal/drutopia_article` then enable, or install the
distribution). Enabling imports the config; no code runs.

## Node type — `node.type.article.yml`

- `type: article`, name **Article**, description "Use *articles* for time-sensitive content like
  news, press releases or blog posts."
- `new_revision: true`, `preview_mode: 1` (optional), `display_submitted: true`.

## Fields (`field.field.node.article.*.yml`)

Eleven fields on the `article` bundle. Only `field_article_type` has its storage shipped by this
module (`field.storage.node.field_article_type.yml`, entity_reference → taxonomy_term,
cardinality 1); the other field storages come from core/Drutopia.

| Field name | Label | Type | Notes |
|---|---|---|---|
| `body` | Body | text_with_summary | `display_summary: true`; standard body. |
| `field_summary` | Summary | text_long | **required**; shown on teasers/listings. |
| `field_image` | Image (deprecated) | image | alt required; description says "Use Media image instead." |
| `field_media_image` | Media image | entity_reference_entity_modify | → media bundle `image` (Media library). |
| `field_tags` | Tags | entity_reference | → vocab `tags`, **`auto_create: true`** (free tagging). |
| `field_topics` | Topics | entity_reference | → vocab `topics`, sorted by name. |
| `field_authors` | Authors | entity_reference | → node bundle `people` (Drutopia people). |
| `field_article_type` | Article type | entity_reference | → vocab `article_type` (shipped here). |
| `field_body_paragraph` | Body paragraph | entity_reference_revisions | → paragraphs: text, image, file, video, faq. |
| `field_meta_tags` | Meta tags | metatag | default `a:0:{}`. |
| `comment` | Comments | comment | **required**; default `status: 2` (open), 50/page. |

The `tags`, `topics` vocabularies and the `people` node type are provided by Drutopia
dependencies, not by this module. `field_article_type`'s vocabulary IS shipped (see
`listing-and-roles.md`).

## Form display — `core.entity_form_display.node.article.default.yml`

Single `default` form display arranging the widgets for the fields above (Media library widget
for `field_media_image`, paragraphs experimental/classic widget for `field_body_paragraph`, term
autocomplete for the reference fields, metatag widget, comment settings).

## View displays (view modes)

Nine `core.entity_view_display.node.article.<mode>.yml` files: **default, box, card, full, media,
rss, search_index, simple_card, teaser**. Highlights:

- **default** / **full**: `field_article_type` and `field_authors` render as
  `entity_reference_label`; `field_body_paragraph` as `entity_reference_revisions_entity_view`;
  `full` also renders the `comment` field (`comment_default`) and uses field_group layout regions.
- **card** / **simple_card** / **teaser** / **media** / **box**: compact displays using DS
  (`ds`) regions and `field_group`; images render via `media_responsive_thumbnail`, summary via
  `text_default`. `card` is the row view mode used by the listing view.
- **rss**: outputs `field_summary` (`text_default`) and `field_topics`
  (`entity_reference_rss_category`) for feed output.
- **search_index**: the display fed into the Search API `article` index (labels hidden,
  reference fields as `entity_reference_label`).

All formatters are standard, safe core/contrib display formatters (label, responsive thumbnail,
text_default, rss_category, comment_default, paragraph entity view). Nothing renders raw
user/remote markup.

## Add-article action — `drutopia_article.links.action.yml`

`drutopia_article.add_article` → route `node.add` (`node_type: article`), title "Add article",
`appears_on: view.article.page_listing` (the `/articles` page).
