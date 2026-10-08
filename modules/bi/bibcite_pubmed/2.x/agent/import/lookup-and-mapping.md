<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PubMed lookup form, import flow & mapping

## Install / enable
`drush en bibcite_pubmed`. Pulls in `bibcite` + `bibcite_entity`. On install, config
`bibcite_entity.mapping.pubmed` (and `.pubmed_id`) is imported from `config/install/`. No settings
page; the module has no `configure` route and defines no permissions of its own.

## Route & access
`bibcite_pubmed.lookup` (`bibcite_pubmed.routing.yml`):
- path `/admin/content/bibcite/reference/pmlookup`, `_form: PubmedLookupForm`, title `PubMed lookup`.
- requirement `_permission: 'administer bibcite'` — the standard bibcite admin permission gates it.
- Surfaced via `bibcite_pubmed.links.action.yml` (action link on `entity.bibcite_reference.collection`)
  and `bibcite_pubmed.links.menu.yml` (menu link under the same collection).

## Lookup form flow (`Form/PubmedLookupForm`)
1. `buildForm` renders one required `pmid` textfield (maxlength 255) and a submit button.
2. `validateForm` calls `pubmedClient->fetch($pmid)`. If `bibcite_import` is enabled it reads
   `bibcite_import.settings` for `contributor_deduplication` / `keyword_deduplication` into the
   denormalize context (else empty context). It then `serializer->decode($data, 'pubmed')` and
   `denormalize(reset($decoded), Reference::class, 'pubmed', $context)`, storing the built entity in the
   form state. Any exception becomes a form error on the `pmid` field.
3. `submitForm` saves the entity into the private tempstore
   `tempstore.private`→`bibcite_pubmed_lookup` keyed by current user id, then redirects to
   `entity.bibcite_reference.add_form` for the entity's bundle.
4. `hook_bibcite_reference_prepare_form` (in `.module`) runs on that add form: if the tempstore holds a
   `ReferenceInterface` for the current user, it copies every field value onto the new reference and
   deletes the tempstore entry. The editor reviews and saves.

## Bulk import
Bulk import uses the `pubmed_id` format (see `agent/api/pubmed-client.md`): a newline-separated PMID
list is chunked (50/request) and fetched, so the same mapping applies. Drive it through the bibcite
import UI/pipeline that consumes registered formats.

## Field & type mapping — `bibcite_entity.mapping.pubmed`
Defined in `config/install/bibcite_entity.mapping.pubmed.yml`. `types:` maps PubMed publication types
to bibcite reference-type machine names (only `Journal Article → journal_article` is mapped by default;
unmapped types fall back to the normalizer's `defaultType`). `fields:` maps encoder output keys to
Reference field names, e.g. `ArticleTitle→title`, `AuthorList→author`, `KeywordList→keywords`,
`Abstract→bibcite_abst_e`, `Year→bibcite_year`, `JournalTitle→bibcite_secondary_title`,
`Volume→bibcite_volume`, `Issue→bibcite_issue`, `Pagination→bibcite_pages`, `PubDate→bibcite_date`,
`Language→bibcite_lang`, `ISSN→bibcite_issn`, `url→bibcite_custom1`, `doi→bibcite_doi`,
`ISOAbbreviation→bibcite_alternate_title`, `PMCID→bibcite_pmcid`, `PMID→bibcite_pmid`.

Override the mapping to fit a custom reference-type setup by editing this config object (config
override / import). The `pubmed` format declaration (types + field list) also lives in
`bibcite_pubmed.bibcite_format.yml`.

## Install/uninstall hooks (`.install`)
- `hook_uninstall` deletes `bibcite_entity.mapping.pubmed`.
- `update_9001` adds the `PMCID → bibcite_pmcid` field to the mapping (for sites installed before it).
