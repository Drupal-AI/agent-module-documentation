<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Event content type

Everything here is shipped as **installed config** (under `config/optional/`), not built by code.
Enabling the module creates the type and all of the below; it travels with a normal config export.

## Content type — `node.type.event`

- Machine name: `event`; name "Event"; description "A structured content type used for creating
  various types of events."
- `new_revision: true`, `preview_mode: 0`, `display_submitted: false`.
- Enforced dependency on `acquia_cms_event`, so the type is removed on uninstall.
- Third-party settings wire it into the rest of the family:
  - `acquia_cms_common`: `workflow_id: editorial`, workbench email templates, metatag tag types
    (`basic`, `open_graph`, `schema_event`, `twitter_cards`), `subtype` → field `field_event_type`
    / facet `events_event_type`, `sitemap_variant: default`, `search_index: content`.
  - `menu_ui`: available menu `main`, parent `main:`.
  - `scheduler`: publish + unpublish enabled, vertical-tab fields, `publish_past_date: error`,
    `publish_touch: true`.

## Fields (bundle `node.event`)

| Field | Label | Storage type | Target | Required |
|-------|-------|--------------|--------|----------|
| `body` | Description | text_with_summary (core body) | — | **yes** |
| `field_event_start` | Start Date | `datetime` (date+time) | — | **yes** |
| `field_event_end` | End Date | `datetime` (date+time) | — | no |
| `field_door_time` | Door Time | `datetime` (date+time) | — | **yes** |
| `field_event_duration` | Duration | `string` | — | no |
| `field_event_place` | Place | entity_reference | node (`place`) | no |
| `field_event_image` | Image | entity_reference | media (`image`) | no |
| `field_event_type` | Event Type | entity_reference | taxonomy_term (`event_type`) | no |
| `field_categories` | Categories | entity_reference | taxonomy_term (shared) | no |
| `field_tags` | Tags | entity_reference | taxonomy_term (shared) | no |

All field storages are cardinality 1. `field_event_place` references the **Place** node type from
`acquia_cms_place`; `field_categories` / `field_tags` reference the shared vocabularies from
`acquia_cms_common`. `field_event_place`'s help text tells editors to put the address in the
Description when the event is not at a listed place. `field_event_duration` is a plain string that the
default-content helper fills from start/end (see
[../api/default_content_event_update.md](../api/default_content_event_update.md)).

## Taxonomy

Vocabulary `event_type` ("Event Type"), enforced-dependency on the module. `field_event_type`
references it and doubles as the content type's `subtype` (used by the search facet and the pathauto
pattern).

## Displays & view modes

- Form display: `node.event.default` — the field widgets above, grouped with `field_group`, plus
  scheduler `publish_on` / `unpublish_on` / `publish_state` / `unpublish_state` / `scheduler_settings`,
  `moderation_state`, `path`, `simple_sitemap`, `url_redirects`, `translation`.
- View displays: `default`, `card`, `horizontal_card`, `search_results`, `teaser`.

## Path, metatag, translation

- Pathauto pattern `event_path`:
  `event/[node:field_event_type]/[node:field_event_start:date:custom:Y]/[node:field_event_start:date:custom:m]/[node:title]`,
  scoped to bundle `event` via an `entity_bundle:node` selection condition.
- Metatag defaults `node__event`: Open Graph (`og_type: event`), Twitter `summary_large_image`, and
  schema.org **Event** — `schema_event_start_date`, `schema_event_end_date`, `schema_event_door_time`
  (all from the datetime fields as ISO-8601), `schema_event_location` (a Place built from
  `field_event_place`), `schema_event_image`, `schema_event_name`/`description`.
- `language.content_settings.node.event`: content translation enabled, `language_alterable: true`.

## Extending

Add fields and adjust displays exactly as for any content type; there is no module API to hook for the
type itself. The whole model is Acquia's opinion of an "event" — reuse it as a starting point and
export your changes with the site's config.
