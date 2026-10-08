<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generates ePub 3 ebooks from Drupal content in pure PHP, with no external binaries or headless browser.

---

ePub Generator converts rendered Drupal content into valid `.epub` ebooks using the pure-PHP `andileco/php-epub` library, so it works on managed hosting (Pantheon and similar) that cannot run wkhtmltopdf or headless Chrome — it needs only the `zip`, `dom` and `libxml` PHP extensions. Enabling it adds a **Download ePub** tab to nodes and a generic `/epub/download/{entity_type}/{entity_id}` route for other content entities; both render the entity through a dedicated **ePub** view mode (falling back to **Full**), convert the HTML to well-formed XHTML, embed local images, and stream the result as an `application/epub+zip` download. A settings form controls default language, publisher, custom stylesheet, which bundles may be exported, CSS "strip selectors" removed from every book, and default layout (reflowable or fixed-layout). Drush commands `epub:generate` and `epub:generate-book` generate ebooks from the CLI. Three submodules extend it: Book Integration (multi-chapter books from Book outlines), Markdown (convert uploaded `.md` files), and Viewer (in-browser epub.js reader plus response caching).

---

- Offer readers a one-click ePub download of any node via the **Download ePub** tab.
- Export any renderable content entity as an ebook through `/epub/download/{entity_type}/{entity_id}`.
- Publish reports, manuals and documentation as portable, offline-readable ebooks.
- Run ePub export on managed/PaaS hosting where installing binaries is impossible.
- Control exactly which fields appear in the ebook with a dedicated **ePub** view mode.
- Fall back to the **Full** view mode automatically for bundles without an ePub display.
- Restrict which entity types and bundles may generate ePubs from the settings form.
- Embed a custom CSS stylesheet, or point the module at your own file, for ebook styling.
- Strip unwanted markup (internal-note fields, sidebars) from every ebook via CSS selectors.
- Produce accessible ebooks with schema.org accessibility metadata and an ePub 2 NCX fallback.
- Generate fixed-layout (pre-paginated) ebooks with viewport, spread and orientation control.
- Preserve SVG and MathML in output for charts, diagrams and equations.
- Auto-strip Drupal chrome (tabs, contextual links, admin links, book navigation) from output.
- Embed local and rendered-image-style images directly into the ebook archive.
- Add a title page with publishing metadata (title, author, publisher, ISBN, rights, date).
- Automate exports in cron or deploy scripts with `drush epub:generate <id>`.
- Assemble entire Book outlines into multi-chapter ebooks (Book Integration submodule).
- Read book metadata (author, ISBN, cover, layout) from fields via configurable mapping.
- One-click create and map the full set of book metadata fields on a content type.
- Convert uploaded Markdown files (with YAML front matter) to ePub (Markdown submodule).
- Split Markdown into chapters on `#` headings and sub-chapters on `##` (Markdown submodule).
- Let visitors read ebooks in the browser with a **Read online** tab (Viewer submodule).
- Render uploaded `.epub` files inline with a field formatter (Viewer submodule).
- Cache generated ePub bytes at the response level so books are not rebuilt each request (Viewer).
- Set the publisher and language defaults embedded in every ebook's metadata.
- Provide a separate download-generation permission distinct from site administration.
