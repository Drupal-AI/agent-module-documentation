<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — how Better Local Tasks restyles the tabs

No configuration exists. The whole module is `better_local_tasks.module` (three hooks), two Twig
overrides, one CSS file, and a set of SVG icons. Enable it and the effect is on.

## What it attaches, and when

`hook_page_attachments_alter()` attaches the CSS library, gated twice:
- returns early unless the current user has the **`access contextual links`** permission;
- attaches only when the route is **not** an admin route (`router.admin_context` → `isAdminRoute()`).

So the styling appears only for privileged users on front-end pages. Anonymous users and admin-theme
pages get core's default tabs.

- Library: `better_local_tasks/local-tasks` → `css/local_tasks.css` (theme CSS, no JS, no dependencies).

## Template overrides

`hook_theme_registry_alter()` repoints two theme hooks at this module's templates — again **only on
non-admin routes**:
- `block__local_tasks_block` → `templates/block/block--local-tasks-block.html.twig`
  (wraps the block content in `<nav class="blt-tabs">`, adds class `block-local-tasks-block`).
- `menu_local_tasks` → `templates/navigation/menu-local-tasks.html.twig`
  (renders `<ul class="blt-tabs primary">` and `<ul class="blt-tabs secondary">`).

## Per-task CSS classes (the icon hook)

`hook_preprocess_menu_local_task()` adds one class to each tab link based on its route-name suffix, so
CSS can attach an icon:

| Route suffix | Class added | Icon (`img/…`) |
|---|---|---|
| `*.canonical` | `view` | icon-view.svg |
| `*.edit_form` | `edit` | icon-edit.svg |
| `*.delete_form` | `delete` | icon-delete.svg |
| `*.version_history` | `revisions` | icon-revisions.svg |
| `*.devel_load` | `devel` | icon-devel.svg |
| `*.content_translation_overview` | `translate` | icon-translate.svg |
| `*.clone_form` | `clone` | icon-clone.svg |
| (fallback) | `shortcuts` | icon-shortcuts.svg |

(CSS also defines `managedisplay` and `newdraft` icon rules, but no hook branch assigns those classes.)

**Known code quirk:** the final branch is written `elseif ($route_name = 'shortcut.set_switch')` — an
assignment (`=`), not a comparison (`==`). It is always truthy, so **any tab that matched none of the
earlier suffixes falls through to the `shortcuts` class** (and gets the shortcuts icon), regardless of
its real route. Harmless (cosmetic) but explains why unexpected tabs show the shortcuts icon.

## The visual design (`css/local_tasks.css`)

The local tasks **block** is styled `position: fixed; top: 50%; left: -124px; width: 164px` — a vertical
panel pinned to the middle-left of the viewport, mostly off-screen. Each `li:hover` slides the row out
(`left: calc(100% - 40px)`). Tabs are dark chips (`#555`, active `#777`) with a right-aligned 24px icon.
Note this only takes effect where core renders the **Local Tasks block** (the block layout / most admin-
adjacent themes); a theme printing tabs outside that block wrapper won't get the fixed panel.

## Customising

There is no settings form — override via your theme:
- Add CSS targeting `.block-local-tasks-block .blt-tabs …` to change position/colours (e.g. undo the
  fixed left panel, or move it).
- Override `menu-local-tasks.html.twig` / `block--local-tasks-block.html.twig` in your theme to change
  the markup.
- Provide your own icons by overriding the `li a.<class>` background-image rules.
