<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Atom adds an "Atom Feed" display style (and an "Atom fields" row plugin) to Views so a View's Feed display can output an Atom 1.0 syndication feed.

---

Atom is a small Views add-on that registers a Views style plugin (`id: atom`, class `Drupal\atom\Plugin\views\style\Atom`) and a companion row plugin (`id: atom_fields`, class `Drupal\atom\Plugin\views\row\AtomFields`), both restricted to the `feed` display type. On a View's Feed display you pick "Atom Feed" as the format instead of core's RSS, map View fields to Atom entry parts (title, link, publication date, summary, and optional author name/email and content) in the row plugin, and optionally set feed-level metadata (subtitle, description URL, author name/email, category, logo, icon) in the style options form. The module's `template_preprocess_views_view_atom()` sets the response `Content-Type` to `application/atom+xml; charset=utf-8` (except during live preview) and fills feed-level variables; the `views-view-atom.html.twig` and `views-view-row-atom.html.twig` templates emit the `<feed>` / `<entry>` XML. Because the output is driven entirely by the View, the feed only ever contains rows the View's own access checks allow. It depends solely on core Views and provides no routes, permissions, services, or config of its own.

---

- Publish an Atom 1.0 feed of any content list built with Views.
- Offer an Atom alternative to core Views' built-in RSS feed style.
- Attach an Atom feed to a page display via a Views Feed display and feed path.
- Expose recent articles or blog posts as an Atom feed for feed readers.
- Map a View's title field to each Atom entry's `<title>`.
- Map a link field (e.g. "Link to content") to each entry's `<link>` and `<id>`.
- Map a date field to each entry's `<updated>` timestamp.
- Map a body/summary field to the entry `<summary>`.
- Optionally map author name and author email fields onto entries.
- Optionally map a full-content field to the entry `<content>`.
- Set a human-readable feed subtitle in the style options.
- Point readers to an external feed description via the "Description URL" option.
- Declare a feed-level author name and email for `<author>` and `<rights>`.
- Tag the feed with a `<category>` term.
- Advertise a feed `<logo>` (wide identifying image) and `<icon>` (square favicon).
- Serve the feed with the correct `application/atom+xml` MIME type automatically.
- Syndicate a filtered/sorted content listing (uses all normal Views filters, sorts, and pager).
- Provide per-language feeds by leveraging the View's language handling (`langcode` is set from the current language).
- Combine with contextual filters to build per-term or per-author Atom feeds.
- Feed content respects the View's access controls, so only viewable rows are syndicated.
- Use alongside the suggested Syndication module to expose more Atom features.
- Migrate an existing RSS Views feed to Atom by switching the display format.
- Provide Atom output for aggregators and reader apps that prefer Atom over RSS.
