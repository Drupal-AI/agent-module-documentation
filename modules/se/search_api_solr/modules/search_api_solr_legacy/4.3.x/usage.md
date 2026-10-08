Provides SolrConnector plugins and config that let Search API Solr talk to old, otherwise-unsupported Apache Solr versions (3.6, 4.5+, and 5.x).

---

Modern Search API Solr targets recent Solr releases, but many established installations still run legacy Solr servers that cannot be upgraded easily. This submodule closes that gap by shipping a **Solr 3.6 connector** (`src/Plugin/SolrConnector/Solr36Connector.php`) and related connectors plus an event subscriber (`SearchApiSolrSubscriber`) that adjust the generated requests and config to what these old servers understand. It also bundles matching legacy Solr config templates under `solr-conf-templates/` so you can build a compatible config set. Select the legacy connector on the Search API server form just like any other connector. It is intended purely as a compatibility bridge; new sites should run a current Solr version and skip this module. Depends only on `search_api_solr`.

---

- Connect Search API to a legacy Solr 3.6 server.
- Support Solr 4.5+ servers that the base module no longer targets.
- Support Solr 5.x servers during a phased upgrade.
- Keep an existing search working while planning a Solr upgrade.
- Generate a legacy-compatible Solr config set from the bundled templates.
- Choose the Solr 3.6 connector on the server form.
- Avoid re-architecting search when stuck on old infrastructure.
- Bridge a hosted Solr provider still on an older version.
- Run integration tests against legacy Solr endpoints.
- Adjust request format for old Solr via the event subscriber.
- Migrate content gradually off legacy Solr.
- Maintain a site on a Solr version without security updates (short-term).
- Reuse existing legacy Solr cores with Drupal.
- Provide compatibility for enterprise Solr clusters pinned to old versions.
- Test query behavior differences between Solr generations.
- Deploy to environments where Solr upgrades are blocked by policy.
- Serve search from an appliance shipping an old Solr.
- Keep a decoupled front end running against legacy Solr.
- Validate config-set compatibility before upgrading Solr.
- Ease vendor lock-in during infrastructure transitions.
