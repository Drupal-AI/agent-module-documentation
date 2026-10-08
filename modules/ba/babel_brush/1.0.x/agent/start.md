<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel Brush (babel_brush) — agent index

A one-form maintenance utility for core **Locale** (interface translation). It searches
translatable **source strings** by keyword and **bulk-deletes** selected strings from both
`locales_source` and `locales_target`. Version **1.0.0-alpha1** (alpha, not security-covered).
Core `^10 || ^11`. Package **Custom**. License GPL-2.0-or-later.

- **The form, route, permission, service and delete mechanism** →
  [forms/search-and-delete.md](forms/search-and-delete.md)

## What it actually is

- One dependency: core **`locale`** (info.yml `dependencies: - drupal:locale`). No composer deps
  beyond core. No submodules, no plugins, no config objects, **no config schema**, no Drush, no hooks.
- One route **`babel_brush.search_form`** at `/admin/config/babel_brush/search`
  (`babel_brush.routing.yml`), a `_form` route rendering
  `Drupal\babel_brush\Form\BabelBrushSearchForm`, gated by permission
  **`administer babel brush search form`** (`babel_brush.permissions.yml`, `restrict access: TRUE`).
- Menu link `babel_brush.search_form` under `system.admin_config_regional` (Configuration →
  Regional and language), weight 100 (`babel_brush.links.menu.yml`).
- One service **`babel_brush.service`** = `Drupal\babel_brush\Service\BabelBrushService`
  (args `@database`, `@logger.factory`) — the search and delete queries.
- One JS library **`babel_brush/select_toggle`** (`js/select_toggle.js`) wiring the Select all /
  Deselect all buttons and showing the Delete button.

## Mechanism (from source)

- `BabelBrushSearchForm::buildForm()` renders a required `keyword` textfield + Search submit. On
  submit it calls `BabelBrushService::getAllSourcesStringsByKeyword($keyword)` — a
  `select('locales_source')` left-joined to `locales_target`, `condition('ls.source', '%'.escapeLike($keyword).'%', 'LIKE')`.
  Each row becomes a checkbox `lid_<lid>` (title = the source string) plus, when present, a
  `#markup` line showing its `context`.
- Ticking rows and pressing **Delete** runs the `::deleteSourcesStrings` submit handler, which
  collects every `lid_*` value that is checked and calls
  `BabelBrushService::deleteSourceStringByLids($lids)` → parameterized `IN`-array deletes on
  `locales_source` then `locales_target` (wrapped in try/catch, failures logged to the
  `babel_brush` channel). Deletion is immediate and permanent (no confirm step, no undo).
