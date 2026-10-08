<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibcite Import OAI harvests bibliography references from OAI-PMH repositories (such as DSpace/OpenAIRE) and creates Bibcite Reference entities.
---
The module solves the problem of populating a Bibcite bibliography from an institutional repository. An administrator stores one or more OAI ListRecords URLs (e.g. `https://repo/oai/openaire?verb=ListRecords&metadataPrefix=oai_dc&set=com_10362_410`) on the configuration form, then runs an import that fetches each URL server-side with cURL, parses the returned `oai_dc` XML, and creates `bibcite_reference` entities plus referenced contributor and keyword entities. An optional "Update daily" flag re-runs the import from cron.

Operationally the import is triggered from an admin form or the `oai-import:import` Drush command. cURL uses default TLS verification (peer verification is left on) and a 600-second timeout, and follows redirects. The configured URLs are admin-supplied and validated with `FILTER_VALIDATE_URL`; there is no user-facing endpoint that fetches an arbitrary request URL, so the server-side fetch surface is admin-only. Note the routing file references permissions by their human title rather than machine name (`import from oai` is the only declared permission), so the admin/config/import routes require permission strings that are not actually declared — access fails closed until corrected.

Typical setup: enable the module and Bibcite, grant the OAI import permission, add repository ListRecords URLs on the config page, optionally enable nightly cron updates, then run the import.
---
- Import bibliography references from a DSpace repository over OAI-PMH.
- Harvest OpenAIRE-formatted `oai_dc` records into Bibcite.
- Add one or more OAI ListRecords collection URLs on the settings form.
- Add another URL field dynamically to import from several collections.
- Validate that each configured URL is well-formed before saving.
- Enable "Update daily" to refresh publications from all sources nightly via cron.
- Trigger a manual import from `/admin/oai-import/import`.
- Select which configured URLs to import in a given run.
- Run an import from the command line with `drush oai-import:import --url="..."`.
- Automatically create Bibcite Contributor entities for record authors.
- Automatically create Bibcite Keyword entities for record subjects.
- De-duplicate contributors/keywords by matching existing entities before creating.
- Map OAI Dublin Core fields onto Bibcite Reference fields.
- Populate a bibliography for an institutional repository mirror.
- Schedule recurring harvests so new repository publications appear automatically.
- Reach a DSpace `verb=ListSets` interface to discover set identifiers, then copy the Records URL.
- Restrict who can run imports via the OAI import permission.
- Batch-process large repositories using Drupal's batch API.
- Review the last cron import timestamp stored in state.
- Use as the ingestion side of a citation/publications listing built on Bibcite.
