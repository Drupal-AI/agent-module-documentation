<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How groups become menu links (mechanism + integration)

The module owns no custom services and no plugin type. Grouping is done with a menu-link
**deriver**, a plain helper class, and a handful of hooks in `localgov_menu_link_group.module`.

## The pieces

- **Deriver `Plugin\Deriver\MenuGroups`** (`ContainerDeriverInterface`, uses `entity_type.manager`)
  — attached to the base menu link definition in `localgov_menu_link_group.links.menu.yml`
  (`route_name: <nolink>`, `enabled: 1`, `expanded: 1`). It creates **one derived menu link per
  unique active group** and gives it: `title` = group label, `menu_name` = `parent_menu`,
  `parent` = `parent_menu_link`, `weight` = group weight (merged over the base definition, so the
  link stays `<nolink>` = not clickable).
- **`MenuLinkGrouper`** (plain class, instantiated directly — not a service) — holds a reference to
  the discovered `$menu_links` array and re-parents each child link onto the group's derived link.

## Group menu link id

`MenuLinkGrouper::prepareMenuLinkIndexForGroup()` builds the derivative key as:

```
<parent_menu_link>:<machine_label>
```

where `machine_label = str_replace('-', '_', Html::getClass($group->label()))`. The full plugin id
of the group link is therefore `localgov_menu_link_group:<parent_menu_link>:<machine_label>`.

**Uniqueness / merging:** groups are keyed by `parent_menu_link` + label, so two enabled group
entities that share the same label *and* parent link collapse into one menu link. Deriver loads
groups sorted by weight, so the smallest weight wins for the merged link. This is what lets several
modules contribute links to the *same* visible group.

## Build-time flow (hooks)

1. `hook_module_implements_alter()` moves this module's `menu_links_discovered_alter` implementation
   to **last**, so it runs after every other module has contributed its links.
2. `hook_menu_links_discovered_alter(&$menu_links)` loads all groups with `status = 1`
   (`loadByProperties(['status' => 1])`), wraps `$menu_links` in a `MenuLinkGrouper`, and
   `array_walk`s `groupChildMenuLinks` over them. For each listed child that **exists** in
   `$menu_links`, it rewrites that child's `parent` to `localgov_menu_link_group:<index>`. Unknown
   child ids are silently skipped.
3. Entity `insert` / `update` / `delete` hooks all call
   `\Drupal::service('plugin.manager.menu.link')->rebuild()`, so the derived links and re-parenting
   are regenerated whenever a group changes. (Rebuilding all menu links is not free on a large
   site — batch group edits rather than saving in a loop.)

## Render-time access filtering

The derived group link is `<nolink>` and has no access check of its own, so an empty group could
show to a user who cannot reach any child. `hook_preprocess_menu()` →
`_localgov_menu_link_group_filter_menu()` prevents that:

- It walks `$variables['items']` (recursing into `below`). `$variables['menu_name']` defaults to
  `'admin'` when unset.
- For every item whose key starts with `localgov_menu_link_group`, it loads that subtree with
  `\Drupal::menuTree()->load($menu_name, $params)` where `$params` sets root =
  `$item['original_link']->getPluginId()`, `excludeRoot()`, `setMaxDepth(1)`, `onlyEnabledLinks()`.
  (Children must be fetched this way because they are not present in the group item's `below`.)
- It runs `\Drupal::accessManager()->checkNamedRoute($route_name, $route_parameters)` on each child
  and **unsets the group** when none are accessible.

This filtering is **render-only**. The group still exists in the menu tree *data* (and in
config) for users who cannot use it — code that reads the menu tree directly must do its own
filtering.

## Extend or add groups from another module (config)

Because groups are config entities, another module can ship them. Put a file named
`localgov_menu_link_group.localgov_menu_link_group.<id>.yml` in the contributing module's
`config/install/` or `config/optional/` directory.

To **add links to an existing group** (rather than define a new visible group), give the new config
item the **same `group_label` and `parent_menu_link`** as the target group (so they merge per the
uniqueness rule) but a new unique `id`:

```yaml
langcode: en
status: true
dependencies:
  enforced:
    module:
      - localgov_services
      - localgov_menu_link_group
id: localgov_menu_link_group_foo
group_label: Services
weight: 9
parent_menu: admin
parent_menu_link: 'admin_toolbar_tools.extra_links:node.add'
child_menu_links:
  - 'admin_toolbar_tools.extra_links:node.add.foo'
  - 'admin_toolbar_tools.extra_links:node.add.bar'
```

## Listing UI helper

`LocalGovMenuLinkGroupListBuilder` (a `DraggableListBuilder`, uses `plugin.manager.menu.link`)
renders the collection with label, parent-menu-link label (resolved via
`menuLinkManager->getDefinition()`), and a disabled enabled-checkbox, plus drag weights.
