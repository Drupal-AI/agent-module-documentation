Embed BiblioCommons library book lists and single titles into Drupal entities through configurable field formatters.

---

Bibliocommons Book List integrates a Drupal site with the BiblioCommons library catalog platform (public libraries such as those on `*.bibliocommons.com`). An administrator stores a BiblioCommons API key (as a Key entity), a library ID, and a Syndetics client ID on a settings form. Content editors then add a plain string field to any fieldable entity and hold a BiblioCommons list ID or title (bib) ID in it. Three field formatters — `bibliocommons_booklist`, `bibliocommons_booklist_collection`, and `bibliocommons_book` — take that ID, call the BiblioCommons v1 REST API through the `wsdata` module (which caches the JSON responses), and render the returned titles using `ui_patterns` "book" components and bundled Twig templates. Cover images are resolved from Syndetics (by ISBN/UPC) with per-format fallback icons, and optional "Add to my shelf" and "Place a hold" links are generated back to the patron's BiblioCommons library site. All output is Twig-autoescaped.

---

- Show a curated BiblioCommons reading list (e.g. "Staff Picks") on a landing node by storing the list ID in a field and using the Book List formatter.
- Render a single BiblioCommons title (book) card by ID with cover, title, author, and details link using the Book formatter.
- Build a richer list "collection" view (list description, list-author name and profile link, per-book metadata) with the Book List Collection formatter.
- Limit how many titles from a list are displayed by setting the formatter's "Limit" (0 = show all).
- Add a "Show more" link that deep-links visitors to the full list on the library's BiblioCommons site.
- Display book cover images sourced from Syndetics by ISBN/UPC, with automatic fallback to bundled format icons when no cover exists.
- Prefer large cover images over the default medium size via the "Use large cover image" setting.
- Show or hide per-title fields: title, author name, subtitle, publication date, and description.
- Toggle an "Add to my shelf" link that sends patrons to their BiblioCommons collection page for that bib.
- Toggle a "Place a hold" link that sends patrons to the BiblioCommons hold flow for that bib.
- Localize requests by current interface language (the `locale` query parameter is set from the active language).
- Store the BiblioCommons API key securely as a Key entity (env, file, or config provider) instead of pasting a raw secret into a formatter.
- Cache remote catalog responses automatically (the `books` list call caches for 3600s via wsdata) to reduce API load and speed up page rendering.
- Support French titles by preferring the BiblioCommons jacket-cover URL when the title's language is French.
- Truncate long book descriptions to ~200 characters in the pattern template for compact display.
- Theme the output by overriding the `bibliocommons_books` / `bibliocommons_books_collection` templates or the `book` / `book_details` ui_patterns.
- Restrict who may configure the integration with the dedicated `administer bibliocommons` permission.
- Reuse the wsdata `wsserver`/`wscall` config (endpoint `https://api.bibliocommons.com/v1/`) as a starting point for other BiblioCommons API paths.
- Present a promotional book carousel or shelf on a library's Drupal homepage sourced live from its BiblioCommons catalog.
- Attach book displays to any entity type that supports fields (nodes, taxonomy terms, media, paragraphs) since the formatters bind to plain `string` fields.
