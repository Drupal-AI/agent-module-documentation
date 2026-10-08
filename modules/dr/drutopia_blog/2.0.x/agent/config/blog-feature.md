<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Blog feature (content type, fields, displays, view, roles)

Everything below is shipped configuration under `config/install/` and `config/actions/` — the
module contains no PHP. `drutopia_blog.features.yml` marks this a Features `drutopia` bundle whose
one *required* config is `core.entity_view_display.node.blog.search_index`.

## Install / enable

```bash
drush en drutopia_blog -y   # needs the full Drutopia dependency chain present
```

No settings route (`configure` is null). After enabling, operate it through the normal node,
*Structure → Content types*, *Manage display*, Views and Facets UIs.

## Node type — `node.type.blog.yml`

- `type: blog`, name **Blog**, description "Use *blog* for personal or journal-like posts."
- `preview_mode: 1` (optional preview), `display_submitted: true`, `new_revision: false`.
- `menu_ui` third-party settings: available menu `main`, parent `main:`.

## Fields on `node.blog` (`field.field.node.blog.*.yml`)

| Field | Type | Notes |
|---|---|---|
| `body` | text_with_summary | Optional; `display_summary: true`. |
| `field_summary` | text_long | **Required**; shown on teasers/listing. |
| `field_body_paragraph` | entity_reference_revisions | Paragraphs: `text`, `image`, `file`. |
| `field_media_image` | entity_reference_entity_modify | Media (`image` bundle); Media-library widget. |
| `field_image` | image | **Label "Image (DEPRECATED)"**; alt required; not used in default form region. |
| `field_authors` | entity_reference | → `people` nodes (from drutopia_people), sorted by title. |
| `field_tags` | entity_reference | → `tags` vocab; free-tagging (`auto_create: true`). |
| `field_topics` | entity_reference | → `topics` vocab; select, no auto-create. |
| `field_meta_tags` | metatag | Per-node SEO meta. |
| `comment` | comment | `default_mode: 1`, 50/page, `status: 2` (open) default. |

The `tags`, `topics` and `people` targets are **not defined by this module** — they are shared
vocabularies/bundles from other Drutopia modules; the field configs merely reference them.

## Form display — `core.entity_form_display.node.blog.default.yml`

Widgets: `field_summary` textarea, `field_body_paragraph` `entity_reference_paragraphs`
(default paragraph type `text`), `field_media_image` `media_library_media_modify_widget`,
`field_authors` / `field_tags` autocomplete, `field_topics` options_select,
`field_meta_tags` `metatag_firehose`, `comment` widget, path + promote/sticky checkboxes.
`body` and the deprecated `field_image` are **hidden** in the form.

## View displays — `core.entity_view_display.node.blog.*.yml`

Seven modes: `default`, `teaser`, `card`, `simple_card`, `media`, `full`, `search_index`. All use
Display Suite (`ds`) layouts and `field_group`. Formatters are stock: `field_body_paragraph` →
`entity_reference_revisions_entity_view`; `field_media_image` → `media_responsive_thumbnail`
(style `drutopia_main`, lazy loading); `field_authors`/`field_tags`/`field_topics` →
`entity_reference_label` (linked); `body` via its text format. `field_image`, `field_meta_tags`,
`field_summary`, `links`, `search_api_excerpt` are hidden in `full`.

## The listing view — `views.view.blog.yml`

- id `blog`, base table `search_api_index_blog` (so it queries the Search API index, not the
  node table). Access plugin `perm` → **`access content`**.
- Displays:
  - `default` (Master) — `search_api` rows rendering nodes in the `card` view mode.
  - `block_promoted` — block display filtered to promoted posts.
  - `page_listing` — page at **`/blog`**, mini pager 12/page. The "Add blog" action link
    (`drutopia_blog.links.action.yml` → `node.add/blog`) appears here.

## Search index & facet

- `search_api.index.blog.yml` — index id `blog` on server `database`; indexes rendered item,
  title (boost 8), `field_tags`, `field_topics`, `created`, `uid`, node grants (locked).
- `facets.facet.blog_topics.yml` — id `blog_topics` "Blog Topics", field `field_topics`, checkbox
  widget (numbers on, soft-limit 10), `query_operator: or`, source
  `search_api:views_page__blog__page_listing`.

## Pathauto & block visibility

- `pathauto.pattern.node_blog.yml` — id `node_blog`, pattern **`blog/[node:title]`**, applied to
  bundle `blog`.
- `block_visibility_groups.block_visibility_group.blog_listing.yml` — group `blog_listing`,
  condition `request_path` = `/blog` (for placing listing-only blocks).

## Role grants — `config/actions/user.role.{contributor,editor,manager}.yml`

These are **config_actions** patches (plugin `add`) that append permissions to existing Drutopia
roles (and add `node.type.blog` to each role's config dependencies). Exact grants:

| Role | Permissions added |
|---|---|
| `contributor` | `create blog content`, **`edit own blog content`** |
| `editor` | `create blog content`, **`edit any blog content`** |
| `manager` | `create blog content`, **`edit any blog content`** |

No role receives delete, administer, bypass or any site-admin permission from this module — the
grants are limited to creating and editing blog nodes (contributor bounded to own content).
