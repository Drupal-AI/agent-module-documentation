<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Real Content adds a `real_content` Twig **filter** and Twig **test** that tell you whether a rendered Twig variable (typically a page region) contains meaningful content, or is just empty wrapper markup and whitespace.

---

Core's `{% if page.sidebar %}` is often true even when a region renders nothing but empty `<div>`s and whitespace, so themers wrap regions that then show up blank. Twig Real Content solves this with a single Twig extension (`TwigRealContentTwigExtension`, tagged `twig.extension`) that registers both a test (`is real_content`) and a filter (`|real_content`). Both take an already-rendered value: they short-circuit to empty/FALSE for an empty render array (`Element::isEmpty()`), require the value to be a string or `MarkupInterface` (throwing `TwigRealContentException` otherwise — so you must `|render` or capture the variable first), then run `strip_tags()` keeping only an allowlist of "self-meaningful" tags (`img`, `iframe`, `video`, `svg`, `object`, `embed`, `input`, `hr`, `script`, `style`, `link`, `source`, `drupal-render-placeholder`) and trim whitespace. The **test** returns TRUE when something is left; the **filter** returns the stripped/trimmed string (or `''`). This lets a template decide, correctly, whether to render a wrapper: `{% if page.sidebar|render is real_content %}`. The module has no configuration, routes, permissions, schema, or services beyond the one Twig extension — its entire surface is those two Twig callables.

---

- Only render a region wrapper (`<aside>`, grid column, card) when the region actually has visible content.
- Fix "empty" sidebars/regions that core's `{% if page.region %}` wrongly treats as non-empty.
- Hide an empty "sidebar first"/"sidebar second" column so the main content can go full width.
- Collapse an empty footer region instead of rendering blank padded markup.
- Decide whether to output a `<section>` around `page.highlighted` based on real content.
- Treat a region that contains only an image, iframe, or video as non-empty (allowlisted tags).
- Strip empty wrapper markup from a variable and output only the meaningful remainder with `|real_content`.
- Guard a Layout Builder / block region so its heading is skipped when the region is blank.
- Conditionally add body/grid CSS classes depending on which regions actually have content.
- Avoid printing an empty `<div class="region">` that breaks CSS spacing or borders.
- Check a rendered field or block variable for meaningful content before wrapping it.
- Prevent a two-column template from collapsing awkwardly when one column is empty.
- Render a "no content" fallback only when a region truly has nothing meaningful.
- Keep an image-only or embed-only region visible while hiding a whitespace-only region.
- Use `{{ var|render is real_content ? 'has-content' : 'is-empty' }}` to toggle a class.
- Determine emptiness of a captured block of markup (via `{% set x %}…{% endset %}`) before output.
- Clean up print/PDF templates by dropping empty region wrappers.
- Simplify complex page templates that previously used verbose manual emptiness checks.
- Ensure ARIA landmarks (`<aside>`, `<nav>`) are only emitted when they contain real content.
- Trim leading/trailing whitespace-only markup from a rendered value for tighter HTML output.
- Detect that a region contains only a `drupal-render-placeholder` (lazy/placeholdered content) and keep it.
- Wrap a promoted/featured area only when an editor has actually placed content there.
- Debug why a region appears "non-empty" by running its rendered output through `|real_content`.
- Replace bespoke per-theme empty-region helper functions with a shared, reusable Twig test.
