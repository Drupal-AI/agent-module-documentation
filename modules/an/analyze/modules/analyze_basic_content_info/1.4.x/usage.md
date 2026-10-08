<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze Basic Content Info adds one Analyze plugin that shows a word count and an image count for a content entity on its Analyze tab.

---

This submodule of Analyze provides a single `Plugin/Analyze` plugin, `ContentInfo` (id `content_info`, label "Basic Content Info"). On an entity's Analyze tab it renders a two-column "Basic Info" table with two rows: "Word count" and "Image count". Both are computed from the entity's rendered `default` view mode: `getHtml()` builds the view with the entity type's view builder in the current language and renders it, `getWordCount()` strips tags (and `&nbsp;`) then calls `str_word_count()`, and `getImageCount()` counts `<img` occurrences with `preg_match_all`. It has no full report — `getFullReportUrl()` returns `NULL`, so no "View full report" link appears. It defines no routes, permissions, services or config; enabling/visibility is entirely handled by the parent Analyze module (route subscriber, access check, per-bundle settings). Requires `analyze`.

---

- Show editors a quick word count for a node, term, media item or any canonical entity.
- Show how many images are embedded in a piece of content.
- Give a lightweight, dependency-free first analyzer to demonstrate the Analyze tab.
- Provide a baseline content-length signal alongside SEO/readability analyzers.
- Spot near-empty content (very low word count) at a glance from the Analyze tab.
- Confirm an article actually contains images before publishing.
- Enable per content type/bundle from the bundle edit form's "Analyze settings" section.
- Toggle centrally at Configuration > Content > Content Analysis.
- Use it as a reference implementation of `renderSummary()` returning an `analyze_table`.
- Combine it with other analyzers (Node Views, Google Analytics) in the same tab.
- Count words across the fully rendered entity (all fields in the default display), not just the body field.
- Run it in bulk over a content type via `drush analyze:batch`.
- Read counts in the site's current language (the render uses the current langcode).
- Serve as the default/example analyzer that ships enabled in the Analyze suite.
- Give a summary-only analyzer (no separate report page) when a single glanceable metric is enough.
