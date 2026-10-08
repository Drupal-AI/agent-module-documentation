<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TabPanelWidget (tabpanelwidget) — agent index

Makes the third-party **TabPanelWidget** JS/CSS library available to Drupal for **responsive,
accessible tabs that collapse to accordions**. Package `Custom`. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 3.0.0. No Drupal module dependencies (but needs the compiled front-end
**library** installed under `/libraries/tabpanelwidget`, e.g. via asset-packagist). Ships two
submodules: `tabpanelwidget_quicktabs`, `tabpanelwidget_views`.

- **The `Tpw` builder API, `TpwItem`, theme hooks, and how another module renders a tabset** →
  [api/tpw.md](api/tpw.md)
- **The site-wide settings form, config object, schema keys, and defaults** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No routes render content.** The base module renders nothing on its own; it is a builder library.
  Callers (the two submodules, or your code) construct a `Tpw`, add items, and return `build()`.
- **`src/Tpw.php`** — service id `tabpanelwidget.tpw` (class `Drupal\tabpanelwidget\Tpw`, defined in
  `tabpanelwidget.services.yml` with `@config.factory`), though in practice the submodules
  instantiate it with `new Tpw()`. Setters: `setElements()`, `setBehavior()`, `setTabStyle()`,
  `setTabOptions()`, `setAccordionOptions()`, `addItem($title, array $content, bool $default)`,
  `reset()`. `build()` returns a `#theme => 'tpw'` render array with CSS classes derived from config
  and the `tabpanelwidget/tabpanelwidget.default` (+ optional `.polyfill`) libraries attached.
- **`src/TpwItem.php`** — one title/content pair. `setTitle()` decodes HTML entities and strips
  HTML comments; `build()` renders `#theme => 'tpw_item'` with the title as `#markup` and content
  as a passed-through render array.
- **`src/Form/SettingsForm.php`** — `ConfigFormBase` at route `tabpanelwidget.settings_form`
  (`/admin/config/content/tabpanelwidget`), permission **`administer tabpanelwidget configuration`**
  (`restrict access: true`), menu link under *Configuration → Content authoring*. Writes config
  object **`tabpanelwidget.settings`**.
- **Theme** (`tabpanelwidget.module`, `hook_theme`): `tpw` (variables `attributes`, `items`) and
  `tpw_item` (variables `element`, `attributes`, `title`, `content`). Templates in `templates/`.
- **Libraries** (`tabpanelwidget.libraries.yml`): `tabpanelwidget.polyfill`,
  `tabpanelwidget.global` (loads `/libraries/tabpanelwidget/dist/tabpanelwidget.min.js` +
  `js/tabpanelwidget_autoinstall.js`), `tabpanelwidget.default` (the min.css + depends on global).
- **No** Drush commands. **One** permission. Config schema in `config/schema/`.

## Submodules (own doc trees)

- **tabpanelwidget_quicktabs** → `../modules/tabpanelwidget_quicktabs/3.0.x/agent/start.md` — a
  Quick Tabs `TabRenderer` plugin (id `tabpanelwidget`). Requires `quicktabs`.
- **tabpanelwidget_views** → `../modules/tabpanelwidget_views/3.0.x/agent/start.md` — a Views style
  plugin (id `tabpanelwidget_views`) that groups rows into tabs/accordion panels. Requires `views`.
