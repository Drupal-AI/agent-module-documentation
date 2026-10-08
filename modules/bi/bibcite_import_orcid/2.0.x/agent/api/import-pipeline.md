<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ORCID Import — import pipeline & API

All ORCID traffic goes through `src/Fetch.php`, which builds a fresh `GuzzleHttp\Client` per call and GETs the anonymous **public** API at `https://pub.orcid.org/v3.0/…` with `Accept: application/json`. There is no ORCID OAuth, token, client id or secret anywhere in the module — only public reads.

## Fetch (`Drupal\bibcite_import_orcid\Fetch`, plain `new`)
- `getUserFromOrcid($orcid)` → `GET /v3.0/{orcid}` (person record; used for name + biography).
- `getAllWorksFromOrcid($orcid)` → `GET /v3.0/{orcid}/works` → returns the `group` array.
- `getOrcidWorkData($put_code, $orcid)` → `GET /v3.0/{orcid}/works/{put_code}` → `["bulk"][0]["work"]`.
- `syncBio($user)` — if `orcid_fetch_bio` and the user's `field_periodicity`/`field_last_sync` cadence is due, calls the `import_user` service.
- `bibciteEntityTypes($orcidType)` — static map ORCID work-type → Bibcite reference type (default `miscellaneous`).

RequestExceptions are swallowed and surfaced via `messenger()->addStatus()`, returning NULL.

## Interactive flow (author-sync ON, the default)
1. **Block** `Plugin\Block\OrcidBlock::build()` renders on a user profile with an ORCID id: an "Import Biography from ORCID" link (→ route `import_bio`) plus the `Form\PrepareImport` form. `blockAccess()` requires permission `view orcid import block` and a non-empty `field_orcid`.
2. **`Form\PrepareImport::submitForm()`** — reads the profile `user` route param, its `field_orcid`, calls `Fetch::syncBio()`, fetches `getAllWorksFromOrcid()`, sets `$_SESSION['uid']`, and queues a batch of `bibcite_prep_import_orcid_batch` ops (`bibcite_import_orcid.batch.inc`).
3. **`Process::prepImportOrcid()`** (per work) — pulls the work summary + full work data, maps the type, parses any BibTeX `citation-value` (`parseBibtex()` + `validateBibtexSyntax()`), gathers contributor names (`getOrcidAuthors()`: ORCID contributors → BibTeX authors → person name fallback), pulls external ids (DOI/ISSN/ISBN), and builds a `reference_data` array (`title` truncated to 250 chars, etc.). With author-sync ON it returns the JSON-encoded work; the batch-finished callback stores results in `$_SESSION['works_data_{id}']` and redirects to `/orcid-import/import/{id}`.
4. **`Form\ImportForm`** (`/orcid-import/import/{id}`) — reads `$_SESSION['works_data_{id}']`, renders a fieldset per work with an "ignore" checkbox and a radios list of candidate authors (best guess bolded via `getSimilarStringKey()`: word-overlap then Levenshtein). Submit queues `bibcite_import_orcid_batch` ops.
5. **`Import::importOrcid()`** — dedup via `Process::getExistingPublication()` (by DOI+type, else title+type); create or update the `bibcite_reference`; if `orcid_sync_authors`, resolve/create `bibcite_contributor` entities and link the chosen one to the user (`addContributorToUser`); else attach the reference to `field_references` (`addPublicationToUser`). Batch-finished runs `Process::mergeUserContributors()` and redirects to `/orcid-import/success/{id}`.
6. **`OrcidImportSuccessPageController::build()`** — renders created/updated titles from `$_SESSION` results.

With author-sync OFF, `Process::prepImportOrcid()` imports each work immediately (no author form) and redirects straight to the success page.

## Bio import
- Route `import_bio` (`/orcid-import/import-bio/{uid}`) → `Controller\ImportBio::build($uid)` → service `bibcite_import_orcid.import_user`.
- `ImportUserService::importUser($uid)` — loads the user; returns if `field_periodicity == 'no'`; else `Fetch::getUserFromOrcid()`, writes `field_bio` from `person.biography.content`, sets `field_last_sync` to today, saves.

## Bulk / cron entry points
- `Import::importUsersPublications()` (route `import_all_works`, perm `import all orcid works`) — all active users with an ORCID id (those without references first), logs create/update per work.
- `Import::importUsersBio()` (route `import_all_bios`, perm `import all orcid bio`) — bio import for all active ORCID users.
- Both are also driven by `bibcite_import_orcid_cron` per `orcid_sync_frequency`.

## Contributor helpers (`Process` / `Import`)
`searchContributor()` / `createContributor()` use `bibcite`'s `HumanNameParser` (skips names with >1 comma); `mergeUserContributors()` collapses same-name duplicates to the oldest id and rewrites references via `replaceAuthorId()`; `removeLatexAccents()` converts LaTeX accent escapes to Unicode.

## Drush (`Commands\OrcidImportCommands`)
`bibcite_import_orcid:delete_refs`, `:delete_contribs`, `:delete_all`, `:delete_users_contribs` — destructive bulk cleanup of all `bibcite_reference` / `bibcite_contributor` entities and users' `field_author` links (all with `accessCheck(FALSE)`; intended for admins/CLI only).

## Dead code (not routed)
`Controller\OrcidImporterPageController` references a non-existent `bibcite_import_orcid.importer` service and has no route — ignore it.
