REST UI provides an administrative user interface for enabling, disabling, and configuring the REST resources exposed by Drupal core's RESTful Web Services module, so you no longer have to hand-edit `rest.settings` configuration YAML.

---

Drupal core's REST module lets you expose entities and other resources over a RESTful API, but out of the box it offers no admin screen — you must edit the `rest.settings` configuration by hand or via a contrib helper. REST UI fills that gap with a screen at **Configuration → Web Services → REST** that lists every available REST resource plugin and lets you enable or disable each one. For an enabled resource you can pick the HTTP methods it supports (GET, POST, PATCH, DELETE), and for each method choose the accepted serialization formats (`json`, `xml`, `hal_json`, …) and the authentication providers (`cookie`, `basic_auth`, OAuth, etc.). All of this is stored back into the standard core `rest.settings` config, so REST UI is purely a management convenience — it defines no resources or storage of its own. It relies on core's `administer rest resources` permission to gate access. The module is a small, stable, near-ubiquitous companion for anyone building a decoupled or headless Drupal site or exposing content to external systems.

---

- Enable a REST resource (e.g. Content/node) without editing YAML by hand.
- Disable a REST resource you no longer want exposed.
- Restrict a resource to read-only by enabling only the GET method.
- Allow content creation over REST by enabling the POST method on a resource.
- Enable PATCH so external clients can update entities via the API.
- Enable DELETE to allow remote deletion of entities.
- Choose which serialization formats (`json`, `xml`, `hal_json`) a method accepts.
- Limit a resource to JSON only for a lightweight decoupled front end.
- Select which authentication providers (`cookie`, `basic_auth`) guard each method.
- Add `basic_auth` authentication to an API consumed by a non-browser client.
- Expose the user registration REST resource for a headless signup flow.
- Configure the database log (`dblog`) REST resource for remote log access.
- Review at a glance which resources are currently enabled across the site.
- Audit the HTTP methods, formats, and auth of every enabled resource on one screen.
- Set up a decoupled React/Vue front end that reads content over REST.
- Provide a mobile app with a JSON API to Drupal content.
- Prototype an API quickly during development without config-editing tooling.
- Hand REST configuration to a site builder who is not comfortable editing YAML.
- Tighten security by disabling unused methods and formats on exposed resources.
- Prepare `rest.settings` config that is then exported and deployed between environments.
- Enable core's views REST export display support alongside resource configuration.
- Troubleshoot a 406/415 API error by confirming the accepted formats for a method.
- Confirm which authentication a failing API call requires before debugging the client.
