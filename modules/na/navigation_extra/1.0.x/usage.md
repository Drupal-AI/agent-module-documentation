<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Navigation Extra augments Drupal core's new left sidebar Navigation module with configurable extra menu items and blocks — content, media, taxonomy, users, files, blocks, forms, local tasks, tools and a version indicator — grouped into collections and toggled per feature from one settings page.

---

The module depends on core `navigation` and adds a plugin-driven layer on top of it. It defines its own
`NavigationExtraPlugin` plugin type (manager service `navigation_extra.manager`, namespace
`Plugin/Navigation/Extra`, annotation `@NavigationExtraPlugin`); each plugin (Common, Blocks, Content,
Files, Media, Taxonomies, Users, Forms, LocalTasks, Tools, Version) contributes its own settings tab
and alters the discovered navigation menu links (pre/normal/post alter phases) to inject links, group
them into hierarchical "collections", add "create new" links, hide core links, and decide when a menu
rebuild is needed. A single settings form at `/admin/config/user-interface/navigation/extra`
(permission `administer site configuration`) renders every plugin as a vertical-tab and writes to
`navigation_extra.settings` (a `plugins.<id>` map per plugin with `enabled`, `weight` and
plugin-specific keys). It also ships three blocks (`NavigationExtraLocalTasksBlock`,
`NavigationExtraVersionBlock`, and a `NavigationMenuBlockOverride`) and takes over the core
`plugin_filter_block__layout_builder` hook to control which blocks are considered "navigation-safe". A
`hook_navigation_extra_collections()` hook lets other modules declare hierarchical collections keyed by
plugin id. The Version plugin can surface an app/site version (from a file, env var, provider or module)
with per-environment colours and optional update checks.

---

- Add "Content" links (recent items, create-new links) to the core Navigation sidebar.
- Add Media, Taxonomy, Users, Files, Blocks and Forms sections to the sidebar navigation.
- Group navigation items into hierarchical collections (top/bottom grouping).
- Hide empty collections from the menu automatically.
- Override core's 3-level menu depth limit for deeper navigation trees.
- Generate overview links for parent items that have children so the parent stays reachable.
- Show recent content items (configurable limit and link target) in the navigation.
- Add "create new content" links, optionally grouped into a create menu with collections.
- Add role items and hide selected roles under the Users section.
- Link the Media section to the Media Library.
- Show files under the Media section, or hide the core files link.
- Add webform and contact-form links (and link to webform results) under Forms.
- Add a Version indicator block/link showing the current site or app version.
- Colour-code the version indicator per environment (dev/stage/prod) from an env var or header.
- Add local tasks (entity tabs) into the navigation via the Local Tasks plugin/block.
- Control which blocks are offered as "navigation-safe" in Layout Builder.
- Reorder navigation sections with per-plugin weights.
- Enable/disable each navigation feature independently from one settings page.
- Let a custom module declare navigation collections via `hook_navigation_extra_collections()`.
- Provide extra navigation blocks for placement (local tasks, version, menu override).
- Integrate Devel and Navigation-Extra "tools" links, optionally grouped under Tools/Development.
