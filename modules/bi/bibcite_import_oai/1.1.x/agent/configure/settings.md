<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Bibcite Import OAI

## Add repository URLs
1. Enable the module and `bibcite`, grant the OAI import permission.
2. Go to `/admin/bibcite_import_oai/config`.
3. Paste OAI ListRecords URLs, one per field, using "Add another URL" for more.
   - Discover sets at `https://your.repo/oai/openaire?verb=ListSets`.
   - Copy the "Records" URL, e.g. `.../oai/openaire?verb=ListRecords&metadataPrefix=oai_dc&set=com_10362_410`.
4. Optionally tick **Update daily** to harvest every night via cron.
5. Save (config is stored in `bibcite_import_oai.settings:url` and `use_cron`).

## Run the import
- UI: `/admin/oai-import/import`, tick the URLs to import, press **Import** (runs as a Drupal batch).
- CLI: `drush oai-import:import --url="https://your.repo/oai/openaire?verb=ListRecords&metadataPrefix=oai_dc&set=..."`

## What gets created
- `bibcite_reference` entities from each `oai_dc` record.
- `bibcite_contributor` and `bibcite_keyword` entities, reused when an existing match is found.

## Notes
- URLs are validated with `FILTER_VALIDATE_URL` on save.
- cURL follows redirects, 600s timeout, default TLS verification.
