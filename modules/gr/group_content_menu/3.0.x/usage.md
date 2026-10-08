Group Content Menu lets each Group (from the Group module) have its own menu(s), modelled as content entities rather than config, so menus scale with the number of groups without config bloat. You define reusable menu *types*, enable them on a group type, then editors manage a menu and its links per group and render it with a block.

---

The module adds a `group_content_menu` **content** entity (revisionable, translatable, with its own menu link content items) and a `group_content_menu_type` **config** entity that acts as its bundle — analogous to how core menus work, but per group and stored as content. Unlike the older Group Menu module (which creates menus as config), storing menus as content means no config-ignore juggling and no config replication as groups multiply. Setup is: create one or more menu *types* at `/admin/structure/group_content_menu_types` (route `entity.group_content_menu_type.collection`), then enable the **Group content menu** relation on a group type's content configuration; each group then gets menu instances managed under `/group/{group}/menus`. It integrates through several plugins: a Group **relation** plugin (`group_content_menu`, derived per menu type via `GroupMenuDeriver`) that wires menus into a group's content; a **Block** plugin (`group_content_menu`, derived per type) to render a group's menu, with settings for starting level, depth, expand-all and relative visibility; and a **Condition** plugin. It also decorates core's `menu.parent_form_selector` (so group menus appear as parents when placing links) and alters the node form to let editors put nodes in a group menu. It defines a global permission (`administer group content menu types`) plus group-level permissions (access overview, manage menus, manage menu items) and ships config schema, templates, and per-type auto-create options (auto-create a menu and optional home link when a group is created). No Drush commands.

---

- Give every group (team, department, microsite) its own independently managed navigation menu.
- Define a reusable "Main navigation" menu type shared across all groups of a type.
- Let group editors add, reorder, and edit menu links scoped to their own group.
- Render a group's menu in a region via the Group Content Menu block, filtered to the current group.
- Avoid config bloat: menus are content, so N groups don't create N menu config entities.
- Auto-create a menu (and optionally a "Home" link) whenever a new group is created.
- Configure block display: starting level, maximum depth, expand-all-items, relative visibility.
- Place a node into a group's menu directly from the node edit form.
- Provide multiple menu types per group (e.g. main + footer) by defining several types.
- Restrict who can manage group menus vs menu items using group permissions.
- Grant a global admin the ability to define menu types (`administer group content menu types`).
- Translate group menus and their links (the entity is translatable).
- Use group menus as selectable parents when creating menu links (parent form selector integration).
- Show or hide the group menu block based on context via the provided Condition plugin.
- Migrate from Group Menu (config-based) to a content-based per-group menu model.
- Keep menu structure per group without patching Drupal core or the Group module.
- Build per-microsite navigation on a single Drupal install using groups.
- Manage a group's menu overview at /group/{group}/menus.
- Enable the group_content_menu relation on selected group types only.
- Revision group menus (the content entity is revisionable).
- Offer department-specific sidebars driven by each department group's own menu.
- Let a distribution ship a group menu type and block placement out of the box.
