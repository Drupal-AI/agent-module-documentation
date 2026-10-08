<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reordering content menu links under config_readonly — operation

How to install, enable, and operate `config_readonly_menu_ui`. It has no admin
settings form of its own; all behavior is driven by the `config_readonly`
setting in `settings.php`. Grounded in `config_readonly_menu_ui.module` and
`src/ContentMenuForm.php`.

## Install & enable
- Requires the contrib module `config_readonly` plus core `menu_ui` and
  `menu_link_content` (declared in `config_readonly_menu_ui.info.yml`).
- `composer require drupal/config_readonly_menu_ui` then
  `drush en config_readonly_menu_ui -y`.
- `README.txt` notes the module historically expected a `config_readonly`
  patch (drupal.org node 2826274, comment 12157133); check whether current
  `config_readonly` needs it in your setup.
- No config is installed (`config/install/` is absent) and no config schema is
  shipped — nothing to import and nothing to configure via the UI.

## What turns the behavior on
The behavior is gated entirely on `Settings::get('config_readonly')`, i.e. the
`$settings['config_readonly'] = TRUE;` line in `settings.php` (the same flag the
`config_readonly` module reads). When that flag is FALSE, `ContentMenuForm`
short-circuits in each method and behaves exactly like core `MenuForm`.

## What happens on the menu edit form (read-only ON)
Route/form: the core menu add/edit form at `admin/structure/menu/manage/<menu>`
(and the add form) — this module swaps its form class via
`hook_entity_type_alter()` to `Drupal\config_readonly_menu_ui\ContentMenuForm`.
The swap is done unconditionally so the cached form definition is already the
subclass whenever read-only is later toggled on.

- `ContentMenuForm::form()` — sets `#disabled = TRUE` on every top-level element
  except `links` and `actions`, and adds a warning message
  ("Some parts of this form are read-only and have therefore been disabled.").
  The menu label/description and other menu-config fields become non-editable.
- `ContentMenuForm::buildOverviewForm()` — walks the `links` table; for each
  link whose `#item->link` is **not** a `MenuLinkContent` (a config-defined
  link) it disables that row's `weight` and `enabled` widgets and sets
  `operations['#access'] = FALSE`. If any such read-only link exists it removes
  `$form['links']['#tabledrag']`, because `tabledrag.js` can change a weight
  even for a disabled row — so editors reorder via the visible weight
  `<select>` fields instead of drag-and-drop.
- `ContentMenuForm::submitForm()` — in read-only mode it does **not** call
  `parent::submitForm()` (which would save the menu config entity). It calls
  only `submitOverviewForm()`, persisting the content links' weight/enabled
  changes. Guard: it runs the overview submit only if
  `!$this->entity->isNew() || $this->entity->isLocked()`.

## The whitelist hook
`hook_config_readonly_whitelist_patterns()` returns `['system.menu.*']`, which
`config_readonly` adds to its allow-list so menu-config names are not blocked by
the read-only lock. This is what lets the menu-related save paths proceed while
the flag is on.

## Operating notes
- Content menu-link weights are **content**, not config: a reorder made on
  production stays on that environment and does not travel with a config export.
- Mixed menus (content + config links): the README warns you cannot place a
  content link between two config links of equal weight (Drupal's integer-weight
  model). Space config-link weights out, or keep a menu single-kind.
- Clearing caches is not required to toggle behavior — the form class is already
  swapped; only the `settings.php` flag decides the branch taken at runtime.
