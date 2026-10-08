<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Charts Text Filter lets editors insert Charts-module charts into rich-text content with a CKEditor 5 button, storing each chart as a `<chart data-chart-config>` element that a text filter renders on output.

---

Charts Text Filter is a thin bridge between the contrib **Charts** module and Drupal's CKEditor 5
editor. It adds an "Insert chart" toolbar button (CKEditor5 plugin `charts_text_filter_button`) that
opens a modal built from the Charts module's `charts_settings` form element; on submit the chart's
configuration is JSON-encoded and stored inside a custom `<chart data-chart-config="…">` element in
the field's markup. At display time the text filter `filter_charts_text_filter` finds those elements,
decodes the JSON, and renders each one through the Charts render element (`Chart::buildElement`),
merging the charting library's cacheability metadata and JS attachments into the filter result. There
is no persisted module configuration, no settings page, no permissions, no Drush and no config schema
of its own — everything is driven by the host text format and the Charts module's own settings. It
requires Charts, and core CKEditor 5, Editor and Filter.

---

- Enable an "Insert chart" button in a CKEditor 5 toolbar for a chosen text format.
- Let content editors build a chart visually (type, library, series, colors) without touching source.
- Embed a line, bar, pie, column, area, etc. chart inline in a node body or other formatted field.
- Render embedded charts on the front end via the `filter_charts_text_filter` text filter.
- Store chart definitions as portable `<chart data-chart-config>` markup inside the field value.
- Edit an existing embedded chart by double-clicking / selecting it and reopening the dialog.
- Preview a chart inside the configuration dialog before inserting it into the content.
- Reuse the Charts module's site-wide default settings as the starting point for every new chart.
- Pick up newly added Charts settings on existing charts (defaults are merged under saved config).
- Add charts to any entity that uses a CKEditor 5 text format (nodes, custom blocks, comments, etc.).
- Combine multiple charts in a single rich-text field, each rendered independently.
- Keep the charting library's JavaScript working even when the filtered text is served from cache.
- Drive which charting backend (Chart.js, Highcharts, etc.) is used through the Charts library setting.
- Leave malformed or incomplete chart markup untouched so it can be fixed in the editor, not broken.
- Migrate away from the old manual source-editing workflow to a form-driven insertion flow.
- Restrict chart authoring to specific text formats by only enabling the filter/button where wanted.
- Gate the chart configuration dialog to users allowed to use the format (editor entity access).
- Provide a content-editing feature with no new roles, entities or admin routes to manage.
- Let site builders expose data visualizations to editors as a self-service WYSIWYG feature.
- Serve as a reference implementation of a CKEditor 5 widget backed by an AJAX dialog form.
