Facets Searchbox Widget adds a search input on top of a facet's item list, letting users type to filter long lists of facet values (e.g. hundreds of authors or tags) down to matching entries client-side.

---

This facets submodule provides two widget plugins — `SearchboxLinksWidget` and `SearchboxCheckboxWidget` — that wrap the standard links and checkbox facet widgets with a text input. As the user types, JavaScript hides non-matching facet items so a very long value list becomes navigable. It ships its own JS, CSS, templates, and config schema for the widget settings. Because it is a drop-in widget, you just pick it on a facet's settings form; no separate admin page or permissions are involved. Use it for facets with many values where scrolling or a soft-limit "show more" is not enough — authors, tags, brands, cities, ingredients, and similar high-cardinality fields.

---

- Add a filter box above a long list of tag facets.
- Let users type to narrow a hundreds-of-authors facet.
- Filter a large brand list on a product catalog.
- Search within a city/location facet client-side.
- Provide type-ahead filtering of ingredient facets on recipe search.
- Make a big taxonomy facet usable without endless scrolling.
- Combine searchbox filtering with checkbox multi-select.
- Add a searchbox to a links-style facet.
- Filter a language or country facet quickly.
- Narrow a skills/tags facet on a directory.
- Improve UX on facets that exceed the soft limit.
- Let editors pick the searchbox widget per facet.
- Search a genre or category facet on a media library.
- Filter an organization/department facet on an intranet.
- Provide keyboard-friendly filtering of facet values.
- Reduce clicks on high-cardinality facets.
- Add a searchbox to a checkbox facet for OR filtering.
- Filter a manufacturer/model facet on a parts catalog.
- Make a long author facet accessible on mobile.
- Style the searchbox to match the facet block theme.
