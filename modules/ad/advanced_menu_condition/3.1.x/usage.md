Adds condition plugins that show or hide a block based on whether selected menu items are active or in the active menu trail, with multi-select and child inheritance.

---

Advanced Menu Condition provides two core Condition plugins for controlling block (and other Condition-based) visibility from the active menu trail. "Advanced menu position" makes a block appear when any of the selected menu links is the active link or an ancestor of it, so choosing a parent item automatically covers all of its children (inheritance). "Advanced Menu position - Hide" is the inverse, hiding the block on those same trails. The selection UI is a multi-select populated from core's menu parent form selector, letting an editor target several menu items across menus in one condition. Evaluation is driven entirely by core's `menu.active_trail` service, so it needs no path patterns and no request input. The module also ships a Drush command (`amc-cleanup`) that strips its dependency and visibility/condition entries from all configuration, and runs it automatically on uninstall so no dangling references are left behind. It works anywhere Drupal Condition plugins are consumed, including the Block layout and Layout Builder.

---

- Show a contextual sidebar block on an entire menu branch by selecting its parent menu item.
- Hide a promotional block on a specific section of the site defined by a menu subtree.
- Display a secondary navigation block only within the "Products" menu branch and all its children.
- Keep a call-to-action visible across a documentation section mapped to one menu parent.
- Target several unrelated menu items in one condition using the multi-select.
- Combine show and hide conditions to fine-tune where a block appears within a menu structure.
- Drive Layout Builder section/block visibility from the active menu trail.
- Avoid brittle path-pattern (Request Path) conditions by using menu structure instead.
- Show a "You are here" helper block only when a page is inside a chosen menu branch.
- Hide a global banner on a landing-page menu branch while keeping it elsewhere.
- Follow a reorganized menu automatically, since visibility tracks menu links, not URLs.
- Present branch-specific related links on all descendants of a top-level menu item.
- Restrict a sidebar menu block to the menu section it belongs to.
- Apply inheritance so editors set visibility once at the parent instead of per child page.
- Use with any module that consumes core Condition plugins, not only blocks.
- Cleanly uninstall via the bundled Drush cleanup that removes all configuration references.
- Run `drush amc-cleanup` to purge stale condition/visibility entries after config changes.
- Show onboarding help blocks only inside an account/settings menu branch.
- Hide breadcrumb or utility blocks on a specific menu subtree.
- Build section-aware navigation without writing custom condition plugin code.
