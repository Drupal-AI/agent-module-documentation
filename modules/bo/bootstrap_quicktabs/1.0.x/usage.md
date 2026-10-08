Bootstrap Quicktabs adds two Bootstrap-styled tab renderers — "bootstrap tabs" (tabs/pills) and "bootstrap accordion" (collapsible panels) — to the Quicktabs module, selectable per Quicktabs instance.

---

Quicktabs lets site builders group blocks, nodes, views and other content into a single tabbed widget and pick a "renderer" that controls the markup. This module plugs two `@TabRenderer` plugins into Quicktabs: `bootstrap_tabs` and `bootstrap_accordion`. The tabs renderer exposes an options form (style = Tabs or Pills; position = top/left/right/bottom/justified/stacked; an optional fade effect) and builds Bootstrap `nav`/`nav-tabs`/`nav-pills` markup via the `bootstrap_tabs` theme hook and its Twig templates. The accordion renderer renders each tab as a Bootstrap `panel-group` collapsible panel through the `bootstrap_accordion` theme hook. Both support Quicktabs features like Ajax tab loading, "hide empty tabs", and a configurable default/active tab. The module has no config form of its own (`configure` is null), no permissions, and no config schema — all configuration happens inside the Quicktabs instance edit form. It ships a small CSS library (`bootstrap_quicktabs/bootstrap_tabs`) and expects a Bootstrap-based theme to provide the actual tab/collapse JS and styling (it was written against Bootstrap 3 markup).

---

- Render a Quicktabs instance as Bootstrap nav-tabs instead of the default jQuery UI tabs.
- Render a Quicktabs instance as Bootstrap pills.
- Present grouped content as a Bootstrap collapsible accordion.
- Position tabs on the top, left, right or bottom of the content.
- Show tabs justified across the full width.
- Stack tabs vertically.
- Add a fade transition effect when switching between tabs.
- Lazy-load tab content over Ajax so only the active tab is rendered on first load.
- Hide tabs whose content is empty via the Quicktabs "hide empty tabs" option.
- Set which tab is active/open by default.
- Build a tabbed FAQ where each answer is a separate block or node.
- Group several Views into one tabbed dashboard block.
- Turn long single-page content into space-saving accordion panels.
- Give a Bootstrap-themed site consistent tab styling that matches the rest of the theme.
- Combine blocks, nodes and views of mixed types under one Bootstrap tab set.
- Migrate an older Bootstrap-3 Quicktabs setup onto Drupal 10/11 while keeping the same markup.
- Override the tab/accordion markup by providing custom `bootstrap-tabs`/`bootstrap-accordion` Twig templates in your theme.
