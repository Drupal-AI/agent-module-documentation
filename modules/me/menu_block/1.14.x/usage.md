Menu Block provides highly configurable blocks of menu links, extending Drupal core's menu block with control over starting level, depth, fixed parents, dynamic titles, and theme hook suggestions.

---

Drupal core can place a whole menu as a block, but offers little control over what part of the tree is shown. Menu Block adds a `menu_block` block plugin (derived per menu, extending core's `SystemMenuBlock`) that exposes many more options in the block configuration form. You can set the **initial visibility level** and **maximum number of levels**, optionally make the initial level **follow the active menu item**, and pin the tree to a **fixed parent item** so the block only shows that item's children. It can **expand all items**, **render (or hide) the parent item**, **hide on pages not in the menu**, and **show or hide an empty block**. The block title can be replaced with a dynamic value — the menu title, active item, active trail parent/root, or fixed parent — and optionally linked. A **theme hook suggestion** field lets each block target its own `menu__*` and `block__menu_block__*` templates for custom HTML and CSS. Configuration is stored via a config schema so blocks are exportable and deployable. It only depends on core's Menu UI module.

---

- Show only the second and third levels of a main menu as a sidebar submenu.
- Build a contextual sidebar that follows the active menu item down the tree.
- Display the children of a fixed parent menu item as a section navigation block.
- Create an "in this section" block that changes as the user browses.
- Limit a menu block to a maximum of two levels of depth.
- Always expand every menu link regardless of the active trail.
- Render the parent menu link at the top of a children-only block.
- Hide a menu block entirely on pages that are not in that menu.
- Show a menu block only when the current page's menu item is deep enough.
- Suppress an empty menu block so no empty region markup is output.
- Use the active menu item's title as the block title.
- Use the active trail's root item title as a dynamic block heading.
- Use a fixed parent item's title as the block label and link it.
- Replace the block title with the menu's own title.
- Provide a footer menu block trimmed to a single level.
- Add a custom `menu__sidebar` theme suggestion to restyle one block's markup.
- Give a mega-menu block its own template via a theme hook suggestion.
- Reproduce core menu blocks with more control after switching from system blocks.
- Place multiple blocks from the same menu, each showing a different branch.
- Build breadcrumb-like secondary navigation from the active trail.
- Drive Layout Builder sections with menu blocks scoped to a subtree.
- Configure per-region menu templates using region-aware theme suggestions.
- Show top-level menu items in the header and their children in a sidebar.
- Keep a persistent left-nav visible from level 1 across the whole site.
- Export configured menu blocks between environments as configuration.
