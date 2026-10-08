<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Quick Tabs "TabPanelWidget" renderer plugin

`Drupal\tabpanelwidget_quicktabs\Plugin\TabRenderer\TabPanelWidget` — a `@TabRenderer` plugin
(id **`tabpanelwidget`**, name "TabPanelWidget") extending `quicktabs\TabRendererBase` and
implementing `ContainerFactoryPluginInterface`.

## Install & use

```bash
composer require drupal/tabpanelwidget   # provides this submodule
drush en tabpanelwidget_quicktabs -y     # pulls in tabpanelwidget + quicktabs
```

Then edit (or add) a **Quick Tabs** instance (*Structure → Quick Tabs*), set **Renderer** to
**TabPanelWidget**, and configure the options below. Save; place the Quick Tabs block.

Note `create()` and `__construct()` do **not** use dependency injection for the builder — the
commented lines show an intended `$container->get('tabpanelwidget.tpw')`, but the code runs
`$this->tpw = new Tpw();`.

## Options form (`optionsForm(QuickTabsInstance $instance)`)

Reads existing values from `$instance->getOptions()['tabpanelwidget']` and falls back to the
site-wide `tabpanelwidget.settings` (loaded via `config.factory->getEditable(...)`). Structure
(nested under a `tabpanelwidget_settings` container):

- **Main settings** — `elements` (`h2`–`h5`), `behavior` (`responsive` / `tabpanel` / `accordion`).
- **Tab settings** (shown via `#states` when behavior is `responsive` or `tabpanel`) — `tab_style`
  (`standard` / `fancy` / `pills` / `bar`), `tab_options` checkboxes (`centered`, `rounded`).
- **Accordion settings** (shown when behavior is `responsive` or `accordion`) — `accordion_options`
  checkboxes (`disconnected`, `icons_at_the_end`, `chevrons_east_south`, `plus_minus`, `animate`).

These are the same options as the base module's settings form; here they are stored per Quick Tabs
instance rather than site-wide.

## Render (`render(QuickTabsInstance $instance)`)

1. `$options = $instance->getOptions()['tabpanelwidget']`; push into the `Tpw`:
   `setElements`, `setBehavior`, `setTabStyle`, `setTabOptions`, `setAccordionOptions`
   (reading the nested `..._settings` keys).
2. Get `plugin.manager.tab_type`. For each `$instance->getConfigurationData()` tab:
   - `createInstance($tab['type'])->render($tab)` to render the tab body.
   - If `$instance->getHideEmptyTabs()` and the render is empty → `continue` (skip the tab).
   - If the tab-type options have `display_title` + `block_title`, prepend a container with class
     `tpw-qt-panel-title` holding `['#markup' => $block_title]`; append the rendered panel.
   - `$default = ($instance->getDefaultTab() === $index)`.
   - `$this->tpw->addItem($tab['title'], $content, $default)`.
3. `$build = $this->tpw->build();` then attach
   `tabpanelwidget_quicktabs/tabpanelwidget_quicktabs.global` (block-title CSS) and return `$build`.

Tab bodies come from Quick Tabs' own tab-type plugins (block/view/node/etc.), so their access and
rendering are handled by Quick Tabs and those subsystems; this plugin only wraps them in
TabPanelWidget markup. The block title is emitted as `#markup` (core applies `Xss::filterAdmin` at
render). See the parent [Tpw builder doc](../../../../3.0.x/agent/api/tpw.md).
