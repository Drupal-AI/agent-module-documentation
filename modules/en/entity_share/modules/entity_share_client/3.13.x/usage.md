Entity Share Client is the **client side** of Entity Share: enable it on the consuming site, define a **Remote** config entity (`remote`) pointing at a server's URL + auth, and pull content from its channels — with **Import config** entities (`import_config`) controlling how pulled entities are created and updated.

---

Entity Share Client is a submodule of **entity_share**. It defines the `remote` config entity (a server site's base `url` plus an `auth` mapping) at **Config → Web services → Entity Share → Remotes** (`entity.remote.collection`), and the `import_config` config entity that assembles an ordered pipeline of **import-processor** plugins governing import behavior (policy, revisions, physical files, embedded references, path aliases, language fallback, and more). Authentication to a remote uses pluggable **client authorization** plugins — `anonymous`, `basic_auth`, `header`, and `oauth` — with credentials stored via the Key module. Content is pulled through the **Pull form** at **Admin → Content → Entity Share** (`/admin/content/entity_share`) or from the command line via the module's Drush commands. It also tracks each imported entity with an `entity_import_status` content entity. It depends on core JSON:API and the base `entity_share` module, and provides three plugin types (`import_processor`, `client_authorization`, `import_policy`) plus permissions such as `administer_remote_entity`, `administer_import_config_entity`, and `entity_share_client_pull_content`.

---

- Pull content from a remote Drupal site's Entity Share channels.
- Register a remote hub by URL and authorization method.
- Authenticate to a remote with HTTP Basic, a request header/API key, or OAuth2.
- Store remote credentials securely through the Key module.
- Import Article (or any bundle) nodes from a staging site to production.
- Control publish/update behavior of pulled content with an import policy.
- Build an import-processor pipeline per site with `import_config` entities.
- Import embedded/referenced entities recursively up to a max depth.
- Import physical files and media alongside referenced entities.
- Preserve or enforce revisions and translation-affected flags on import.
- Import path aliases and rewrite internal links to local content.
- Provide a language fallback when a translation is missing.
- Skip already-imported entities to make repeated pulls cheap.
- Pull content interactively via the admin Pull form.
- Run pulls from the CLI/cron with the client Drush commands.
- Track import state per entity via `entity_import_status`.
- Update the import policy of already-imported content in bulk.
- Write a custom import-processor plugin to transform pulled data.
- Write a custom client-authorization plugin for a bespoke auth scheme.
- Make one site a client of several different remote hubs.
- Combine with Entity Share Async to queue large imports.
- Combine with Entity Share Lock to protect imported content from local edits.
