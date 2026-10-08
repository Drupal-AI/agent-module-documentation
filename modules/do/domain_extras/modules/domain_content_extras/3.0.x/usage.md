Domain Content Extras adds "Affiliated Content" tabs to the core admin content overview so editors can jump straight to the per-domain affiliated-content listings, including one sub-tab for every domain.

---

Domain Content Extras is a small utility submodule of Domain Extras that only registers local tasks (menu tabs) via `domain_content_extras.links.task.yml`; it ships no routes, services, controllers, permissions, or config. It attaches a top-level tab titled "Affiliated Content" to the core admin content overview (`base_route: system.admin_content`, i.e. `/admin/content`), whose target is the Domain Content module's `view.affiliated_content.page_2` display. Beneath that tab it uses the deriver `Drupal\domain_content_extras\Plugin\Derivative\DynamicLocalTasks` (`domain_content_extras.domain_links`) to generate a dynamic set of child tabs: an "All Affiliates" tab plus one tab per `domain` entity (loaded through `entity_type.manager`), each pointing at `view.affiliated_content.page_1` with an `arg_0` argument of `all_affiliates` or the domain machine id so the affiliated-content view is filtered to that domain. All targeted routes belong to the Domain Content module's affiliated-content view, so the tabs simply surface listings that already exist. Requires `domain:domain_content` (which pulls in the base Domain suite).

---

- Add an "Affiliated Content" tab to the `/admin/content` admin overview.
- Give editors one-click access to the affiliated-content listing from the standard content page.
- Show a sub-tab per configured domain under the Affiliated Content tab.
- Filter the affiliated-content view to a single domain by clicking that domain's tab.
- Show an "All Affiliates" sub-tab that lists content assigned to all affiliates.
- Generate the per-domain tabs automatically from the current `domain` entities (no manual menu edits).
- Keep new tabs in sync as domains are added or removed, since they derive from entity storage.
- Route the top-level tab to the Domain Content view display `view.affiliated_content.page_2`.
- Route each per-domain tab to `view.affiliated_content.page_1` with the domain id as `arg_0`.
- Surface existing Domain Content listings without adding new routes or pages.
- Install alongside Domain Content when you want its listings reachable from admin content tabs.
- Leave it out if you prefer the default Domain Content menu links only.
