<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# simplify_menu — agent start

Turns any Drupal menu into a plain, normalized nested array (`{text, url, active, active_trail, submenu}`
under a `menu_tree` key) so you can render your own menu markup. Access checks + sorting are applied
for you; disabled/inaccessible links are dropped. **No admin UI, no settings, no permissions, no routes,
no Drush** — it is a Twig + service helper only. Depends on Drupal core only.

Two entry points, same data:

- **Twig function** `simplify_menu('main')` for theme templates → [theming/simplify_menu.md](theming/simplify_menu.md)
- **Service** `simplify_menu.menu_items` → `getMenuTree($menuId)` for PHP / decoupled JSON, plus the
  `hook_simplify_menu_simplified_link_alter()` alter hook and the exact return shape → [api/simplify_menu.md](api/simplify_menu.md)

Note: 3.x is Twig/service only — there is **no built-in JSON route** (unlike old 1.x/2.x). For headless
output you call the service yourself and `json_encode` it (see api doc).
