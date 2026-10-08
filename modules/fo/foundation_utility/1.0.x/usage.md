<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a text-format filter that applies Foundation framework table classes and cleans up table markup.
---
For sites themed with Zurb Foundation, editor-produced tables often carry inline `width`, `height`, and `style` attributes and lack Foundation's helper classes. The module's `foundation_utility_table_filter` filter plugin (`\Drupal\foundation_utility\Plugin\Filter\TableFilter`, `TYPE_TRANSFORM_IRREVERSIBLE`) parses the rendered HTML with Symfony's DomCrawler, walks every `<table>` (and its cells recursively), and rewrites the markup according to the filter's settings.

Configurable options add `.scroll`, `.hover`, `.unstriped`, and `.stack` classes to tables and optionally remove `width`/`height` and/or `style` attributes from tables and cells. You enable it per text format at Administration » Configuration » Content authoring » Text formats and editors, order it appropriately in the filter pipeline, and tick the desired transforms. It depends on core `ckeditor5` and `editor`. The filter only removes attributes and appends classes; it does not introduce new user-controlled markup.
---
- Make WYSIWYG tables horizontally scrollable on small screens (`.scroll`).
- Add Foundation `.hover` row-highlight styling to editor tables.
- Add `.unstriped` to remove zebra striping from tables.
- Add `.stack` so tables collapse to a stacked layout on mobile.
- Strip inline `width`/`height` from pasted tables for responsive display.
- Remove inline `style` attributes from tables and cells.
- Normalise messy tables pasted from Word/Excel.
- Apply consistent table styling across all editor content.
- Enable the filter on a specific text format only.
- Combine attribute stripping with `.scroll` for responsive tables.
- Clean up child cell attributes recursively (`td`, `th`, ...).
- Keep existing table classes and append Foundation ones.
- Configure per-format which transforms run.
- Integrate Foundation table styling without touching the theme.
- Order the filter after other HTML-producing filters.
- Provide a no-op pass-through when text contains no tables.
- Preserve non-table markup untouched.
- Support Foundation-based custom and admin themes.