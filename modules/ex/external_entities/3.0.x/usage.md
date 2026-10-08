# External Entities — usage

External Entities lets you expose remote data sources — REST/JSON APIs, SQL databases, files, and
anything a storage-client plugin can read — as first-class Drupal content entities. You define an
`external_entity_type`, point it at one or more storage clients, and map the raw source data onto
Drupal fields. Records are then fetched live and behave like nodes (fields, view modes, references,
Views, path aliases) without ever being copied into Drupal's database; where the source allows it,
you can also create, edit, and delete remote records from Drupal.

---

Under the hood a type chooses a data aggregator (`single`, or `group`/`horizontal`/`vertical` to
combine multiple sources) that owns storage clients, and a chain of field mappers → property mappers
→ data processors that translate source values to and from Drupal field properties. The module defines
five pluggable extension points (storage client, data aggregator, field mapper, property mapper, data
processor), ships REST/JSON:API/Files storage clients and a broad set of mappers and processors, and
adds "annotations" (a local content entity referenced from each external entity) for storing extra
Drupal-only data such as comments or workflow state. Companion submodules add SQL sources, Views
integration, file/image field support, and pathauto aliases.

---

- Show a remote REST API's records as a browsable Drupal entity type.
- Turn rows of an external SQL database (via the `xnttsql` submodule) into entities.
- Read entities from JSON files or a directory of files on disk (Files storage client).
- Pull Drupal.org issues or modules into a site using the shipped example configs.
- Create, edit, and delete remote records from Drupal when the source is writable.
- Combine several APIs into one entity ("join"/vertical aggregation) or into one list (horizontal).
- Map nested/wrapped JSON responses to fields with JSONPath and the Simple property mapper.
- Cast source strings to typed field values with data processors (boolean, date/time, numeric, hash).
- Add locally-stored fields (comments, notes, workflow) to remote records via annotations.
- Attach file and image fields backed by remote URLs (via the `xntt_file_field` submodule).
- Display external entities in Views (via the `xntt_views` submodule).
- Generate URL aliases for external entities with Pathauto (via `external_entities_pathauto`).
- Authenticate to APIs with bearer tokens, custom headers, or a query-string API key.
- Rate-limit REST calls per endpoint to respect third-party API quotas.
- Page through large APIs with configurable page-number or offset pagers.
- Cache fetched entities for a configurable max age to reduce remote calls.
- Reference external entities from nodes just like any other entity reference.
- Build a decoupled "content hub" that reads from a legacy or third-party system of record.
- Migrate/consume Drupal 7 REST content into a Drupal 10/11 site (`xntt_example_d7import`).
- Restrict who can view/create/edit/delete each external entity type with per-type permissions.
- Lock a type's fields, display, or editing so downstream editors cannot change the mapping.
- Extend the module with your own storage client for any bespoke API or data store.
