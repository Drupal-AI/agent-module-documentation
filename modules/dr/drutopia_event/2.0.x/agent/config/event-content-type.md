<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Event content type — fields, form display, and view displays

All objects below are shipped YAML under `config/install/`. Installing the module imports them;
there is no PHP. Machine name of the bundle is `event`.

## Node type — `node.type.event.yml`

- `type: event`, name **Event**, description "An *event* contains a date."
- `new_revision: true`, `preview_mode: 1`, `display_submitted: false`.
- `menu_ui` third-party settings: available menu `main`, parent `main:` (events can be placed in
  the main menu).
- `core.base_field_override.node.event.promote.yml` overrides the `promote` base field to default
  **on** (Promoted to front page = 1).

## Fields

The defining field is the date range; the rest mirror the other Drutopia content features.

| Field (machine name) | Type / storage | Notes |
|---|---|---|
| `field_event_date` | `daterange` (`datetime_range`, `datetime_type: datetime`), cardinality 1 | **Required.** Default start `now`, default end `+3 hours` (relative). Storage `field.storage.node.field_event_date`. |
| `field_event_type` | `entity_reference` → taxonomy term, cardinality 1 | Target bundle **`event_type`** vocabulary (shipped by this module). Not required. Storage `field.storage.node.field_event_type`. |
| `field_summary` | `text_long` | **Required.** Short teaser text shown on listings/teasers. |
| `body` | `text_with_summary` | Optional; `display_summary: true`. Uses the shared `field.storage.node.body`. |
| `field_body_paragraph` | `entity_reference_revisions` → paragraphs | Target bundles `text`, `image`, `file`. |
| `field_media_image` | `entity_reference_entity_modify` → media (`image` bundle) | Handler `default:media`; edited via media_library_media_modify. |
| `field_image` | `image` | Labelled **"Image (DEPRECATED)"** — legacy field kept for migration; use `field_media_image` instead. |
| `field_tags` | `entity_reference` → `tags` vocabulary | Free tagging, `auto_create: true`. |
| `field_topics` | `entity_reference` → `topics` vocabulary | Structured topics, `auto_create: false`. |
| `field_meta_tags` | `metatag` | Per-node SEO meta tags; default `a:0:{}`. |

The `field.storage.node.field_event_date` and `field.storage.node.field_event_type` storages are
shipped by this module; `body`, `field_summary`, `field_media_image`, `field_image`, `field_tags`,
`field_topics`, `field_meta_tags`, and `field_body_paragraph` storages come from Drutopia
dependencies.

## Form display — `core.entity_form_display.node.event.default.yml`

Widgets: `field_event_date` → `daterange_default`; `field_event_type` and `field_topics` →
`options_select`; `field_tags` → `entity_reference_autocomplete_tags`; `field_body_paragraph` →
`entity_reference_paragraphs` (default paragraph type `text`); `field_media_image` →
`media_library_media_modify_widget`; `field_summary` → `text_textarea`; `field_meta_tags` →
`metatag_firehose`; plus standard title/status/promote/sticky/uid/created/path widgets.

## View displays (seven)

Each is a `core.entity_view_display.node.event.<mode>.yml`; several use the **Display Suite (ds)**
layout engine via `third_party_settings.ds.layout`.

- **default** — full node view, ds layout `ds_1col`.
- **full** — ds layout `ds_3col_stacked`.
- **teaser** — used as the row style of the listing view's master/page displays.
- **card** and **simple_card** — compact card renderings.
- **micro** — minimal rendering, used by the "Upcoming events" block.
- **search_index** — the render mode Search API indexes for the `rendered_item` field.

See [listing-and-roles.md](listing-and-roles.md) for the listing view, facets, Search API index,
pathauto, vocabulary, and the role permission grants.
