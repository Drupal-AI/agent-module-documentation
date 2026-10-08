System Page Override (system_page_override) lets an administrator use ordinary nodes as the site's system pages: the front page, the 403 (access denied) page and the 404 (page not found) page. You pick which content types are allowed to serve each system page, then flag individual nodes, and the choice can differ per language.

---

The module never edits `system.site` on disk. Instead it registers a `config.factory.override` service (`SystemPageConfigOverride`) that, at runtime, injects the chosen node paths into the `page.front`, `page.403` and `page.404` keys of `system.site` for the current interface language. The actual paths are stored in Drupal **State** (not config), keyed as `system_page_override:<page>:<langcode>` where `<page>` is `front`, `403` or `404`; `SystemPageManager` reads and writes them and invalidates the `config:system.site`, `route_match` and `http_response` cache tags on every change. Because it drives the same `system.site.page.*` values that core's Site Information form exposes, Drupal serves the target through its normal front-page and exception (403/404) handling, including that path's own access checks. There are three ways paths get set. First, the settings form (`/admin/config/system/system-page-override/settings`, `SettingsForm`, saved to config `system_page_override.settings` under `enabled_node_bundles_front` / `_403` / `_404`) declares which node bundles may be used for each system page. Second, once a node's bundle is enabled, a "Systempage settings" details group is added to that node's edit form (`hook_form_node_form_alter` → `SystemPageOverrideNodeFormExtension`) with a per-language checkbox for each applicable system page; checking it stores `/node/<id>` in State, unchecking reverts it. Third, the overview form (`/admin/config/system/system-page-override`, `OverviewForm`) shows a free-text path field per system page per language for direct editing of the stored values. Three permissions gate these: `administer system page override settings` (the settings form), `administer node as system page` (the node-form checkboxes) and `administer system page overrides` (the overview form). Multilingual sites get an independent target per configured language; the label collapses to a plain page name when the site is monolingual.

---

- Make a specific node the site's front page instead of using a path in Site Information.
- Serve a curated, editor-friendly 404 "page not found" node instead of core's default text.
- Serve a branded 403 "access denied" node built as normal content.
- Let editors pick the homepage node from the node edit form rather than an admin settings screen.
- Restrict which content types are even eligible to become a system page (e.g. only a "Landing page" type may be the front page).
- Give each language its own front page node on a multilingual site.
- Give each language its own 404 and 403 pages.
- Swap the homepage to a seasonal campaign node by toggling one checkbox on that node.
- Point the 404 page at a node that lists popular links or a search box.
- Manage all system-page targets in one place via the overview form, per language.
- Directly type or clear a system-page path (e.g. `/node/12`) without opening the node.
- Delegate homepage selection to content editors while keeping the eligible-types config with admins.
- Revert a system page to Drupal's default simply by unchecking the node's box or clearing the overview field.
- Keep the same node as both a published URL (`/node/12`) and the front page at once.
- Build the 403 page as a node that explains how to request access or log in.
- Use a full node (fields, layout, blocks) for the homepage rather than a static route.
- Preview and edit the system pages like any other content, with revisions and workflow.
- Set different homepages per language for a multi-region site.
- Move the homepage between nodes without redeploying configuration.
- Audit which nodes are acting as system pages from the overview form's populated fields.
- Enable homepage/404/403 overrides only for chosen roles by granting the three permissions selectively.
- Keep system-page assignments out of exported config (they live in State) so they can differ per environment.
