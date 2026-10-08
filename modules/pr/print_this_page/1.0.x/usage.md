<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Print This Page provides a print button — as a block or a field formatter — that triggers the browser's print dialog for the current page while hiding configurable page elements.

---

The module renders a `print_this_page_button` theme hook and attaches the `print_this_page/print-button` library, which calls `window.print()` and ships a print stylesheet. A comma-separated list of CSS selectors (default `header, footer, aside, nav, form, iframe, .menu`) is passed to JavaScript via `drupalSettings.printThisPage.excludeList` so those elements are hidden in the printed output. Everything is client-side: there is no server route, no PDF generation, and no permissions.

Two placements are offered. The `print_this_page_block` block (category *Custom*, placed via Block layout) exposes Link Text, Show print icon, and the exclude list in its block form. The `print_this_page` field formatter applies to boolean/string/text/entity_reference fields and renders the same button once per field with the same three settings in Manage display. Both set a `url` cache context. Typical setup is placing the block in a region or adding the formatter to a content type's display and tuning the exclude list to strip site chrome from print output.

---

- Place a "Print this page" block in a region
- Add a print button to a content type via the field formatter
- Customise the button link text
- Show or hide the printer icon on the button
- Exclude the site header from printed output
- Exclude the footer, nav, and sidebars when printing
- Exclude forms and iframes from print output
- Add custom CSS selectors to the print exclude list
- Let visitors print an article without site chrome
- Provide a print action on product or event pages
- Use the block placement for global availability
- Use the formatter placement for per-content-type control
- Print the current page via the browser dialog (no PDF)
- Apply a print-only stylesheet automatically
- Keep the button available to anonymous visitors
- Reuse the same exclude list across block and formatter
- Position the print button in any theme region
