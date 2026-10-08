Pushes an entity and its related content as JSON to another configured Drupal site over Basic Auth.

---

Entity IO Push adds a "Deploy" tab to supported content entities (node, comment, taxonomy term,
user, media, block) that sends the entity and all of its related content as JSON to a remote Drupal
site configured on the settings form. The remote site runs this submodule too and exposes a receiver
endpoint (`/entity-io/push/importer`) that validates and imports the pushed JSON using Entity IO's
importer. Server definitions (URL, user, password, custom headers) are stored in configuration, and
the receiver endpoint is gated by a restricted "receive JSON" permission plus HTTP Basic Auth.
Requires the core `basic_auth` module.

---

- Deploy a single node from staging to production with one click.
- Push a taxonomy term and its fields to another environment.
- Sync a user account to a partner site.
- Deploy a media item (with its file) to a remote Drupal instance.
- Push a custom block's content to another site.
- Deploy a comment to a remote site.
- Configure multiple target servers and choose one per deploy.
- Attach custom auth headers to push requests.
- Send compressed (gz/br) payloads to reduce transfer size.
- Keep two Drupal sites' content in sync via repeated pushes.
- Receive pushed JSON on the target site through the importer endpoint.
- Restrict who can receive pushes with a dedicated permission granted only to service accounts.
- Grant per-entity-type deploy permissions to specific editors.
- Promote reviewed content from an authoring site to a public site.
- Integrate content deployment into a multi-environment release workflow.
