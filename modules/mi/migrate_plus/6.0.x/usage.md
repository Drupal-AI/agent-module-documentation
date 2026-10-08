Migrate Plus extends Drupal's core Migrate API with configuration-entity migrations, migration groups, a pluggable `url` source for fetching remote data (JSON, XML, SOAP, CSV over HTTP/file), and a large library of extra process plugins.

---

Where core Migrate provides only plugin-derived migrations, Migrate Plus adds `migration` and `migration_group` **config entities** so migrations can be created, exported, and deployed as YAML configuration rather than code. Groups let you share common source/destination configuration across many migrations and run them as a set. Its headline feature is the `url` source plugin, which pulls data from remote endpoints using three pluggable layers: **data fetchers** (`http`, `file`), **data parsers** (`json`, `xml`, `simple_xml`, `soap`), and **authentication** plugins (`basic`, `digest`, `ntlm`, `oauth2`). It ships dozens of additional process plugins — DOM manipulation, entity lookup/generate, string operations, array handling, skip-on-value, and more — plus a `table` source and destination for arbitrary database tables. A `MigratePrepareRowEvent` lets modules react as each source row is read. Together these make it the de-facto foundation for importing content from external APIs and feeds, and it is a near-universal dependency of custom migration projects.

---

- Define a migration as exportable YAML config instead of a plugin class.
- Import content from a remote JSON API endpoint via the `url` source.
- Import from an XML or RSS/Atom feed with the `xml`/`simple_xml` parser.
- Consume a SOAP web service as a migration source.
- Fetch source data over HTTP with custom headers and Guzzle request options.
- Read source files from the local filesystem with the `file` data fetcher.
- Authenticate to a protected API using OAuth2, Basic, Digest, or NTLM.
- Group related migrations and run them together as a batch.
- Share common configuration (source constants, tags) across a group of migrations.
- Migrate rows straight into an arbitrary database table with the `table` destination.
- Use a database `table` as a migration source.
- Look up an existing entity by field value with `entity_lookup`.
- Create a referenced entity on the fly with `entity_generate`.
- Extract or transform HTML using the DOM process plugins (`dom`, `dom_select`, `dom_str_replace`).
- Skip a row or value conditionally with `skip_on_value`.
- Run arbitrary string replacements with `str_replace`/`preg_match`.
- Flatten or reshape arrays with `array_pop`, `array_shift`, `merge`, `transpose`.
- Store a file from a blob column with `file_blob`.
- Call a service method as a process step with the `service` plugin.
- Reference migrations by their declared ID rather than a deriver prefix.
- React to each source row via the `MigratePrepareRowEvent` in custom code.
- Migrate menu links, taxonomy terms, users, nodes and comments from a legacy DB (see the beer example).
- Deploy a full migration project between environments as configuration.
- Add a custom data parser plugin for a proprietary source format.
- Add a custom authentication plugin for a bespoke API sign-in scheme.
- Import a product catalog from JSON into content types (see the JSON example).
- Order dependent migrations with `migration_dependencies`.
