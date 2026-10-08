# xntt_example_d7import — usage

An example module for External Entities that installs a ready-made external entity type for reading a
Drupal 7 site's content through its RESTful Web Services (restws) JSON API. It is a learning template:
enable it, look at the `d7import` type, then repoint it at your own Drupal 7 site and extend the field
mapping to match your content.

---

The shipped `d7import` type is read-only and uses a REST storage client (demoed against drupal.org's
`api-d7` endpoint). It maps the D7 node id, title, uuid, language, and a body text field, and shows the
parent module's `locks` feature by pinning the base path, deletion, translation settings, and core
field mappers. Install is blocked if a `d7import` type already exists. To physically import the fetched
records into local Drupal content, combine it with the External Entity Manager synchronization feature.

---

- Display Drupal 7 nodes inside a Drupal 9/10/11 site as entities.
- Learn how to define an external entity type from installable configuration.
- See a REST storage client configured for a Drupal 7 RESTful Web Services endpoint.
- Study JSONPath and direct property mappings against real D7 node JSON.
- Repoint the endpoint URLs at your own Drupal 7 site.
- Add fields matching your D7 content type and map them.
- See the External Entities `locks` feature applied to protect a config-defined type.
- Use as a first step toward importing D7 content with the External Entity Manager.
- Prototype a legacy-site content bridge without writing code.
