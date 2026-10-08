TabPanelWidget Quick Tabs adds a "TabPanelWidget" tab renderer to the Quick Tabs module, so a Quick Tabs instance renders as responsive, accessible TabPanelWidget tabs/accordions.

---

This submodule provides a single Quick Tabs `TabRenderer` plugin (id `tabpanelwidget`, class `Drupal\tabpanelwidget_quicktabs\Plugin\TabRenderer\TabPanelWidget`). Once enabled, editing a Quick Tabs instance lets you pick "TabPanelWidget" as the renderer and configure per-instance TabPanelWidget options (element level, behavior, tab style, tab options, accordion options) that default to the site-wide `tabpanelwidget.settings`. At render time the plugin builds a `Tpw`, iterates the instance's configured tabs (each rendered through its normal Quick Tabs tab-type plugin, honoring "hide empty tabs"), optionally prefixes each panel with its block title, and returns the TabPanelWidget render array plus a small CSS library (`tabpanelwidget_quicktabs.global`) for in-panel block-title styling. It depends on both `tabpanelwidget` and `quicktabs`.

---

- Render an existing Quick Tabs instance as responsive TabPanelWidget tabs that collapse to an accordion on narrow screens.
- Give Quick Tabs instances accessible keyboard/ARIA tab behavior from the TabPanelWidget library.
- Combine blocks, views, and nodes as Quick Tabs tab content, then display them with TabPanelWidget styling.
- Force a Quick Tabs instance to always show as horizontal tabs regardless of viewport.
- Force a Quick Tabs instance to always show as a stacked accordion.
- Choose a per-instance heading level (`h2`–`h5`) so the Quick Tabs headers nest correctly under page headings.
- Apply "standard", "fancy", "pills", or "bar" tab styling to a Quick Tabs instance.
- Center or round the tabs of a specific Quick Tabs instance.
- Use disconnected, animated, or plus/minus accordion styling for a Quick Tabs instance in accordion mode.
- Set the instance's default open tab via Quick Tabs' own default-tab setting.
- Hide empty Quick Tabs tabs (no content) from the rendered TabPanelWidget output.
- Show each tab's block title as a styled heading inside the panel body.
- Override the site-wide TabPanelWidget defaults on a single Quick Tabs instance without changing global settings.
- Migrate a legacy Quick Tabs (jQuery UI) display to a modern, accessible tab/accordion look.
- Place a Quick Tabs block built with TabPanelWidget in any region or via Layout Builder.
