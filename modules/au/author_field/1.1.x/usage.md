Author Field provides an `author_field` field type that stores structured researcher/author metadata (given name, family name, email, organization, ORCID ID) with ORCID public-API autocomplete on the edit form and configurable display formatters.

---

Author Field is a field-provider module for academic and research sites that need to attach ORCID-linked author metadata to content. It defines a single composite field type `author_field` with five string sub-properties, a widget whose Search box autocompletes against the ORCID public (or sandbox) search API and auto-fills the sub-fields when an ORCID record is chosen, and three display formatters (a default multi-author list with affiliation superscripts/tooltips, a fully configurable formatter with labels and ORCID link options, and a name-only formatter). A settings form at `/admin/config/content/author_field` chooses the sandbox vs production ORCID endpoint, the endpoint URLs, and how many autocomplete results to show, plus buttons that ping the endpoint to report its status. Because the field embeds author data directly on the host entity rather than referencing a Drupal user, and its uninstall validator forces removal of all `author_field` instances before the module can be uninstalled, it is self-contained. It requires the `jquery_ui_tooltip` module (for the affiliation tooltip) and supports Drupal 10 and 11.

---

- Store author/researcher metadata on nodes or other content entities.
- Attach an ORCID identifier to each author on a piece of content.
- Autocomplete a researcher by name, ORCID ID, or organization while editing.
- Auto-populate given name, family name, email, and organization from a chosen ORCID record.
- Display a byline of multiple authors with numbered affiliation superscripts.
- Show a collapsible "Show affiliations" list of organizations under a byline.
- Render each author name as a link to their `https://orcid.org/<id>` profile.
- Display the ORCID logo/icon next to an author name.
- Show a configurable label (e.g. "Name", "Email", "Organization", "Name Identifier") before each value.
- Present just the author name (name-only formatter) where a compact display is needed.
- Control the ORCID link target (same tab vs new tab) and `rel` attributes (noreferrer/noopener/nofollow).
- Hide individual sub-fields (email, organization, etc.) on the edit widget per field instance.
- Point the module at the ORCID sandbox API for testing before switching to production.
- Check ORCID endpoint availability from the settings form before saving.
- Limit how many ORCID matches appear in the autocomplete dropdown (1–20).
- Build citation/attribution blocks for journal articles or publications.
- Credit contributors on research-institution or university content.
- Capture multiple co-authors, each with their own affiliation, on one field.
- Cleanly remove all author fields via the uninstall helper before uninstalling the module.
- Reuse the field across content types and (form/display) view modes.
- Serve as a structured alternative to free-text author bylines keyed to a persistent identifier.
