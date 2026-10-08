<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Library attach adds a text-format filter, "Library scanner", that attaches a CSS/JS asset library to the page whenever content contains HTML matching a selector the library declared.

---

The problem it solves: a snippet of content needs a script or stylesheet — a chart, a map, a lightbox, a syntax highlighter — but you do not want that asset loaded on every page (a payload most pages never use) and you do not want to build a custom formatter or paragraph type for each case. With this module a developer opts a library in once by adding a `filter-selector-css` or `filter-selector-xpath` key to the library's entry in a `*.libraries.yml` file, for example `filter-selector-css: 'table.chart, div.chart'`. You then enable the **Library scanner** filter (id `library_attach`) on the relevant text format at `/admin/config/content/formats`. On render, the filter loads the content HTML, runs each declared selector against it with `DOMXPath`, and for every match attaches the matching `extension/library_name` through Drupal's normal asset aggregation and dependency ordering — the content text itself is left untouched. CSS selectors are converted to XPath via `symfony/css-selector` (a composer requirement, alongside the `ext-dom` PHP extension); `filter-selector-xpath` takes precedence when both keys are set. The selector map is discovered across core, enabled modules, and the active theme, and cached under the `library_info` tag, so run `drush cr` after changing a selector. Importantly, the set of attachable libraries is fixed by developers, not named by editors: content can only trigger one of the pre-declared selectors, never request an arbitrary library. The module has no settings page, no permissions, no services, no routes, and no drush commands — it is one filter plugin plus the library-YAML convention. Version **1.0.1**, core `^10 || ^11`, depends on core `filter`.

---

- Load a chart library only on articles that contain a chart.
- Attach a map library where a map element appears.
- Avoid loading an interactive library site-wide from the theme.
- Let content pull in its own JS/CSS dependency automatically.
- Attach a lightbox library only on pages that use it.
- Reduce asset payload on pages that do not need the library.
- Keep content-triggered libraries inside Drupal's aggregation pipeline.
- Avoid pasting raw `<script>` tags into body fields.
- Attach a slider library when a slider markup pattern is present.
- Load a syntax highlighter only on documentation pages.
- Trigger a library attachment from WYSIWYG-authored HTML.
- Support occasional interactive embeds without a custom formatter.
- Attach a font-icon library only where its markup occurs.
- Load an animation library selectively per piece of content.
- Provide assets for a one-off campaign page without theme changes.
- Declare an attachable library with a CSS selector in `*.libraries.yml`.
- Declare an attachable library with an XPath selector for precise matching.
- Enable the "Library scanner" filter on a chosen text format.
- Confirm attachable libraries via the format's long filter tips.
- Keep the stored content text unchanged while still loading its assets.
- Order the filter after embed/line-break filters so their HTML is scanned.
- Rebuild caches (`drush cr`) after editing a `filter-selector-*` key.
