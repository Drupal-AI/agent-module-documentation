Citeref (Citation or Reference) Field adds a Drupal field type that stores a citation/reference identified by a DOI, Handle, ARK, URL, URN (ISSN/ISBN) or "Other", and can look the identifier up against the relevant public resolver/citation API to fetch or validate a formatted citation.

---

The module provides one field type (`citeref_field`) with four stored properties — citation type, CSL style name, citation identifier, and citation text — plus a matching widget, two display formatters, a settings form for the external endpoint URLs, a logged-in CSL-style autocomplete endpoint, and an uninstall-cleanup form. When editing, the widget offers an AJAX-driven experience keyed on the chosen citation type: for a DOI it calls the DOI content-negotiation service (with a chosen CSL style) to fetch a formatted bibliography entry; for Handle/ARK/URL/URN it queries the corresponding resolver (Handle.Net, N2T, the target URL, ISSN Portal, or Google Books for ISBN) to validate and/or summarise the reference. The endpoint base URLs are configurable at `/admin/config/content/citeref_field` and each has a "check status" button. On display, the default formatter renders the stored citation text and the configurable formatter builds a labelled block with an optional resolver link (DOI/Handle/ARK/ISSN/ISBN) and link-behaviour options (target, noreferrer/noopener/nofollow). Because the field can hold arbitrary bibliographic data, it fits publication, research-output, library, and reference-list content models on Drupal 10 and 11.

---

- Add a "Citation or reference" field to a content type (e.g. Publication, Article, Dataset) to store a DOI and its formatted citation.
- Capture a persistent identifier (DOI/Handle/ARK) for a research output and auto-fetch the formatted reference on entry.
- Let editors pick a citation type from DOI, Handle, ARK, URL, URN, or Other per field value.
- Fetch an APA/MLA/Chicago/etc. formatted citation for a DOI by choosing a CSL style name via autocomplete.
- Validate that a DOI resolves and produces a bibliography entry before saving content.
- Validate a Handle identifier and list its referred URLs/e-mail values via the Handle.Net API.
- Validate an ARK identifier through the N2T global resolver.
- Store a plain URL reference and auto-generate an "URL: <page title>. Accessed <date> from <url>" citation line.
- Store an ISBN (as `isbn:...`) and pull author/title/publisher/date from the Google Books API.
- Store an ISSN (as `issn:...`) and check it against the ISSN Portal.
- Keep a free-form "Other" identifier when no resolver applies.
- Build a bibliography/reference list on a node by using a multi-value citeref field.
- Display citations with the simple default formatter (citation text only).
- Display citations with the configurable formatter: labelled type/style/ID/text and a clickable resolver link.
- Configure per-display link behaviour: open in same/new tab, and add `noreferrer` / `noopener` / `nofollow`.
- Show the citation ID either as a URL link or as a resolver icon (DOI/Handle/ARK logos).
- Hide individual sub-fields (type, style, ID, text) in the edit widget and relabel each one.
- Point the DOI/Handle/ARK/ISBN/ISSN lookups at alternative or mirror endpoints via the settings form.
- Use the "API Status" buttons on the settings form to confirm each external service is reachable.
- Provide a logged-in autocomplete of CSL style names sourced from the bundled `csl_styles.txt` list.
- Cleanly uninstall the module using the built-in form that lists and deletes all citeref fields on node bundles (then runs cron).
