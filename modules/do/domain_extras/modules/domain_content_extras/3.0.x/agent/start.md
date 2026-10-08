# Domain Content Extras (domain_content_extras) 3.0.x

Utility submodule of Domain Extras that adds "Affiliated Content" local tasks (tabs) to the core admin content overview, including one dynamic tab per domain.

## Facts

- **Depends on:** `domain:domain_content` (base Domain suite via that).
- **Routes:** none defined. All tabs point at Domain Content's affiliated-content view displays: `view.affiliated_content.page_2` (top tab) and `view.affiliated_content.page_1` (per-domain tabs, with an `arg_0` argument).
- **Local tasks:** `domain_content_extras.links.task.yml`
  - `domain_content_extras.affiliated_content` — title "Affiliated Content", `base_route: system.admin_content` (attaches to `/admin/content`), `route_name: view.affiliated_content.page_2`.
  - `domain_content_extras.domain_links` — `deriver: Drupal\domain_content_extras\Plugin\Derivative\DynamicLocalTasks`.
- **Deriver:** `src/Plugin/Derivative/DynamicLocalTasks.php` (`DynamicLocalTasks extends DeriverBase implements ContainerDeriverInterface`). Injects `entity_type.manager`, loads all `domain` entities, and returns child tasks under `parent_id: domain_content_extras.affiliated_content`:
  - `all_affiliates` — title "All Affiliates", `view.affiliated_content.page_1`, `arg_0` = `all_affiliates`.
  - one per domain — title = domain label, `view.affiliated_content.page_1`, `arg_0` = domain id.
- **Services / controllers / hooks:** none.
- **Permissions:** none defined; tab visibility follows the target view's route access (Domain Content's `access domain content` / view access plugin).
- **Config / schema:** none.
- **Plugins defined:** none. (The deriver implements core's local-task plugin system; it does not define a new plugin type.)

## How to use

Enable the module (`drush en domain_content_extras -y`) after Domain Content is set up. No configuration: go to `/admin/content` and use the "Affiliated Content" tab and its per-domain sub-tabs. Tabs are rebuilt from the current `domain` entities, so adding or removing a domain updates the tabs (clear caches / rebuild routes if they do not appear).
