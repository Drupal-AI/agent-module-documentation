<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Responsive Table Filter adds a text-format filter that wraps every `<table>` in rendered content with a scrollable wrapper element (a `<figure>` by default), so wide tables scroll horizontally on small screens instead of breaking the layout.

---

The module provides one filter plugin, `filter_responsive_table` (`FilterResponsiveTable`, a `TYPE_TRANSFORM_REVERSIBLE` filter). When the filter is enabled on a text format, its `process()` runs a regex over the field's HTML and wraps each `<table>…</table>` in a configurable wrapper element. Two per-format settings control the wrapper: `wrapper_element` (default `figure`) and `wrapper_classes` (default `responsive-figure-table`). The generated wrapper also gets `tabindex="0"` and `aria-label="Scrollable table"` so keyboard and screen-reader users can focus and scroll it. The module attaches a small CSS library (`responsive_table_filter/responsive-table`) on every page via `hook_page_attachments()`; that CSS gives `.responsive-figure-table` `max-width:100%` and `overflow-x:auto`, which is what actually makes the wrapped table scroll. There is no admin settings page of its own — you configure it per text format on `admin/config/content/formats`, and the settings live inside that filter format's config. It has no permissions, no Drush commands, and defines no plugin types.

---

- Make wide data tables in body/rich-text fields scroll horizontally on phones instead of overflowing the page.
- Wrap CKEditor-authored tables in a `<figure>` automatically without editors adding markup.
- Add `overflow-x:auto` scrolling to tables in a specific text format (e.g. Full HTML) only.
- Give long pricing/spec tables a keyboard-focusable, screen-reader-labelled scroll container (`tabindex=0`, `aria-label`).
- Keep an existing theme's table styles intact while adding responsive scrolling around them.
- Enable responsive tables site-wide by turning the filter on for the default rich-text format.
- Change the wrapper element from `<figure>` to `<div>` (or another tag) via the filter's `wrapper_element` setting.
- Apply custom wrapper CSS classes (`wrapper_classes`) so the scroll container matches your design system.
- Provide accessible scrollable tables to meet WCAG expectations for content that overflows.
- Avoid writing custom Twig/preprocess code just to wrap tables for responsiveness.
- Ship consistent responsive-table behavior across many content types that share one text format.
- Let content editors paste tables from spreadsheets and have them made responsive on output.
- Combine with core's "Limit allowed HTML tags" filter by ordering this filter appropriately in the format.
- Standardize the scroll wrapper markup so front-end CSS can target one predictable class.
- Wrap tables in migrated/imported HTML content on render without altering the stored markup (reversible transform).
- Enable responsive tables for a documentation or knowledge-base format with large reference tables.
- Give report/dashboard-style nodes horizontally scrollable tables on mobile.
- Provide a semantic `<figure>` container around tabular figures for cleaner document structure.
- Turn the feature on or off per environment by toggling the filter in the format config export.
- Roll out responsive tables to editors by enabling one filter, with no per-node work.
- Use a custom class to attach sticky-header or shadow styling to the scroll container.
