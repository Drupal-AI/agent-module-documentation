Checklist API lets modules define fillable, persistent checklists — grouped lists of items an admin can check off, with each completion recording who did it and when. It handles the routes, permissions, progress storage, and report page for you.

---

A module defines one or more checklists by implementing `hook_checklistapi_checklist_info()`, returning an array of definitions keyed by an arbitrary machine ID. Each definition supplies a `#title`, a `#path`, and a `#callback` (`callback_checklistapi_checklist_items()`) that returns the actual groups and items; groups render as vertical tabs, and each item can carry a `#description`, a `#default_value` (to auto-check programmatically verifiable items), a `#weight`, and any number of handbook `#url` links. From each definition Checklist API auto-generates a route (`checklistapi.checklists.{id}` at the declared path, plus a `/clear` route) and a pair of per-checklist permissions (`view {id} checklistapi checklist` and `edit {id} checklistapi checklist`), alongside the universal `view any` / `edit any` permissions. When a user saves the form, progress is written as a structured array recording `#changed`, `#changed_by`, `#completed_items`, and per-item `#completed` timestamp and `#uid`; each item remembers the time and user of its first completion. Progress persists through one of two pluggable storage backends chosen per checklist via `#storage`: `config` (default, one `checklistapi.progress.{id}` config object, exportable) or `state`. A **Checklists** report at `/admin/reports/checklistapi` lists every checklist with percent complete, last-updated date, and last-updated user, and Drush commands (`checklistapi:list`, `checklistapi:info`) surface the same data on the CLI. Definitions can be modified by other modules through `hook_checklistapi_checklist_info_alter()`. The bundled `checklistapiexample` submodule ships a working reference implementation.

---

- Build a post-launch site-setup checklist that editors tick off as they configure the site.
- Track a compliance or accessibility audit as a persistent, shared checklist.
- Record who completed each step and when, for an audit trail.
- Provide a security-hardening checklist for a distribution or install profile.
- Auto-check items that are programmatically verifiable (e.g. a module is enabled) via `#default_value`.
- Group related tasks into vertical tabs within a single checklist.
- Attach handbook / documentation links to individual checklist items.
- Define multiple independent checklists from one module.
- Store checklist progress as exportable config so it deploys between environments.
- Store progress in state instead, to keep per-environment progress out of config.
- Expose a checklist at a custom admin path with its own menu item.
- Restrict who can view vs. edit a specific checklist via per-checklist permissions.
- Grant a role blanket access to all checklists with the `view any` / `edit any` permissions.
- Show a progress bar and percent-complete for onboarding flows.
- Review all checklists and their completion status on the `/admin/reports/checklistapi` report.
- List checklists and progress from the CLI with `drush checklistapi:list`.
- Inspect a single checklist's items and completion detail with `drush checklistapi:info`.
- Let another module add, move, or remove items in a checklist via the alter hook.
- Clear a checklist's saved progress to reset it for a re-audit.
- Pass arguments to the item callback via `#callback_arguments` to build dynamic lists.
- Place a checklist's menu item into a specific menu with `#menu_name`.
- Order checklists relative to each other with `#weight`.
- Drive a QA sign-off flow where testers check off verified features.
- Provide a content-migration cutover checklist with links to each step's admin page.
- Ship an example implementation to teach editors how the checklist works (`checklistapiexample`).
