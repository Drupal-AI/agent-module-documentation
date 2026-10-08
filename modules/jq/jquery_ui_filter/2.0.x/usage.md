<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery UI Filter is a text-format filter that turns `[accordion]…[/accordion]` and `[tabs]…[/tabs]` token markup in body HTML into jQuery UI accordion and tabs widgets: editors wrap heading-and-content HTML in a token pair, and the filter builds the interactive widget from that heading structure at render time.

---

The filter plugin `jQueryUiFilter` (*jQuery UI accordion and tabs widgets*, `TYPE_TRANSFORM_IRREVERSIBLE`) scans filtered text for `[accordion]`/`[tabs]` tokens, rewrites each opening token into a `<div data-ui-role="…" data-ui-*>` wrapper (option attributes rendered through Drupal's `Attribute` object) and each closing token into `</div>`, then attaches its own library plus the `jquery_ui_filter.settings` config as `drupalSettings`. The bundled `js/jquery_ui_filter.js` reads the `data-ui-*` options back, splits each wrapper's children on the configured `headerTag` (default `h3`), and initializes the jQuery UI widget — also handling deep-links to a specific panel/tab via the URL fragment, media-type-aware print fallback, and graceful degradation when JavaScript is off. Because jQuery UI was removed from Drupal core, the module depends on the contrib `jquery_ui`, `jquery_ui_accordion` and `jquery_ui_tabs` projects (minimum versions pinned in `info.yml`). Global default options for both widgets live in the `jquery_ui_filter.settings` config, editable at `/admin/config/content/formats/jquery_ui_filter` (`configure: jquery_ui_filter.settings`, permission `administer filters`); any option can be overridden per widget on the token itself, including JSON-valued jQuery UI options. Since the stored value stays plain HTML, disabling the filter leaves readable headings and text rather than broken markup.

---

- Turn a long FAQ page into an accordion with `[accordion]`.
- Convert documentation sections into tabs with `[tabs]`.
- Let editors build tabbed content from plain headings.
- Start an accordion fully collapsed with `[accordion collapsed]`.
- Keep content readable when the filter is disabled.
- Deep-link to a specific accordion panel or tab via the URL fragment.
- Collapse lengthy policy text into expandable sections.
- Present product specifications in tabs.
- Override the panel heading tag per widget (`headerTag="h2"`).
- Pass any jQuery UI option (including JSON) through a token attribute.
- Create sliding tabs with `show`/`hide` JSON effect options.
- Apply widget conversion per text format.
- Keep markup semantic for search engines and screen readers.
- Fall back to plain HTML when the page is printed (`mediaType="screen"`).
- Force the widget to render even when printed (`mediaType="all"`).
- Set site-wide default widget options in one config form.
- Migrate legacy heading-structured content into interactive widgets.
- Give editors a predictable token authoring pattern.
- Keep interactive behaviour out of the stored HTML.
- Disable the widgets site-wide by turning the filter off.
- Reduce page length on mobile by collapsing sections.
- Tune scroll-to-bookmark speed and offset globally.
