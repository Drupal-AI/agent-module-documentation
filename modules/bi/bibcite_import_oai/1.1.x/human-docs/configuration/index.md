# Configuration

Configuring Bibcite Import OAI has two parts: telling it which OAI-PMH
repository collections to harvest, then running the import (once, or nightly via
cron).

## Open the settings form

1. Make sure the module and Bibcite are enabled and that you have the OAI import
   permission (see [Installation](../installation/index.md)).
2. Go to **`/admin/bibcite_import_oai/config`**
   (`bibcite_import_oai.admin_settings`).

## Add repository URLs

On the settings form you provide one or more OAI **ListRecords** URLs — each one
points at a collection ("set") of records in a repository:

1. Paste an OAI ListRecords URL into the URL field. A typical URL looks like:

   ```
   https://your.repo/oai/openaire?verb=ListRecords&metadataPrefix=oai_dc&set=com_10362_410
   ```

2. Use **Add another URL** to add more fields and harvest from several
   collections.
3. To discover the available set identifiers for a repository, visit its
   *ListSets* interface — for example
   `https://your.repo/oai/openaire?verb=ListSets` — then copy the corresponding
   Records (ListRecords) URL for the set you want.
4. Optionally tick **Update daily** to re-harvest every configured URL each
   night via cron.
5. Click **Save**.

Each URL is validated as a well-formed URL (`FILTER_VALIDATE_URL`) when you
save. The settings are stored in Drupal configuration
(`bibcite_import_oai.settings`: the list of URLs and the daily-update flag).

## Run the import

You can start an import two ways:

- **From the admin UI:** go to **`/admin/oai-import/import`**, tick the
  configured URLs you want to import, and press **Import**. The import runs as a
  Drupal batch, so large repositories are processed in chunks with a progress
  bar.
- **From the command line:** run

  ```bash
  drush oai-import:import --url="https://your.repo/oai/openaire?verb=ListRecords&metadataPrefix=oai_dc&set=..."
  ```

  With DDEV, prefix it: `ddev drush oai-import:import --url="…"`.

## What gets created

For each `oai_dc` record harvested, the module creates:

- a **`bibcite_reference`** entity (the citation itself), with Dublin Core
  fields mapped onto Bibcite Reference fields;
- **`bibcite_contributor`** entities for the record's authors; and
- **`bibcite_keyword`** entities for the record's subjects.

Contributors and keywords are de-duplicated: if a matching entity already
exists, it is reused rather than created again.

## Scheduled (nightly) harvests

If you ticked **Update daily**, cron re-imports all configured URLs on each cron
run, so new publications in your repositories appear automatically. Make sure
Drupal cron is running regularly (via your server's cron or Drupal's built-in
scheduler). The last cron import timestamp is recorded in Drupal state.

## Notes on the fetch

- cURL follows redirects and uses a 600-second timeout.
- TLS peer verification is left at cURL's default (enabled), so HTTPS endpoints
  are verified normally.
- Only admin-configured URLs are ever fetched — there is no public,
  request-supplied fetch URL.
