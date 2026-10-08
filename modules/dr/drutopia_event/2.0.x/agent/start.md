<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Event (drutopia_event) — agent index

A **config-only Features module** from the **Drutopia distribution** that installs an `event`
content type and all its supporting configuration. Package `Drutopia`. Features file marks it
`bundle: drutopia`, `required: true`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.

**Dev checkout:** `drutopia_event.info.yml` has **no `version:` line**, so this is a dev-branch
checkout; the version dir `2.0.x` tracks the 2.0.x dev branch. It normally installs via the
Drutopia distribution, and enabling it standalone requires its full dependency chain
(drutopia_core, drutopia_seo, ds, facets, field_group, paragraphs, pathauto, metatag, search_api,
media, entity_reference_revisions, focal_point, media_library_media_modify,
media_responsive_thumbnail, block_visibility_groups, and more — see info.yml / `data.json`). On
this site it did not enable because those deps are absent; that is expected and does not affect the
docs, which are source-grounded.

## What it actually is

- **No `src/`, no routes, no services, no hooks, no `*.permissions.yml`, no `config/schema/`.**
  Everything is shipped YAML config under `config/install/` and `config/actions/`.
- Provides an **Event node type** (`node.type.event`); the defining field is `field_event_date`, a
  **required datetime range** (start/end) field. Plus `field_event_type` (taxonomy), summary, body,
  paragraph body, media image (and a deprecated legacy `field_image`), tags, topics, meta tags.
- One form display and **seven view displays** (default, full, teaser, card, simple_card, micro,
  search_index); several use the Display Suite (ds) layout engine.
- Provides a **Search API index** (`event`, database server) and a **`views.view.event`** listing:
  a `/events` page ("Events", in the main menu), an **"Upcoming events"** block (events dated
  now-or-later), and a master display.
- Provides **two Facets** (Event type, Event Topics), **two pathauto patterns**, the **`event_type`
  taxonomy vocabulary**, an **"Add event"** action link, and a **block visibility group**.
- Ships **three config actions** that grant event permissions to Drutopia roles
  (contributor / editor / manager).

## Solution docs

- **The Event content type — fields, form display, and the seven view displays** →
  [config/event-content-type.md](config/event-content-type.md)
- **The listing view, facets, Search API index, pathauto, vocabulary, block group, and the role
  permission grants** →
  [config/listing-and-roles.md](config/listing-and-roles.md)

## Dependencies (info.yml)

Core: block, datetime, datetime_range, field, image, media, menu_ui, node, path,
responsive_image, system, taxonomy, text, user, views. Drutopia: drutopia_core, drutopia_seo.
Contrib: block_visibility_groups, ds, entity_reference_revisions, facets, field_group,
focal_point, media_library_media_modify, media_responsive_thumbnail, metatag, paragraphs,
pathauto, search_api. Composer also requires `drupal/token`.
