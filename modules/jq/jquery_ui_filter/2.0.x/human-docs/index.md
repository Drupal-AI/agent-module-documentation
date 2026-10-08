# jQuery UI Filter — manual setup guide

**jQuery UI Filter** (`jquery_ui_filter`) turns plain heading-and-content HTML
into interactive jQuery UI **accordion** or **tabs** widgets. Editors write
ordinary headings and paragraphs; the filter converts the marked-up region into an
interactive widget at render time. A long FAQ becomes an accordion, and a set of
documentation sections becomes tabs — without teaching editors any special
widget-building interface.

Because the conversion happens as a text filter at render time, the stored content
stays plain, semantic HTML. That means disabling the filter leaves readable
headings and text rather than broken markup, and search engines still see proper
structure. The module's own JavaScript wires the widgets up, supports deep-linking
straight to a specific tab or panel, and keeps the widgets accessible.

One thing to understand up front: jQuery UI was **removed from Drupal core**, so
this module depends on the community-maintained jQuery UI contrib projects
(`jquery_ui`, `jquery_ui_accordion` and `jquery_ui_tabs`) — all three must be
installed. jQuery UI itself is also end-of-life upstream, so this is best thought
of as a migration-friendly option for existing heading-structured content rather
than a first choice for brand-new builds.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the jQuery UI
   contrib stack with Composer, then enable everything.

## Where it lives in the admin menu

- The filter is turned on per text format at **Configuration → Content authoring →
  Text formats and editors** (`/admin/config/content/formats`).
- The module also adds a small global settings page at **Configuration → Content
  authoring → jQuery UI filter** (`/admin/config/content/jquery_ui_filter`), plus
  per-format options on the filter's settings.

## How to use it

1. Enable the **jQuery UI accordion and tabs widgets** filter on the text
   format(s) you want it to work in, at
   `/admin/config/content/formats` → *Configure* a format → tick the filter →
   **Save**.
2. Adjust any per-format filter options, and the module-wide defaults at
   `/admin/config/content/jquery_ui_filter`, to suit your content.
3. In content using that format, structure your HTML as the widget expects —
   headings for each panel/tab followed by their content inside a wrapper. When
   the page renders, the filter converts that region into an accordion or tabs
   widget.

Because the markup stays plain until render time, you can safely turn the filter
off later and your content degrades gracefully to ordinary headings and text.
