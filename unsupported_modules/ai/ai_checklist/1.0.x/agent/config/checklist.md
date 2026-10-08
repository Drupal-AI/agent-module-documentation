<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Checklist — the checklist definition

Everything lives in `ai_checklist.module` (no `src/`, no config, no schema). The module wires one
Checklist API checklist and lets that module render/store it.

## Install / enable

- `composer require drupal/checklistapi` then enable both: `drush en checklistapi ai_checklist`.
- Access the checklist at **`/admin/config/ai/ai-checklist`** (menu link *AI Checklist* under
  Configuration → Development, from `ai_checklist.links.menu.yml`, parent
  `system.admin_config_development`). An action link *Configure AI Checklist* is placed on the
  modules list via `ai_checklist.links.action.yml`.
- Info.yml `configure: checklistapi.checklists.ai_checklist` — the settings route is Checklist
  API's, not this module's.

## Checklist registration — `hook_checklistapi_checklist_info()`

`ai_checklist_checklistapi_checklist_info()` returns a single definition keyed `ai_checklist`:

- `#title` = *AI checklist*; `#description`, `#help` = translated strings.
- `#path` = `/admin/config/ai/ai-checklist`.
- `#callback` = `ai_checklist_checklistapi_checklist_items` — Checklist API calls this to build the
  items when rendering.

Checklist API derives the route name `checklistapi.checklists.ai_checklist`, provides the save UI,
stores per-item completion + timestamp + user, and enforces its own permissions. This module adds
no permission of its own.

## Items — `ai_checklist_checklistapi_checklist_items()`

Returns a nested array: top-level keys are **sections** (each with `#title`/`#description`), and
child keys are **tasks** (each with `#title`/`#description`, and optionally `#module` and/or
`#configure`). Sections and their notable tasks:

- **initial_setup** — `get_dxpr_api_key` (external register/dashboard links to dxpr.com),
  `install_key_module` (`#module: key`), `install_ai_module` (`#module: ai`),
  `install_ai_provider_dxpr` (`#module: ai_provider_dxpr`), `configure_dxpr_api_key`
  (`#configure: ai_provider_dxpr.settings_form`).
- **ai_image_features** — `install_ai_image_alt_text` (`#module: ai_image_alt_text`),
  `configure_ai_image_alt_text` (`#configure: ai_image_alt_text.settings`),
  `grant_alt_text_permissions` (`#configure: user.admin_permissions`).
- **ai_content_features** — `install_ai_agents` (`#module: ai_agents`), `configure_ai_agents`
  (`#configure: ai_agents.settings`), `install_ai_content_strategy` (`#module:
  ai_content_strategy`), `install_ckeditor_ai_agent` (`#module: ckeditor_ai_agent`),
  `configure_ckeditor_ai_agent` (`#configure: ckeditor_ai_agent.settings`).
- **content_analysis** — `#module` tasks for `analyze`, `analyze_ai_brand_voice`,
  `analyze_ai_sentiment`, `analyze_basic_content_info`, `analyze_page_views`; `#configure:
  analyze.settings`.
- **supporting_tools** — `#module` tasks for `markdownify`, `markdownify_path`; `#configure:
  markdownify.settings`.
- **privacy_permissions** — `#configure: klaro.settings`, `#configure: user.admin_permissions`,
  and a plain `test_ai_features` task (no module/route).

## Per-item post-processing — `_ai_checklist_preprocess_checklist_items()`

Injected services: `module_handler`, `access_manager`, `current_user`, `router.route_provider`.
For each task it mutates the array in place:

1. If `#module` is set: `#default_value = $module_handler->moduleExists($module)` (installed
   modules are pre-ticked); appends `Composer: composer require drupal/<module>` to
   `#description`; adds `project_page` → `Url::fromUri("https://www.drupal.org/project/<module>")`
   (Download). If `access_manager->checkNamedRoute('system.modules_list', [], $current_user)`,
   adds `modules_page` → `Url::fromRoute('system.modules_list', [], ['fragment' =>
   "module-<name-with-dashes>"])` (Install). Then `unset($item['#module'])`.
2. If `#configure` is set: resolves the route via `route_provider->getRouteByName()` (catching
   `RouteNotFoundException`); if it exists **and**
   `access_manager->checkNamedRoute($route, [], $current_user)`, adds `configure` →
   `Url::fromRoute($route)` (Configure). Then `unset($item['#configure'])`.

So the visible links are user- and site-aware: only reachable routes produce links, and only
enabled modules are pre-checked. All descriptions/links are built from static, translated strings
and fixed machine names — there is no request-supplied input in this module.
