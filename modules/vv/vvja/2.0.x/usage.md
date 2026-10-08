<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Vanilla Javascript Accordion (VVJA) adds a Views display **format** that renders results as an accessible, collapsible accordion using plain JavaScript instead of jQuery or any bundled library.

---

Install with `composer require drupal/vvja` (which also pulls the required **`vvj_core`** foundation) and enable both with `drush en vvja`, then edit any View, set its **Format** to *Views Vanilla JavaScript Accordion*, and choose **Fields** as the row style — the module enforces this because the **first field becomes each panel's clickable trigger** and the remaining fields render into the collapsible pane. Everything is configured per view display in the Views UI (there is no global settings page): toggle the per-panel and global expand/collapse buttons, pick which panels open on load (`none`, `first`, or `all`), enable **exclusive mode** so only one panel opens at a time, choose one of seven animations (`None`, slide from top/bottom/left/right, zoom, fade) with a `0.1`–`2.0`s transition speed, and tune layout with card width, content padding, and panel gap in pixels. You can paste your own **SVG icons** for the toggle buttons (all SVG is sanitized against XSS), turn on **deep linking** to get shareable `#accordion-<id>-<n>` URLs with browser back/forward support, drive panels from your own code via the `Drupal.vvja` JavaScript API (`openPanel`, `closePanel`, `togglePanel`, `getOpenPanels`, `getTotalPanels`, `getInstance`), and print first-row field values into the view's header/footer/empty text with `[vvja:field_name]` (or `[vvja:field_name:plain]`) tokens. It requires **Drupal 11.3+ or 12 and PHP 8.3+** — there is no Drupal 10 build — and is a byte-compatible upgrade from 1.x that preserves every option key, CSS class, template name, and JS API.

---

- Turn a filtered content listing into an accessible FAQ accordion.
- Replace a jQuery-based accordion module with a no-library alternative.
- Build collapsible product/spec sections from a Views display.
- Render taxonomy-filtered results as expand/collapse panels.
- Use contextual filters to vary accordion content per page.
- Combine the accordion with a Views pager or exposed filters.
- Show a "one panel open at a time" accordion via exclusive mode.
- Open the first panel (or all panels) automatically on page load.
- Add an "Expand all / Collapse all" button above the panels.
- Create card-style expandable items by setting a fixed item width.
- Tune panel spacing and content padding without writing CSS.
- Apply a fade, zoom, or directional slide animation to panel transitions.
- Respect reduced-motion preferences automatically.
- Provide shareable deep links to individual accordion panels.
- Control the accordion from custom JavaScript via `Drupal.vvja`.
- Swap in custom SVG toggle icons that inherit theme colors.
- Print a first-row field into the view header with `[vvja:title]` tokens.
- Meet keyboard and screen-reader accessibility requirements for accordions.
- Theme the accordion entirely with your own CSS by disabling the bundled stylesheet.
- Reduce front-end payload by dropping a third-party accordion library.
- Reuse the same `vvj_core` foundation across multiple VVJ display formats.
- Stand up a working demo quickly from the optional `vvja_example` view.
