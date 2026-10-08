# external_entities_drupalorg — usage

An example module for External Entities that ships ready-made configuration reading the public
drupal.org APIs. It contains no PHP — only optional configuration — and exists to demonstrate a working
REST storage client and a working JSON:API storage client, complete with fields, displays, and Views,
that you can browse and then copy for your own sources.

---

Enabling it installs two read-only external entity types: `drupalorg_rest_issue` (drupal.org issues via
the REST endpoint `api-d7/node.json`, listed at `/drupalorg-rest-issue`) and `drupalorg_jsonapi_module`
(drupal.org modules via JSON:API, listed at `/drupalorg-jsonapi-module`), each with an example Views
display and body/issue fields whose mappings illustrate the parent's field-mapper, property-mapper, and
data-processor pipeline. Depends only on the External Entities module.

---

- See a working REST storage client configuration end to end.
- See a working Drupal JSON:API storage client configuration.
- Browse live drupal.org issues as Drupal entities at `/drupalorg-rest-issue`.
- Browse live drupal.org modules as Drupal entities at `/drupalorg-jsonapi-module`.
- Inspect example field mappings (simple, constant, value-mapping data processor).
- Learn how to map a coded value (issue category/status/priority) to a label.
- Use the shipped example Views as templates for your own listings.
- Clone a type at `/admin/structure/external-entity-types` and repoint it at your API.
- Prototype a decoupled integration without writing a storage client first.
- Teach or demo External Entities with a real public data source.
