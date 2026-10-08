Adds Solr administration tasks to Search API Solr — uploading config sets, reloading cores/collections, deleting collections, and running field analysis directly from Drupal.

---

Search API Solr Admin extends the base module with operational tooling that talks to Solr's admin and Collections APIs. From the Search API server screens it lets privileged users push the generated Solr config set to the server, reload a core/collection so new configuration takes effect, delete collections, and clear all documents. It also provides a **field analysis** screen to see exactly how Solr tokenizes and filters a given value against a field type, which is invaluable when debugging why a query does or doesn't match. The tasks are exposed both as local actions in the UI and as Drush commands (`solr-reload`, `solr-delete-collection`, `solr-delete-all`, `solr-upload-conf`). Access is gated by two permissions: *Execute Solr admin task* and *Perform field analysis*. It is optional but very handy on SolrCloud setups where you would otherwise use the raw Collections API by hand.

---

- Upload a generated Solr config set to the server from Drupal.
- Reload a Solr core or SolrCloud collection after config changes.
- Delete a Solr collection via the Collections API.
- Delete/clear all documents from a Solr index.
- Run field analysis to see how Solr tokenizes a value.
- Debug why a search term does not match a field type.
- Push config to SolrCloud without manual `solrctl`/curl calls.
- Automate config-set upload in CI with `drush solr-upload-conf`.
- Reload collections in a deploy pipeline via Drush.
- Grant limited admin rights with the "Execute Solr admin task" permission.
- Grant analysis-only rights with "Perform field analysis".
- Verify analyzers behave the same at index and query time.
- Tear down a test collection quickly during development.
- Re-create a collection after schema changes.
- Inspect stemming/synonym behavior for a language field type.
- Perform routine Solr housekeeping without shell access to Solr.
- Trigger a reload after reinstalling field types.
- Manage multiple servers' collections from one admin UI.
- Speed up local dev by clearing an index between test runs.
- Provide site admins a safe UI instead of raw Solr admin endpoints.
