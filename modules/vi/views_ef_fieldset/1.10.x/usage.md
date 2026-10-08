Views Exposed Form Fieldset is a Views display-extender plugin that lets you group a view's exposed filters, sorts and action buttons into nested containers — HTML fieldsets (`details`), plain containers, or vertical tabs — arranged with a drag-and-drop table in the exposed-form settings.

---

The module registers a Views display extender plugin (`views_ef_fieldset`, class `ViewsEFFieldset` extending `DefaultDisplayExtender`) and, on install, adds it to `views.settings` `display_extenders` so it is active for every view. On a view's *Exposed form* settings it adds an "Enable fieldset around exposed forms?" checkbox plus a `tabledrag` table listing each exposed handler (filters, their operators, exposed sort_by/sort_order, and the Submit/Reset buttons). You build a tree: each row can be given a parent container, a weight, and containers can be typed as Container, Fieldset (`details`) or Vertical tabs, with a title, description and open/closed state. This structure is stored in the view config at `display.<id>.display_options.display_extenders.views_ef_fieldset.views_ef_fieldset` with `enabled` and `options.sort` (a flat list of items each carrying `id`, `pid` parent, `weight`, `depth`, `type`, and for containers `container_type`/`title`/`description`/`open`). At render time `hook_form_views_exposed_form_alter()` reads that config and, via the `ViewsEFFieldsetData` helper, rebuilds `$form['filters']['children']` from the stored tree into a Form-API render tree of nested containers, moving each exposed element (and its `_op`/`_wrapper` operator element) into place and attaching the module's small CSS library. The module has **no admin settings page** (`configure: null`); all configuration is per view, per display, through the Views UI.

---

- Group a long list of exposed filters into collapsible fieldsets on a view.
- Put advanced/less-used exposed filters inside a collapsed `details` element.
- Organize exposed filters into vertical tabs to save vertical space.
- Wrap the entire exposed form in a single titled fieldset.
- Nest containers (a fieldset inside a fieldset) for grouped filter sections.
- Move the exposed Submit and Reset buttons into a specific container.
- Place exposed Sort by / Sort order controls into their own group.
- Reorder exposed filters via drag-and-drop without touching filter criteria order.
- Give each filter group a heading and description shown to end users.
- Set which filter groups start open vs collapsed by default.
- Build a faceted-style sidebar search UI purely with core Views + fieldsets.
- Keep a search view's exposed form compact on mobile using vertical tabs.
- Separate "keyword" and "date range" filters into distinct fieldsets.
- Improve the UX of a data-table view with many exposed filters.
- Apply different groupings per display (page vs block) of the same view.
- Present operator selects alongside their filter inside the same container.
- Theme grouped exposed forms with the `views-ef-fieldset-container` CSS classes.
- Collapse rarely used filters to reduce visual clutter on a report page.
- Cluster taxonomy/term filters together under one labelled fieldset.
- Export the grouping with the view config so it deploys across environments.
- Rearrange exposed elements without writing a custom exposed-form template.
- Add contextual grouping to an admin content listing's exposed filters.
- Provide a cleaner exposed form for editors on a moderation dashboard view.
