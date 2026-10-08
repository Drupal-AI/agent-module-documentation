# Configure — toolbar tab, sidebar actions & settings

## The toolbar "Tasks" tab

`moderation_sidebar_toolbar()` (in `moderation_sidebar.module`) adds a toolbar item, but only
when **all** hold: the user has `use moderation sidebar`; the current route has a content
entity parameter; that entity is **revisionable**, not new, and you are **not** on an admin
route. The tab is a `use-ajax` link titled **Tasks** with `data-dialog-renderer: off_canvas`,
so clicking it loads the sidebar into a core off-canvas dialog (library
`moderation_sidebar/main`, deps `core/drupal.dialog.off_canvas`, `core/jquery`, `core/once`).
Its CSS class/`data-label` reflect state: `moderation-label-published`,
`-draft`, or `-draft-available` ("Draft available" when a published default revision has a
pending draft).

## What the sidebar shows

Built by `ModerationSidebarController::sideBar($entity)` at
`/moderation-sidebar/{entity_type}/{entity}` (route `moderation_sidebar.sidebar`) and
`/moderation-sidebar/{entity_type}/{entity}/latest` (`moderation_sidebar.sidebar_latest`, loads
the latest revision). For a moderated entity it renders:

- State label + revision author and a "time ago" of the current revision.
- **Primary:** `View existing draft` (published default with a pending draft),
  `View live content` (viewing a pending non-default revision), `Edit content`/`Edit draft`,
  `Delete content` (default revision only), and the quick-transition buttons.
- **Secondary:** `Show revisions` (nodes; route `moderation_sidebar.node.version_history`,
  lists last 5), `Translate` (when `content_translation` is enabled; routes
  `moderation_sidebar.translate` / `.translate_latest`), and de-duplicated entity local tasks.

All buttons respect the entity's own `access('update'/'delete'/…')` checks.

## Quick transitions (`QuickTransitionForm`)

Rendered inline for the latest revision. It offers one submit button per **valid** transition
from core's `content_moderation.state_transition_validation` for the current user, **excluding**
self-transitions and any transition disabled in settings. A `Discard draft` button appears on a
non-default latest-affected revision (re-saves the default revision as a new revision). An
optional "Use custom log message" checkbox + textarea sets the revision log; otherwise a default
message like *Used the Moderation Sidebar to change the state to "…"* is used. Each action saves
a **new revision** and redirects to the entity (or its latest-version route if a pending revision
remains).

## Settings form

Route `moderation_sidebar.settings` at `/admin/config/user-interface/moderation-sidebar`
(permission `administer moderation sidebar`; `configure` key in info.yml). For each Workflow
entity it shows a checkboxes group of that workflow's transitions; checked ones are stored under
`workflows.{workflow_id}_workflow.disabled_transitions` in the `moderation_sidebar.settings`
config object and hidden from the sidebar. Config schema:
`config/schema/moderation_sidebar.schema.yml`. No `config/install` default is shipped (empty
until saved). Deploy with `drush config:export` / `config:import`.
