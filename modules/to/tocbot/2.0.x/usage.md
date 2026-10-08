Tocbot wraps the Tocbot JavaScript library to build an automatic, clickable table of contents from a page's headings, exposed as a placeable Drupal block and configured entirely from an admin settings form.

---

The module provides a **"Tocbot TOC"** block (plugin id `tocbot_block`) that outputs an empty
`<div class="js-toc-block">` and attaches the Tocbot library plus a `drupalSettings.tocbot` object.
Its init behavior (`js/tocbot-init.js`) scans the configured `contentSelector` (default `#content`)
for headings matching `headingSelector` (default `h2, h3, h4, h5, h6`), and if there are at least
`minActivate` of them (default 3) it calls `tocbot.init()` to render the list into `tocSelector`
(default `.js-toc-block`, i.e. the block itself). It can optionally create automatic heading `id`s
(`createAutoIds`) so the anchor links work without another module. All ~30 Tocbot API options are
editable at **admin/config/content/tocbot** (route `tocbot.settings`, gated by the core *administer
site configuration* permission) and stored in the `tocbot.settings` config object; the block copies
each snake_case config key to its camelCase Tocbot option at render time via `TocbotHelper`. The
Tocbot library itself loads from a **CDN by default**, but if you place the files at
`/libraries/tocbot/dist/tocbot.min.js` + `.css` the module uses those local copies instead
(`TocbotHelper::getLibrary()`). The module defines no permissions, no Drush commands, and no config
schema of its own; its only building block is the block plus the settings form.

---

- Add an auto-generated, clickable table of contents to long documentation pages.
- Give lengthy blog posts or articles in-page anchor navigation built from their headings.
- Show a sticky sidebar TOC that highlights the current section while scrolling (scrollspy).
- Place the "Tocbot TOC" block in a sidebar region so it appears beside content.
- Restrict the TOC to only `h2` and `h3` headings by editing `headingSelector`.
- Prevent the TOC from appearing on short pages by raising `minActivate` (min heading count).
- Auto-generate heading `id` anchors so links work even when the CMS doesn't add them (`createAutoIds`).
- Point Tocbot at a custom content wrapper by setting `contentSelector` to your theme's selector.
- Render the TOC into a custom `<div>` in your theme by changing `tocSelector`.
- Produce an ordered (`<ol>`) or unordered (`<ol>`→`<ul>`) list via the `orderedList` option.
- Collapse deep nesting automatically using `collapseDepth`.
- Add a body CSS class when the TOC activates (`extra_body_class`) to adjust the layout/theme.
- Enable smooth scrolling to sections with a configurable duration and offset.
- Make the TOC stick to the viewport after scrolling with `positionFixedClass` / `fixedSidebarOffset`.
- Exclude specific headings from the TOC via `ignoreSelector` (default skips `.visually-hidden`).
- Host the Tocbot library locally (offline / CSP-friendly) by dropping files in `/libraries/tocbot/dist/`.
- Tune scroll-event performance with `throttleTimeout`.
- Offset heading calculations for a fixed header using `headingsOffset`.
- Provide consistent in-page navigation across a knowledge base or manual.
- Style the TOC links/list with the configurable class names (`linkClass`, `listClass`, etc.).
- Improve UX on FAQ or reference pages that have many sections.
- Add a "jump to section" experience without writing any JavaScript.
