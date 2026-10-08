<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webpage` content type

All config below ships in `recipes/default/config/` and is applied by the default recipe. There is
no settings form — you manage it like any core content type at
`/admin/structure/types/manage/webpage`.

## The content type (`node.type.webpage.yml`)

- `type: webpage`, name **Webpage**, `new_revision: true`, `preview_mode: 1`,
  `display_submitted: false`.
- `help`: "Use *Webpage* to add a publicly accessible web page built with Display Builder."
- `third_party_settings.menu_ui`: available menus `[main]`, parent `main:` — new Webpage nodes can
  be placed directly in the main menu, which drives the Pathauto alias (below).

## Fields

Manage fields shows a single configured field on top of the node base fields:

![Webpage Manage fields](../../../../../../../screenshots/webpage/12.0.x/manage-fields.png)

- **Body** (`field.field.node.webpage.body`) — type `text_with_summary`, not required,
  translatable, `display_summary: false`. Backed by the shared `field.storage.node.body`
  (`text_with_summary`, cardinality 1, `persist_with_no_fields: true`).
- **Promoted to front page** — `core.base_field_override.node.webpage.promote` sets the base
  `promote` field's default to **0** (off) for this bundle.

## Form display (`core.entity_form_display.node.webpage.default.yml`)

Editing widgets, by weight: Title (0), Body (`text_textarea_with_summary`, 9 rows), Path (3),
Authored by / uid (4), Authored on / created (5), Published/status (6), Promote (7), Sticky (8).

![Create Webpage form](../../../../../../../screenshots/webpage/12.0.x/create-webpage.png)

## View modes & Display Builder

- `core.entity_view_mode.node.teaser` — enabled (`status: true`).
- `core.entity_view_mode.node.full` — **`status: false`** (present but disabled by default).
- **default** view display (`...node.webpage.default`) — plain field UI: Body rendered with
  `text_default`, label hidden; `links` hidden.
- **full** view display (`...node.webpage.full`) — rendered through **Display Builder**
  (`third_party_settings.display_builder`, profile `default`). The Body field is moved out of the
  classic `content` region (`hidden.body: true`) and provided to Display Builder as an
  `entity_field` source using the `text_default` formatter; `links` shown at weight 100.
- **teaser** view display (`...node.webpage.teaser`) — also Display Builder (profile `default`),
  Body provided via a **`smart_trim`** formatter (`trim_length: 300` chars, `more_link: true`,
  "More" text) for listing excerpts.

So the page layout mechanism in 12.0.x is **Display Builder**, not the classic Layout Builder — the
`teaser`/`full` displays delegate rendering to the `display_builder` default profile.

## Editorial workflow (`workflows.workflow.editorial.yml`)

Content-moderation workflow `editorial`, bound to `node:webpage`, `default_moderation_state: draft`.

- **States**: Draft (unpublished, weight -5), Published (published, default revision, weight 0),
  Archived (unpublished, default revision, weight 5).
- **Transitions**: Create New Draft (draft/published → draft), Publish (draft/published → published),
  Archive (published → archived), Restore (archived → published), Restore to Draft (archived → draft).

New pages therefore start unpublished as **Draft** until an editor runs the Publish transition.

## URL aliases (`pathauto.pattern.webpage.yml`)

Pattern id `webpage`, type `canonical_entities:node`, selection limited to the `webpage` bundle
(`entity_bundle:node`). Alias pattern **`[node:menu-link:parent:url]/[node:title]`** — the alias is
the parent menu link's path plus the node title, giving nested site-section URLs when pages are
placed in the main menu.

## How an editor uses it

1. Go to `/node/add/webpage`, fill Title and Body, optionally choose a main-menu parent.
2. Save — the node is created as **Draft** (unpublished) with a Pathauto alias derived from its
   menu placement and title.
3. Use the moderation state control to **Publish** when ready; **Archive** / **Restore** later.
4. Front-page promotion is via the **Promote** checkbox (off by default).
