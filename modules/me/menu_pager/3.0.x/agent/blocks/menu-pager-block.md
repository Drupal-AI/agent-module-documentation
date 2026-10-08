<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Menu Pager (`menu_pager_block`)

Source: `src/Plugin/Block/MenuBlock.php`, deriver `src/Plugin/Derivative/MenuBlock.php`.

## Plugin definition
```
@Block(
  id = "menu_pager_block",
  admin_label = @Translation("Menu Pager"),
  category = @Translation("Menus"),
  deriver = "Drupal\menu_pager\Plugin\Derivative\MenuBlock",
)
```
The deriver (`getDerivativeDefinitions`) iterates every `menu` config entity and creates one
derivative per menu, labelled `Menu Pager - <menu label>`, adding the menu's config entity as a
config dependency. So in the block library there is a separate "Menu Pager - Main navigation",
"Menu Pager - Footer", etc., one per menu. Place the derivative for the menu you want to page.

Injected services (`create`): `menu.link_tree`, `menu.active_trail`, `plugin.manager.menu.link`,
`module_handler`.

## Render logic (`build`)
1. `$block_menu = $this->getDerivativeId()` — the target menu for this block instance.
2. `$menu_link = $this->menuActiveTrail->getActiveLink(NULL)` — the active menu link for the current
   route (deepest active link across menus).
3. Render only if: the active link exists **and** `$menu_link->getMenuName() == $block_menu` **and**
   `menuPagerGetNavigation()` returns a `previous` and/or `next`. Otherwise returns `[]` (nothing).
4. Builds `Link::fromTextAndUrl($title, $url)->toRenderable()` for each side and returns:
   ```
   '#theme' => 'menu_pager',
   '#previous' => <render array or ''>,
   '#next'     => <render array or ''>,
   '#attributes' => ['class' => ['menu-pager', 'clearfix']],
   '#attached' => ['library' => ['menu_pager/menu_pager']],
   ```

## Navigation algorithm (`menuPagerGetNavigation`)
Statically cached per menu name (`drupal_static`).
1. Build `MenuTreeParameters`. If **Restrict to parent** is on and the active link has a parent,
   `setRoot($parentPluginId)` + `setMaxDepth(1)` — restrict the tree to the active link's siblings.
   Otherwise the full menu tree is loaded.
2. `$this->menuTree->transform($tree, [checkAccess, generateIndexAndSort])` — apply access checks and
   the menu's defined ordering/weight.
3. `menuPagerFlattenTree()` recurses the tree depth-first into `$flat_links`, recording for each
   kept link: `mlid` (plugin id), `plid` (parent plugin id), `link_path`, `link_title`, `url`.
   A link is kept only if: `$item->access` is an allowed `AccessResultInterface`, the route/path is
   **not** in the ignore list, and `$item->link->isEnabled()`. (A non-null, non-`AccessResultInterface`
   access value throws `\DomainException`.)
4. Walk `$flat_links`; when the entry whose `mlid` equals `$menu_link->getPluginId()` is found, take
   the previous entry (`prev()`) and the next entry (`next()`) as the pager neighbours.
5. If **Restrict to parent** is on, keep `previous`/`next` only when their `plid` equals the active
   link's parent plugin id — so paging never crosses out of the sibling group.

## Ignored paths (`menuPagerIgnorePaths`)
`module_handler->invokeAll('menu_pager_ignore_paths', [$menu_name])` then
`alter('menu_pager_ignore_paths', $paths, $menu_name)`. The module's own implementation
(`menu_pager.module`) ignores `<nolink>` and `<separator>` (Special Menu Items placeholders that do
not link anywhere). Add project-specific exclusions with these two hooks.

## Label composition
- Previous: `menu_pager_custom_label ? menu_pager_previous_label : '<< '`. If `hide_menu_title` is
  off, the menu link title is appended after the marker: `'<< ' . link_title`.
- Next: `menu_pager_custom_label ? menu_pager_next_label : ' >>'`. If `hide_menu_title` is off, the
  link title precedes the marker: `link_title . ' >>'`.
- `hide_menu_title` on → only the label/marker is shown, no link title.

## Per-block settings (`blockForm` / `blockSubmit`)
| Setting | Type | Effect |
|---|---|---|
| `menu_pager_restrict_to_parent` | checkbox | Only page between siblings sharing the active link's parent. |
| `menu_pager_hide_menu_title` | checkbox | Show only the previous/next label, not the neighbour's title. |
| `menu_pager_custom_label` | checkbox | Use the two label fields below instead of `<<` / `>>`. |
| `menu_pager_previous_label` | textfield (64) | Custom previous text (visible when custom label is on). |
| `menu_pager_next_label` | textfield (64) | Custom next text (visible when custom label is on). |

Config schema: `block.settings.menu_pager_block:*` in `config/schema/menu_pager.schema.yml`
(maps `menu_pager_previous_label` / `menu_pager_next_label` as `label`).

## Cacheability
`getCacheContexts()` → parent contexts + `url.path`. `getCacheMaxAge()` → `0` (uncacheable; core
`@todo` at https://www.drupal.org/node/2483181 to make it cacheable). The block is recomputed every
request, so it cannot serve a stale pager after a menu reorder.
