<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Print This Page — block & formatter (print_this_page)

The module provides two placement options for a print button, both rendering the
`print_this_page_button` theme hook and attaching the `print_this_page/print-button`
library (client-side `window.print()` with a print stylesheet).

## Block: `print_this_page_block`
Place the **Print This Page** block (category *Custom*) via *Structure → Block layout*.
Block settings:
- **Link Text** (`link_text`, required) — default "Print this page".
- **Show print icon** (`show_icon`) — toggles the printer icon.
- **Elements to exclude from printing** (`exclude_list`) — comma-separated CSS selectors
  hidden when printing; default `header, footer, aside, nav, form, iframe, .menu`.

The exclude list is passed to JS via `drupalSettings.printThisPage.excludeList`; the render
array sets `#cache['contexts'] = ['url']`.

## Field formatter: `print_this_page`
Assign the **Print This Page** formatter to a field (boolean/string/text/entity_reference)
in *Manage display*. It renders the same button once per field with the same three settings
(`link_text`, `show_icon`, `exclude_list`) exposed in the formatter settings form.

## Notes
- Pure client-side printing — no server route, no PDF generation, no permissions.
- The button is an `<a href="#" target="_blank">`; the JS library wires the print action
  and applies the exclusion selectors.
