<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Links is a drop-in replacement widget for core Link fields that adds configurable CSS class and link `target` attribute controls.
---
The module ships a single field widget, `BetterLinksFieldWidget` (plugin id `better_links_field_widget`), which extends core's `LinkWidget` and applies to `link` field types. On a field's form display you choose the widget and configure two independent behaviours: how the CSS **class** is set and how the **target** is set. Each supports three modes — a value forced on every link, a value the editor picks from a curated select list, or free manual entry. Class select-mode defaults to Bootstrap-style button classes (`btn btn-default`, `btn btn-primary`, `btn btn-link`) that the site builder can edit as `key|label` lines. Target options are the four standard values (`_self`, `_blank`, `_parent`, `_top`). The chosen class and target are written into the link item's `options.attributes` and rendered by core's link formatter. The module has no routes, permissions, services, or database tables — it is purely a widget plugin configured through the Manage form display UI.
---
- Replace core's link widget with "Better Link" on any link field's form display.
- Force a CSS class on every link in a field (e.g. `btn btn-primary`).
- Offer editors a curated dropdown of CSS classes to choose from.
- Allow free manual CSS class entry per link.
- Force a link `target` such as `_blank` on all links in a field.
- Let editors pick a target (`_self`/`_blank`/`_parent`/`_top`) from a select list.
- Style links as buttons without writing custom code or teaching editors HTML.
- Customize the selectable class list with `key|label` lines in widget settings.
- Apply consistent call-to-action button styling across content types.
- Combine forced classes with theme CSS for branded link buttons.
- Use manual mode for one-off, per-link styling.
- Configure class and target independently — one forced, the other editor-chosen.
- Open external links in a new tab via a forced `_blank` target.
- Keep menu-of-links or hero-CTA fields visually consistent site-wide.
- Reuse the same widget across many link fields and bundles.
- Set the default target dropdown value editors see in manual mode.
- Migrate an existing link field to styled buttons by switching its form-display widget.
- Constrain editors to an approved set of classes (select mode) to prevent ad-hoc styling.
- Export the widget configuration with the entity form display config.
- Provide per-field, per-form-display class/target policies without extra modules.
