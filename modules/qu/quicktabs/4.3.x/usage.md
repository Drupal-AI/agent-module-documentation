Quick Tabs lets site builders assemble a block of tabbed (or accordion) content, where each tab pulls in a node, a block, a View, or another Quick Tabs instance. Each configuration is stored as a `quicktabs_instance` config entity and exposed as a placeable block.

---

Quick Tabs provides an admin UI at Structure » Quick Tabs for creating named tab sets without code. Each tab set is a `quicktabs_instance` config entity holding a list of tabs; every tab declares a *tab type* (`node_content`, `block_content`, `view_content`, or `qtabs_content`) that determines what content it loads. A *tab renderer* controls presentation: the base module ships the classic `quick_tabs` renderer (with optional AJAX loading, direct-linking, and CSS styles such as pamela, on-the-gray, tabsbar, and material-tabs), while the `quicktabs_accordion` and `quicktabs_jqueryui` submodules add `accordion_tabs` and `ui_tabs` renderers. Saving an instance makes a derived block available on the Block Layout page, which you place into a region like any other block. Instance-level options include hiding empty tabs, choosing a default tab, and remembering the last-clicked tab across page loads (via a JS cookie). AJAX-loaded tabs are served through a dedicated controller route (`/quicktabs/{js}/{instance}/{tab}`); node tabs honor node access, but the README warns any node fetched this way returns its configured display, so field visibility must be controlled on the display settings. Developers extend the module with two plugin types — `TabType` (new content sources) and `TabRenderer` (new presentation styles) — and can adjust an instance at render time via `hook_quicktabs_instance_alter()`. A Views style plugin (`quicktabs`) additionally lets a View render its own rows as tabs.

---

- Build a tabbed block that shows several nodes, one per tab, without writing code.
- Combine a View, a block, and a node into a single tabbed widget on a landing page.
- Present long-form content as a jQuery UI accordion instead of horizontal tabs.
- Create tab sets that lazily load each tab's content over AJAX to speed initial page load.
- Place a Quick Tabs block in any theme region via the standard Block Layout UI.
- Nest one Quick Tabs instance inside another tab using the `qtabs_content` tab type.
- Render a View's result rows directly as tabs using the built-in `quicktabs` Views style.
- Offer FAQ-style collapsible sections with the accordion renderer's collapsible option.
- Style tabs with a shipped theme (pamela, on-the-gray, tabsbar, or material-tabs).
- Let visitors deep-link to a specific open tab using the direct-linking option.
- Remember and re-open the tab a visitor last clicked, using the JS-cookie feature.
- Hide tabs whose content renders empty so the tab bar only shows populated tabs.
- Choose which tab opens by default when the block first loads.
- Duplicate an existing tab set as a starting point via the Duplicate form.
- Show block content (e.g. a menu, a custom block, or a Views block) inside a tab.
- Display a node in a chosen view mode (teaser, full, etc.) within a tab.
- Pass contextual arguments to a View rendered inside a tab.
- Add a brand-new content source (e.g. an entity or remote feed) by writing a `TabType` plugin.
- Add a new presentation style by writing a `TabRenderer` plugin extending `TabRendererBase`.
- Inject a dynamic View argument per user or page at render time with `hook_quicktabs_instance_alter()`.
- Reorder or conditionally hide tabs programmatically before rendering.
- Manage tab sets as exportable, version-controllable configuration (`quicktabs.quicktabs_instance.*`).
- Restrict who can create and edit tab sets with the `administer quicktabs` permission.
- Migrate legacy Drupal 7 Quicktabs blocks to the Drupal 10/11 config-entity model.
- Group related dashboard widgets into one compact tabbed panel.
