<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DOI Publications resolves a DOI to its scholarly publication metadata via the Crossref API and shows it on a search page, and exposes a reusable service other modules can call.

---

DOI Publications (`doi_search`) provides two things: a search page at `/doi-search` where a user with the `access doi search` permission enters a DOI (Digital Object Identifier) and sees the resolved publication — title, authors, publication date, abstract, journal/container title and volume, canonical URL, an optional PDF link, and the work's cited references — and a service `doi_search.manager` whose `getData($doi)` method returns the raw Crossref record for programmatic use. The controller `DoiSearchController::build()` fetches the record through the manager, formats authors/date/PDF/references, and renders it with the module's own Twig templates (`doi-search-page`, `doi-search-result`, `doi-search-reference`). The module has no settings form and no config objects; the only setup is enabling it and granting its single permission. The companion `doi_field` module depends on `doi_search` and calls the same service. It suits academic, library and research sites that reference works by DOI.

---

- Look up a single publication's metadata by pasting its DOI into `/doi-search`.
- Show a publication's title, authors, date, abstract, journal and volume from Crossref.
- Give researchers a link to the canonical publisher URL for a DOI.
- Offer a direct PDF download link when the Crossref record advertises one.
- List and resolve a publication's cited references on the same result page.
- Resolve each reference's own DOI to a title/author/year when it carries one.
- Add a self-service DOI lookup page for library patrons or students.
- Let editors verify a DOI resolves before citing it in content.
- Fetch a Crossref record from custom code with `\Drupal::service('doi_search.manager')->getData($doi)`.
- Back a custom block or controller with publication metadata from the service.
- Provide the metadata backend for the companion `doi_field` field module.
- Restrict who can run DOI lookups by granting `access doi search` to chosen roles.
- Build a reading-list or bibliography feature on top of the service.
- Populate citation displays for journal-club or course pages.
- Pre-fill a citation form by resolving a DOI a user typed.
- Confirm author lists and publication dates for a set of DOIs.
- Surface the abstract of a referenced work inline.
- Drive an internal tool that audits DOIs used across a site.
- Give repository or institutional-archive sites a quick DOI resolver.
- Expose publication metadata to other integrations through one service call.
