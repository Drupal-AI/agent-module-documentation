Tab Tamer is an administration utility that reorders, renames, hides, and disables the local-task tabs (and subtabs) shown on a given route, via a per-route configuration entity.

---

The module defines a `tab_tamer` config entity, one per route, managed at *Structure › Tab tamer*
(`/admin/structure/tab-tamer`) and gated by a single `administer tab_tamer` permission. Each entity's
`label` is the machine route name whose tabs it controls (e.g. `entity.node.canonical`); when you add
one, the form (`TabTamerForm`) loads that route's local tasks live via the
`plugin.manager.menu.local_task` service and lists each tab so you can set a new **Link title**, a
**Weight** (drag-ordering), and a **Display** checkbox. At render time
`tabtamer_menu_local_tasks_alter()` looks up the enabled entity for the current route
(`TabTamer::getByRoute()` matches on `label`), and for each configured tab overrides `#weight` and the
link title, and sets `#access` to `AccessResultForbidden` when Display is unchecked — so unchecked
tabs are hidden. Nothing is *granted*: the module can only relabel, reorder, or forbid tabs a user
would otherwise see. An **Add tabtamer** / **Edit tabtamer** local task is injected on every page for
users holding `administer tab_tamer`, deep-linking to the add form pre-seeded with the current route.
Config is stored as `tabtamer.tab_tamer.*` (only `id`, `label`, `tabs` are exported — the `status`
enable flag is intentionally not in `config_export`). Degrades gracefully without JS and uses cache
tags for invalidation.

---

- Reorder the tabs (View / Edit / Delete / Revisions) on node pages.
- Rename a tab's link title (e.g. change "View" to "Read").
- Hide a specific tab from everyone on a given route.
- Reorder the tabs on the user profile page.
- Rename or hide the "Manage fields / display" tabs on entity admin pages.
- Tidy up a cluttered tab bar on a custom entity's canonical route.
- Drag-order subtabs to a preferred sequence.
- Disable a rarely used tab without removing the underlying route/permission.
- Apply a consistent tab order across an editorial workflow.
- Hide the "Devel" or other contrib tabs from a route for cleanliness.
- Create a Tab Tamer per route and toggle it on/off via its `status` flag.
- Give editors a simpler set of tabs on content they manage.
- Rename translation/moderation tabs to friendlier labels.
- Reorder taxonomy term page tabs.
- Manage tab configuration in code via exported `tabtamer.tab_tamer.*` config.
- Quickly jump to the tab config for the page you're on via the injected "Add/Edit tabtamer" tab.
- Standardize tab labels site-wide for a client's terminology.
- Hide edit/delete tabs on pages where they shouldn't be visually offered (access still enforced elsewhere).
