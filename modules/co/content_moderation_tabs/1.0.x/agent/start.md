<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Tabs (content_moderation_tabs) — agent index

Adds **local-task tabs to the Content admin page** (`/admin/content`) — one tab per configured
content-moderation workflow **state** — so editors can jump straight to a per-state listing (e.g. an
"In progress" tab for drafts, "Needs signoff" for in-review) instead of the single core "Moderated
content" list. Each tab opens a **View** (page display) you pick. Depends on core `content_moderation`.
info.yml name **Content Moderation Tabs**, version **1.0.0-alpha1**, core `^11.1 || ^12`, package `Content`.
By Agaric; torn out of Trash Workflows. Early alpha — read the source, several pieces are stubbed.

## What it actually does (read the source, not the old stub)

- **Configured on the workflow-state form, not a settings page.** `src/Hook/FormAlter.php`
  (`#[Hook('form_workflow_state_edit_form_alter')]`) adds a "Content Moderation Tab settings" fieldset
  to each Content-Moderation workflow **state** edit form: *Enable tab*, *Tab title* (defaults to the
  state label), *Tab weight*, *View page* (a `select` of every enabled Views **page** display, value
  `view.<view_id>.<display_id>`), and a free-text *Fallback route*. The extra submit handler
  `submitWorkflowStateContentModerationTab()` writes these into the `content_moderation_tabs.tabs`
  config object under `workflow_states` (a flat sequence keyed by workflow+state). Nothing is saved if
  neither a view route nor a fallback route is given (and it deletes any existing entry in that case).
- **Tabs are generated from config**, not routing. `src/Plugin/Derivative/DynamicLocalTasks.php`
  reads `content_moderation_tabs.tabs`, and for each **enabled** state whose `views_route` (preferred)
  or `fallback_route` resolves to a real route (checked against the router), emits a local task under
  `parent_id: system.admin_content` with the configured title and weight. Wired via
  `content_moderation_tabs.links.task.yml` (`deriver: DynamicLocalTasks`). Tabs therefore appear only
  after you point a state at an existing route; the target route enforces its own access.
- **Settings route is a dead stub.** `content_moderation_tabs.routing.yml` +
  `content_moderation_tabs.links.menu.yml` + info.yml `configure:` all point at route
  `content_moderation_tabs.settings` → `_form: \Drupal\content_moderation_tabs\Form\Settings`
  (perm `administer workflows`), **but that Form class is not shipped in this alpha**, so the config
  link / menu item is non-functional. Real configuration happens on the workflow-state form above.
- **Non-Views fallback listing exists but is unwired.** `src/Controller/ModeratedContentController.php`
  + `src/ModeratedNodeListBuilder.php` build a node-revision listing for a given moderation state
  (aggregate query on `content_moderation_state`, `accessCheck(TRUE)`, paged, adds a "Moderation state"
  column). Intended as the built-in fallback for sites without Views — **but no route registers this
  controller**, so nothing reaches it in 1.0.0-alpha1 unless a site adds its own route.
- **Planned-but-absent:** removing the core "Moderated content" tab (mentioned in the project page, not
  implemented).

## Config
- Config object **`content_moderation_tabs.tabs`** (schema in `config/schema/…`): `workflow_states`
  sequence, each entry `{workflow, state, cmt_settings:{enabled, label, weight, views_route,
  fallback_route}}`. No default config ships; entries are created via the workflow-state form.

## Files
- `data.json` — metadata.
- `usage.md` — one-liner / mechanism / use cases.
- `human-docs/` — human setup guide (installation + how-to).
