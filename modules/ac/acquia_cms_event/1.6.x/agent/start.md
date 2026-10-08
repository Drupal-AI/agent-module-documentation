<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_event — agent index

Feature module in the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit"). Ships a
ready-made **Event** node content type — its date/place/image fields, form and view displays, an
`event_type` taxonomy vocabulary, a pathauto pattern, schema.org-Event metatag defaults,
content-translation settings, plus Search-API views/facets/blocks and Site Studio templates — all as
*installed config* under `config/optional/`. The only PHP is thin glue in
`acquia_cms_event.install` and one default-content date-adjustment helper service. There is **no
settings page** and no routing/drush.

Core: `^9.4 || ^10 || ^11`. Depends on: `acquia_cms_place` (the Place type its `field_event_place`
references), `drupal:datetime`, `schema_metatag:schema_event`. Designed to sit alongside
[`acquia_cms_common`](../../../acquia_cms_common/3.3.x/agent/start.md) — whose editorial workflow,
metatag/subtype layer and `acquia_cms_common.utility` service it wires into via `third_party_settings`
— and the rest of the `acquia_cms_*` family. On an unrelated site it is a strong set of assumptions to
adopt, not a standalone feature.

- **Understand the Event content type, its fields and displays** → [fields/event.md](fields/event.md)
- **Grant/understand the Event node permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Understand the install/update glue and integrator hooks** → [hooks/install.md](hooks/install.md)
- **The default-content date-adjustment helper service** → [api/default_content_event_update.md](api/default_content_event_update.md)
- **Understand the Events listing views, facets and blocks** → [views/events.md](views/events.md)

## Key facts
- Content type: `node.type.event` (machine name `event`), workflow `editorial`, subtype field
  `field_event_type` (facet `events_event_type`), scheduler publish/unpublish enabled.
- Fields on `node.event`: `body` (required), `field_event_start` (datetime, required),
  `field_event_end` (datetime), `field_door_time` (datetime, required), `field_event_duration`
  (string), `field_event_place` (→ node `place`), `field_event_image` (→ media), `field_event_type`
  (→ taxonomy `event_type`), `field_categories`, `field_tags`.
- Taxonomy vocabulary: `event_type` ("Event Type").
- View displays: `default`, `card`, `horizontal_card`, `search_results`, `teaser`; form display
  `node.event.default`.
- Pathauto pattern id `event_path`:
  `event/[node:field_event_type]/[node:field_event_start:date:custom:Y]/[node:field_event_start:date:custom:m]/[node:title]`.
- Metatag defaults: `node__event` (schema.org Event start/end/door-time/location/image, Open Graph
  `og_type: event`, Twitter cards).
- Permissions (provider `node`): `create event content`, `edit own event content`,
  `delete own event content`, `edit any event content`, `delete any event content`.
- Service: `acquia_cms_event.default_content_event_update` → `DefaultContentEventUpdate` (shifts demo
  event dates on default-content import only).
- Views: `events` (Search-API base, page at `/events`), `event_cards` (node base; `upcoming_events_block`
  + `past_events_block`), `events_fallback` (node base). Facets/blocks under `facets.facet.*` /
  `block.block.*` (Site Studio `dx8_hidden` region).
- Install hooks: `hook_content_model_role_presave_alter`, `hook_module_preinstall`; updates 8001–8006.
- No `config/schema/`, no `.module`, no settings/routing/drush.
