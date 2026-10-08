Imports publications and biographies from the ORCID public API into the Bibliography & Citation (Bibcite) module, linked to Drupal user profiles.

---

ORCID Import extends Bibcite by pulling a researcher's works and (optionally) biography from ORCID's public v3.0 API into Drupal. On install it creates a set of user fields (`field_orcid`, `field_author`, `field_references`, `field_periodicity`, `field_last_sync`) and places an "ORCID SYNC Button" block on `/user/*` pages that only appears when the profile owner has an ORCID id. From that block a user runs a fetch batch that reads all of their ORCID works, maps each ORCID work type to a Bibcite reference type, parses any embedded BibTeX citation (via `renanbr/bibtex-parser`), and creates or updates `bibcite_reference` and `bibcite_contributor` entities. In the default "Sync authors from ORCID" mode an intermediate form lets an operator confirm which ORCID contributor is the profile owner before import; disabling that mode references publications directly on each profile and unlocks scheduled daily/weekly/monthly cron syncing. The module can also import each user's ORCID biography into a `field_bio` field on a per-user periodicity, bulk-import works and bios for all ORCID-bearing users, and (via Drush) bulk-delete imported references and contributors. Configuration lives in `bibcite_import_orcid.settings` and is edited at `/admin/bibcite_import_orcid/config`.

---

- Populate a researcher's Bibcite publication list automatically from their ORCID record instead of typing references by hand.
- Add an ORCID id to a user profile (`field_orcid`) and expose a one-click "Import publications from ORCID" button on that profile.
- Fetch every work from a user's ORCID profile and create matching `bibcite_reference` entities.
- Map ORCID work types (journal-article, book-chapter, conference-paper, thesis, patent, dataset, software, etc.) to the correct Bibcite reference type.
- Extract volume, issue, pages, publisher, series and author data from a work's embedded BibTeX citation.
- Deduplicate against existing references by DOI, or by title + type when no DOI is present.
- Let an operator interactively choose which ORCID contributor corresponds to the profile owner when "Sync authors" is enabled.
- Create `bibcite_contributor` entities for co-authors and link the owner's contributor to their user account (`field_author`).
- Import references directly onto user profiles (`field_references`) when author-sync is disabled.
- Import a user's ORCID biography into `field_bio` and record the sync date in `field_last_sync`.
- Let each user set a per-profile bio-sync periodicity (monthly / every 90 days / annual / none) via `field_periodicity`.
- Import publications as unpublished by default so an editor can review before they go live (`orcid_unpub_default`).
- Schedule automatic daily, weekly or monthly imports for all ORCID users via cron (`orcid_sync_frequency`).
- Bulk-import works for every active user that has an ORCID id and no references yet, then those that already have some.
- Bulk-import biographies for every active user with an ORCID id.
- Merge duplicate contributors for a user (same first/last name) down to the oldest contributor id after an import.
- Convert LaTeX accent escapes in imported author names to their Unicode equivalents.
- Bulk-clean up imported data with Drush: delete all references, all contributors, everything, or clear users' contributor links.
- Keep a research group's publication database current by re-syncing on a schedule as members add works to ORCID.
- Seed a new academic or institutional Bibcite site from staff ORCID profiles during initial content build-out.
