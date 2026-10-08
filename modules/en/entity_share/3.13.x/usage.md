Entity Share shares content entities between separate Drupal sites over JSON:API: one site exposes content as a **server** (Channel config entities), another consumes it as a **client** (Remote config entities) and pulls entities in.

---

Entity Share turns Drupal's core JSON:API into a content-staging / syndication pipeline between two or more independent Drupal sites. The base `entity_share` module is essentially a shell: it only adds an admin landing page (Admin → Config → Web services → Entity Share) and an access permission — the real functionality ships in submodules. Enable **Entity Share Server** on the site holding the content to define **Channel** config entities (`channel`), each of which selects an entity type + bundle + language and optional JSON:API filters/sorts/groups, and exposes that set as a JSON:API collection with access control by role/user/permission. Enable **Entity Share Client** on the consuming site to define **Remote** config entities (`remote`) pointing at a server's URL with an authorization plugin (Anonymous, HTTP Basic, request header, or OAuth2), plus **Import config** entities (`import_config`) that assemble a pipeline of import-processor plugins controlling how pulled entities are created/updated (policy, revisions, physical files, embedded references, path aliases, language fallback, etc.). Content is pulled through the client Pull form or via Drush. Optional submodules add asynchronous/queued import (`entity_share_async`), locking of imported content against local edits (`entity_share_lock`), and a local/remote diff view (`entity_share_diff`). Because the transport is standard JSON:API, no custom endpoints or migration classes are needed — a site can be both client and server. Note that a real end-to-end sync needs two sites; on a single site you can still create and inspect the Channel/Remote config entities.

---

- Push editorial content from an authoring/staging Drupal site to one or more live sites.
- Syndicate shared content (news, press releases) from a central hub to many satellite sites.
- Keep a content type in sync across a multisite fleet without a shared database.
- Migrate content between two Drupal sites over HTTP using JSON:API instead of migrate classes.
- Expose only specific bundles/languages of content through Channel config entities.
- Restrict a channel to certain roles, users, or a permission for secure sharing.
- Filter a channel with JSON:API conditions (e.g. only published, or a taxonomy term).
- Sort and group channel results for predictable pull ordering.
- Pull content from a remote site through the client Pull form in the admin UI.
- Authenticate to a remote server with HTTP Basic, a request header/API key, or OAuth2.
- Store remote credentials securely via the Key module integration.
- Control create/update behavior of pulled entities with import-processor pipelines (Import config).
- Import embedded/referenced entities recursively up to a configured depth.
- Import physical files (images, documents) alongside referenced media/file entities.
- Preserve or enforce revisions and translation-affected flags on import.
- Apply an import policy so editors can review before content is published locally.
- Import path aliases and rewrite internal links to point at local content.
- Provide a language fallback when a translation is missing on the client.
- Queue large imports asynchronously with the Entity Share Async submodule.
- Lock imported content on the client so local editors do not overwrite synced content (Entity Share Lock).
- Show a field-by-field diff of local vs remote before importing (Entity Share Diff).
- Run pulls from the command line / cron with the client Drush commands.
- Make one site simultaneously a client of one hub and a server for another.
- Reuse existing JSON:API access and field support rather than building custom REST resources.
