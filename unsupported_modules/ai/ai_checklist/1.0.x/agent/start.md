<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Checklist (ai_checklist) — agent index

A **Checklist API integration** that defines one checklist, *"AI checklist"*, for tracking setup
and configuration of the AI module stack (oriented to DXPR CMS). Package `AI`. Depends only on
`checklistapi`. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Project version 1.0.0.

- **The checklist definition, its sections/items, the auto-detection and link logic, and how to
  reach it** → [config/checklist.md](config/checklist.md)

## What it actually is

- Two functions in `ai_checklist.module`, no PHP classes:
  - `ai_checklist_checklistapi_checklist_info()` — declares checklist id **`ai_checklist`**
    (title *"AI checklist"*, path **`/admin/config/ai/ai-checklist`**, callback
    `ai_checklist_checklistapi_checklist_items`).
  - `ai_checklist_checklistapi_checklist_items()` — returns the static section/item tree, then
    runs it through the private helper `_ai_checklist_preprocess_checklist_items()`.
- **No** routes, permissions, services, entities, plugins, config, schema, Drush, or libraries of
  its own. The route `checklistapi.checklists.ai_checklist`, the UI, completion storage (with
  timestamps), and all access control belong to **Checklist API**. `configure` in info.yml points
  at that route.

## Item mechanics (from source)

- Each item may carry `#module` (a project machine name) and/or `#configure` (a settings route id).
- `_ai_checklist_preprocess_checklist_items()` per item:
  - `#module` → `#default_value = moduleHandler()->moduleExists($module)` (pre-checks installed
    modules); appends `composer require drupal/<module>`; adds a **Download** link to
    `https://www.drupal.org/project/<module>`; adds an **Install** link to `system.modules_list`
    (anchored `#module-<name>`) **only if** the current user may access that route.
  - `#configure` → adds a **Configure** link to the route **only if** the route exists
    (`router.route_provider`) **and** `accessManager()->checkNamedRoute()` passes for the user.
- Sections: **Initial Setup**, **AI Image Features**, **AI Content Features**, **Content
  Analysis**, **Supporting Tools**, **Privacy and Permissions**.

## Notes

- Purely a guide/tracker — it never installs modules or writes AI/module configuration.
- Referenced modules (e.g. `ai`, `key`, `ai_provider_dxpr`, `ai_agents`, `ai_image_alt_text`,
  `analyze*`, `markdownify*`, `ckeditor_ai_agent`, `klaro`) are targets of the checklist, not
  dependencies of this module.
