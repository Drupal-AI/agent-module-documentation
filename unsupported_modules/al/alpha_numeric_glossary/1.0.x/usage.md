<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alpha Numeric Glossary adds an A-Z / 0-9 index of letter and number links to the global (header or footer) area of any View, turning a listing into glossary/directory-style browsing.

---

The module ships a Views global-area handler, "Global: Alpha Numeric Glossary", that you place in a View's header or footer. It renders an item list of alphabet characters (localized: English, Arabic, Russian, or altered via hooks), optional numeric items (individual 0-9 or a single "#" bucket), and an optional "All" item. Each character is a link built from a configurable token path (default `[alpha_numeric_glossary:path]/[alpha_numeric_glossary:value]`); characters that have no matching content are rendered as inactive, non-linked `<span>` items and can be hidden or shown, optionally with per-character result counts. The actual result filtering is done by a standard Views contextual filter in Glossary mode (character limit 1) on the same field you glossary against — the handler determines which letters are "enabled" by querying the distinct first character of that field across the View's result set. It groups against a text/string/string_long/text_long/text_with_summary field, or the base `title` (nodes/most entities) / `name` (taxonomy terms, media) property, and also provides a companion Views field, "Alpha Numeric Glossary" (group), that prints a row's first-character group value for grouping rows. It depends only on core Views and provides no routes, permissions, or standalone settings form.

---

- Add an A-Z browsing bar to the header or footer of a content (node) listing View.
- Build a members/users directory that jumps to names starting with a chosen letter.
- Add alphabetical navigation to a taxonomy-term listing (glossary against the term `name`).
- Index a glossary/dictionary View so readers can jump to terms by first letter.
- Provide alphabetical navigation for a media library View.
- Add 0-9 numeric buckets alongside letters for titles that start with digits.
- Collapse all digit-led entries into a single "#" bucket instead of individual 0-9 items.
- Show an "All" link that clears the character filter and lists every result.
- Hide letters that have no matching content so only reachable characters appear.
- Alternatively, show every letter but render empty ones as greyed-out inactive items.
- Display a per-character record count next to each letter (e.g. "A (12)").
- Group rows in a View by their first-character prefix using the glossary group field.
- Point the glossary links at a separate results page via a custom link path/token.
- Render the glossary as on-page anchors (link path starting with `#`) for a single long page.
- Configure upper- vs lower-case handling separately for displayed text and for URL paths.
- Attach custom CSS classes to the wrapper, list, active, inactive, "All", and numeric items.
- Add custom link attributes (e.g. `data-*`, `role`) to each glossary link.
- Localize the alphabet (Arabic or Russian shipped; others via hook) for non-English sites.
- Alter the alphabet or number set programmatically (remove/add characters) via alter hooks.
- Disable the auto-active first character on a specific landing page URL.
- Style the divider between numeric and alphabetic items when both are shown.
- Provide directory-style first-letter navigation without writing custom query code.
