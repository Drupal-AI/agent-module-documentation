# Configure — Bootstrap tab renderers

There is no admin settings page. You configure this module by editing a **Quicktabs
instance** (*Structure → Quick Tabs → add/edit*) and choosing one of its renderers.

## bootstrap tabs (`bootstrap_tabs`)

`src/Plugin/TabRenderer/BootstrapQuickTabs.php`. Provides an options form
(`optionsForm()`) stored under the instance's `options['bootstrap_tabs']`:

| Option | Values | Effect |
|---|---|---|
| `tabstyle` | `tabs` (default), `pills` | CSS class `nav-tabs` vs `nav-pills`. |
| `tabposition` | `basic` (top, default), `left`, `right`, `below`, `justified`, `stacked` | Adds `tabs-<pos>` wrapper class and/or `nav-justified` / `nav-stacked`. |
| `tabeffects` | `fade` on/off | Adds Bootstrap `fade`/`in` classes for a fade transition. |

`render()` builds a `#theme => 'bootstrap_tabs'` render array. It honours Quicktabs
instance settings: `getDefaultTab()` (9999 is normalised to index 0) sets the active tab;
Ajax mode (`options['bootstrap_tabs']['ajax']`) renders only the default tab and marks the
rest `use-ajax` with a "Loading content …" placeholder; `getHideEmptyTabs()` skips tabs
whose rendered content is empty. Attaches library `bootstrap_quicktabs/bootstrap_tabs`.

## bootstrap accordion (`bootstrap_accordion`)

`src/Plugin/TabRenderer/BootstrapAccordion.php`. No options form — renders each tab as a
Bootstrap `panel-group` collapsible panel (`#theme => 'bootstrap_accordion'`). The active
panel (from `getDefaultTab()`) gets the `in` class; `getHideEmptyTabs()` is honoured; a
panel's title comes from the tab title, and a per-tab block title is used when
`display_title` + `block_title` options are set on that tab.

## Theming (override the markup)

`hook_theme` (in `bootstrap_quicktabs.module`) registers:

- `bootstrap_tabs` (vars: `content`, `tabs`, `options`) → `templates/bootstrap-tabs.html.twig`
- `bootstrap_tabs_tabs` → `templates/bootstrap-tabs-tabs.html.twig`
- `bootstrap_accordion` (vars: `classes`, `id`, `panels`) → `templates/bootstrap-accordion.html.twig`

Copy any of these templates into your theme to change the emitted Bootstrap markup. Tab
titles are passed through `TranslatableMarkup`; the markup is Bootstrap-3 flavoured, so a
Bootstrap-3-compatible theme (with the collapse/tab JS) is expected.
