Salesforce Integration is a suite that connects Drupal to Salesforce: the base module provides the authenticated REST client, SOQL query helpers, an auth-provider plugin system, Drush commands, and events, while submodules add mapping, push, pull, and auth methods.

---

The base `salesforce` module is the API layer. Its `salesforce.client` service (`RestClient`) talks to the Salesforce REST API — creating/reading/updating objects, running SOQL (`SelectQuery`), and describing sObjects — using an authorization resolved from the **auth-provider plugin** system (`plugin.manager.salesforce.auth_providers`, annotation `@SalesforceAuthProvider`). Each authorization is a `salesforce_auth` config entity that names a provider plugin (e.g. `oauth`, `jwt` from the auth submodules) and its settings; the default provider id is stored in `salesforce.settings` (`salesforce_auth_provider`). That `salesforce.settings` config object also holds suite-wide options: `global_push_limit`, `pull_max_queue_size`, `standalone` (queue endpoint instead of cron), `show_all_objects`, `use_latest` (always use the newest REST API version), `limit_mapped_object_revisions`, and cache lifetimes. Value objects (`SObject`, `SFID`, `SelectQueryResult`) model Salesforce data; a rich event system (auth, REST response, error, pull/push events) lets modules react. Fifteen Drush commands (`salesforce:*`) expose the API from the CLI (query, describe, list objects/providers, refresh/revoke token). Two permissions gate it: `administer salesforce` and `authorize salesforce`. The suite requires external libraries (`lusitanian/oauth`, `firebase/php-jwt`, the force.com SOAP toolkit, `ext-soap`) and Drupal `key`, `address`, `dynamic_entity_reference`, `typed_data`. Real data flow comes from the submodules: `salesforce_mapping` (define maps), `salesforce_push`/`salesforce_pull` (sync directions), `salesforce_jwt`/`salesforce_oauth` (auth), plus logger, soap, address, webform, and example helpers.

---

- Connect a Drupal site to a Salesforce org via OAuth or JWT.
- Call the Salesforce REST API from Drupal using the `salesforce.client` service.
- Run SOQL queries against Salesforce with the `SelectQuery` builder.
- Create, read, update, or upsert Salesforce records programmatically.
- Describe an sObject's fields and record types from Drupal.
- Configure the default Salesforce authorization provider.
- Manage multiple Salesforce authorizations as `salesforce_auth` config entities.
- Query Salesforce objects from the command line with `drush salesforce:query-object`.
- List available Salesforce objects or auth providers via Drush.
- Refresh or revoke a Salesforce OAuth token with Drush.
- Tune the global push queue limit and pull queue max size.
- Switch queue processing to a standalone endpoint instead of cron.
- Always use the latest Salesforce REST API version automatically.
- Limit retained mapped-object revisions to control storage.
- React to Salesforce REST responses/errors via events.
- Build a custom auth provider by implementing a `@SalesforceAuthProvider` plugin.
- Expose all Salesforce objects (including system tables) in the mapping UI when needed.
- Cache Salesforce metadata (object list, descriptions) with configurable lifetimes.
- Integrate CRM data into Drupal content via the mapping submodules.
- Restrict who can administer or authorize Salesforce with dedicated permissions.
- Serve as the foundation for push/pull synchronization between Drupal and Salesforce.
- Use value objects (`SObject`, `SFID`) to work with Salesforce records in code.
