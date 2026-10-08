<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Contextual menu

Plugin id `contextual_menu_block` — class
`Drupal\contextual_menu_block\Plugin\Block\ContextualMenuBlock`, extends core
`Drupal\Core\Block\BlockBase` and implements `ContainerFactoryPluginInterface`. Admin label
"Contextual menu", block category **Navigation**. Declares a `settings_tray` off-canvas form
(`\Drupal\system\Form\SystemMenuOffCanvasForm`). It renders one level of a menu around the current
page's active menu item — not the whole menu, and with no depth/level/expand options.

## Services (constructor-injected via `create()`)

- `entity_type.manager` → `menu` storage (`$menuStorage`) — loads menu entities for the form select
  and for the cacheable dependency.
- `menu.link_tree` (`$menuTree`) — loads, transforms, and builds the tree.
- `menu.active_trail` (`$menuActiveTrail`) — resolves the active link for the configured menu.

## Settings

Set on the block placement form (`blockForm()`), saved by `blockSubmit()` into the block's
`settings`. There are only two, and no `defaultConfiguration()` override (values read with `??`).

| Setting | Type | Default | Effect |
| --- | --- | --- | --- |
| `menu_id` | select | none | Which menu to read. Options are every menu entity from `menuStorage->loadMultiple()` (id ⇒ label). |
| `render_on_top_level_items` | checkbox ("Enable on top-level pages") | `FALSE` | When unchecked, `build()` returns empty on any page whose active item has no parent (i.e. sits at the top level). When checked, the block also renders on those top-level pages. |

Config schema `block.settings.contextual_menu_block` types both keys as `menu_id` (string) and
`render_on_top_level_items` (boolean).

## Runtime behavior (`build()`)

1. Creates `CacheableMetadata`, adds the **`route`** cache context, and adds a cacheable dependency
   on `Menu::load($menu_id)`; applies it to the (possibly empty) build array.
2. Gets `$active_link = menuActiveTrail->getActiveLink($menu_id)`. **Early-returns empty** when
   there is no active link, or when `render_on_top_level_items` is off **and** the active link has
   no parent.
3. Loads the current-route tree: `getCurrentRouteMenuTreeParameters($menu_id)` →
   `onlyEnabledLinks()` → `menuTree->load()`.
4. Transforms through three manipulators, in order:
   - custom **`filterTree`** (static callback, arg = active link plugin id) — collapses the tree to
     one level of context (rule below);
   - core **`menu.default_tree_manipulators:checkAccess`** — drops links the current user cannot
     access (this is where per-user access is enforced and per-user cache contexts are attached);
   - core **`menu.default_tree_manipulators:generateIndexAndSort`**.
5. Empty transformed tree → return empty build.
6. `menuTree->build($tree)` renders it; then two `array_walk` passes over `$build['#items']`:
   `removeNoLinkItem` prunes children whose route is `<nolink>`, and `unlinkActiveItem` replaces the
   active item's URL with `Url::fromRoute('<nolink>', …)` carrying `set_active_class` and an
   `is-active` class (so the current page shows as active, unlinked text).
7. Re-applies the cacheability and returns the build.

## The `filterTree` rule (the whole point of the module)

Given the loaded tree and the active item's plugin id:

1. **Active item has no parent** (top level) → return `[]`. (Combined with the early return in step
   2 above, top-level pages render only when `render_on_top_level_items` is on — and even then only
   when the active item has children, per rule 3.)
2. **Active item has children** → root the returned tree at the **active item**, listing its
   immediate children; grandchildren are stripped (`removeSubtrees`).
3. **Active item has no children** → root the returned tree at the active item's **parent**, listing
   that parent's children — the active item and its **siblings**; their children are stripped.

It never renders parent-of-parent or child-of-child links. If no tree element is in the active trail
(the current page is not represented in this menu), it returns `[]` and the block renders nothing.

## Access and caching (correctness)

- **Access:** the `checkAccess` manipulator runs on every build, so only links the current user may
  view are rendered. No admin/inaccessible paths leak.
- **Caching:** `route` cache context + menu-entity dependency are declared explicitly, and
  `menuTree->build()` bubbles the per-user contexts (`user.permissions`, etc.) added by
  `checkAccess`. The block is therefore cached per exact route and per access profile — no page's
  section navigation is served on another page.

## Place / configure it (drush or PHP)

No global settings form or `configure` route; each placement is a `block` config entity. Example:

```php
use Drupal\block\Entity\Block;

Block::create([
  'id' => 'contextualmenu',
  'theme' => 'olivero',
  'region' => 'sidebar_first',
  'plugin' => 'contextual_menu_block',
  'settings' => [
    'id' => 'contextual_menu_block',
    'label' => 'In this section',
    'label_display' => '0',
    'provider' => 'contextual_menu_block',
    'menu_id' => 'main',
    'render_on_top_level_items' => FALSE,
  ],
  'visibility' => [],
  'weight' => 0,
])->save();
```

## Notes / gotchas

- The block renders **nothing** on any page whose active item is not in the configured menu (views,
  taxonomy term pages, nodes with no menu link). This is expected; supply those pages' navigation
  another way.
- With `render_on_top_level_items` off, section landing pages that are themselves top-level menu
  items show no block — intended, to avoid an empty or redundant list.
- Pair with **Menu Breadcrumb** for the "up one level" link this block omits when the active item
  has children.
