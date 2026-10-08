<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DOI Field adds a "DOI" field type that stores a Digital Object Identifier and, on display, shows metadata (title, authors, abstract, date, links) fetched for that DOI.

---

DOI Field (`doi_field`) provides a single field type, `doi_field`, that stores one DOI string (a persistent identifier such as `10.1000/182`) per value in a 255-character varchar column. Values are validated against a DOI-format constraint (`Doi`), so malformed identifiers are rejected on save. The module ships a matching field widget (a plain text input) and a formatter (`doi_field_formatter`). At display time the formatter hands each stored DOI to the required `doi_search` module's `doi_search.manager` service, which queries the Crossref works API, and renders the publication metadata through the `doi_field` theme (template `doi-field.html.twig`). On the field's Manage-display settings you pick which elements to show — title, author, abstract, date, link and PDF link — and whether to print a label above each element. There is no module settings form; everything is configured per field through Drupal's Field UI. The module has no permissions, routes, services or Drush commands of its own.

---

- Add a DOI field to a content type, taxonomy term, user or any fieldable entity.
- Store a scholarly publication's DOI alongside its content.
- Validate that an entered DOI matches the `10.<registrant>/<suffix>` format before it is saved.
- Reject DOIs that contain whitespace or are missing the `10.` prefix.
- Display the publication title resolved from a stored DOI.
- Display the publication's authors, formatted as a comma-separated list.
- Display the publication abstract on the entity page.
- Display the publication date in a readable `d M Y` format.
- Display a link to the publication's landing page.
- Display a direct link to the publication PDF when one is available.
- Choose per view-display which of those elements appear.
- Show or hide descriptive labels above each displayed element.
- Attach DOI references to research, library or academic content.
- Build a publications listing where each node carries its own DOI.
- Let editors enter just the DOI and have publication details rendered automatically.
- Support multi-value DOI fields (several DOIs on one entity).
- Add DOI metadata display without writing a custom formatter.
- Override the DOI output by copying `doi-field.html.twig` into a theme.
- Use the DOI field type on custom entity types, not just nodes.
- Keep citation data in sync with the source by resolving it at display time.
- Combine with the DOI Publications Search (`doi_search`) module it depends on.
