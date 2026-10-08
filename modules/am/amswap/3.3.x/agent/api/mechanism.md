<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the swap works (mechanism)

amswap is `amswap.module` (three hooks) + one render-element class. No service, no plugin.

## Hooks (`amswap.module`)

1. `hook_toolbar_alter(&$items)` — on the `administration` toolbar item it:
   - adds cache tag `config:amswap.amswapconfig` (so saving config rebuilds the tray), and
   - overrides the tray's pre-render:
     `$items['administration']['tray']['toolbar_administration']['#pre_render'] = [[Amswap::class, 'preRender']]`.
2. `hook_module_implements_alter()` — moves amswap's `toolbar_alter` to run **last**, so it
   overrides other toolbar-altering modules (e.g. `gin_toolbar`).
3. `hook_help()` — help text only.

## The pre-render: `Drupal\amswap\Render\Element\Amswap::preRender($element)`

(A `TrustedCallbackInterface`; `trustedCallbacks()` returns `['preRender']`.)

Logic:

1. Builds `MenuTreeParameters` (enabled links only, top-level, from depth 1). If `admin_toolbar`
   is enabled it applies that module's `menu_depth` as the max depth.
2. Reads `amswap.amswapconfig:role_menu_pairs`. Chooses the active trail service —
   `gin_toolbar.active_trail` when `gin_toolbar` is enabled, otherwise `menu.active_trail`.
3. For each pair whose `role` is in `\Drupal::currentUser()->getRoles()`:
   - if the user also has any of the pair's `ignored_roles`, the pair is **skipped**;
   - otherwise it loads the paired menu's tree via the `toolbar.menu_tree` service, adds the
     `route.menu_active_trails:<menu>` cache context, and marks a menu as specified.
4. If **no** pair matched (`$menu_specified === FALSE`), it loads the default `admin` menu
   (root `system.admin`, active trail `admin`) — i.e. normal behaviour.
5. Transforms each tree with the standard manipulators
   (`checkAccess`, `generateIndexAndSort`) plus the right toolbar link builder:
   `toolbar_tools_menu_navigation_links` (Admin Toolbar) or `toolbar_menu_navigation_links`
   (core Toolbar), and `gin_toolbar_tools_menu_navigation_links` when Gin Toolbar is on.
6. Merges the built tree(s) into `$element['administration_menu']` and returns `$element`.

## What an agent should know

- The **only** persistent state is `amswap.amswapconfig:role_menu_pairs`. Everything else is
  runtime rendering.
- Behaviour is role-driven at render time — no per-user storage; a user sees the merge of all
  their matching pairs.
- Integrations are auto-detected by `moduleExists('admin_toolbar' | 'gin_toolbar')`; you do not
  configure them.
- Empty/absent `role_menu_pairs` ⇒ default admin menu for everyone (module effectively a no-op).
