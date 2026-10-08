Keeps chosen parts of a page (selected by jQuery/CSS selector) in a fixed position as the user scrolls, similar to core's sticky table headers — useful for sidebars and side menus on long pages.

---

Configuration is a single admin form at `/admin/config/user-interface/floating-block` (route `floating_block.admin_settings`, permission `administer site configuration`). You enter one floating block per line in the textarea using the format `selector|key=value,key=value` — e.g. `#sidebar-left|padding_top=8,padding_bottom=4,container=#main`. A helper service (`floating_block`, class `Drupal\floating_block\Helper`) converts that text to/from the stored array via `convertTextToArray()` / `convertArrayToText()`, and the form's `validateForm()` rejects lines whose round-trip isn't idempotent (i.e. malformed syntax). Settings are stored in `floating_block.settings` (`blocks`: a sequence of per-block string maps; `min_width`: integer). `hook_page_attachments()` only attaches the front-end when at least one block is configured: it adds the `floating_block/floating_block` library and passes `drupalSettings.floatingBlock.blocks` and `drupalSettings.floatingBlock.min_width` to the browser, and marks the config as a cacheable dependency so changes propagate without a cache clear. The bundled `floating_block.js` (jQuery + drupalSettings) reads those settings and pins each matched element while scrolling. `min_width` sets a viewport width below which floating is disabled (0 = always on). Recognised per-block options include `padding_top`, `padding_bottom`, and `container` (constrain floating within a wrapper element). There are no permissions of its own, no Drush, and no plugin types.

---

- Keep a left or right sidebar in view while scrolling a long article.
- Pin a side navigation menu so it stays visible on content-heavy pages.
- Float a table of contents alongside long-form documentation.
- Keep a call-to-action or signup box on screen as the reader scrolls.
- Constrain a floating sidebar within a `#main` container so it doesn't overlap the footer.
- Offset a floated block from the top of the viewport (`padding_top`) to clear a sticky header.
- Offset a floated block from the bottom of the page (`padding_bottom`) near the footer.
- Disable floating on small screens by setting a `min_width` (e.g. 850px).
- Enable floating at all screen sizes by setting `min_width` to 0.
- Float multiple regions at once by listing several selectors, one per line.
- Target any theme element via a standard jQuery/CSS selector (id, class, etc.).
- Reproduce a "sticky sidebar" effect without writing custom JavaScript.
- Keep filter/faceted-search controls visible on long listing pages.
- Pin an author bio or related-links panel next to blog content.
- Keep a shopping cart summary visible while browsing a long product page.
- Provide a persistent in-page jump menu for one-page sites.
- Float a promo banner within a specific column only.
- Configure floating behaviour entirely from the admin UI (no code).
- Adjust which regions float per site without touching templates.
- Rely on config being a cacheable dependency so edits appear without a manual cache clear.
