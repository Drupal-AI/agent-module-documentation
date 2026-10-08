Gatsby connects a Drupal site to a GatsbyJS front end, adding live preview, incremental/full build triggers, and a "Fastbuilds" incremental-sync log so a decoupled Gatsby site can pull only the content that changed.

---

The module watches content-entity insert/update/delete via `hook_entity_*` and, for the entity types you enable on the settings form, POSTs to the Gatsby preview and incremental-build webhook URLs (`GatsbyPreview::triggerRefresh`). It also records each change as a `gatsby_log_entity` (via `GatsbyEntityLogger`, using `jsonapi_extras`' `EntityToJsonApi::normalize`), which the `gatsby-source-drupal` plugin fetches incrementally from the `/gatsby-fastbuilds/sync/{last_fetch}` endpoint (auth: basic_auth, cookie, or key_auth). Published content produces "build" log records; all changes (including drafts) produce separate "preview" records, kept apart by permission. Editors get an "Open Gatsby Preview" button on moderated node forms (requires Content Moderation) plus an optional in-form iframe preview added as a pseudo-field display component. Configuration lives in `gatsby.settings` (server URL, preview/build/content-sync webhook URLs, path mapping, supported entity types, private-file publishing, self-reference prevention, Fastbuilds log expiration). Three submodules ship with it: `gatsby_extras` (JSON:API menu/link enhancer) and two hidden legacy stubs (`gatsby_fastbuilds`, `gatsby_instantpreview`) whose behavior was folded into the main module. Drush `gatsby:logs:purge` empties the log table.

---

- Trigger a Gatsby Cloud (or Netlify) incremental build automatically whenever published content changes.
- Trigger a full Gatsby rebuild via a build webhook when using the GraphQL source plugin.
- Give content editors an "Open Gatsby Preview" button on node edit forms.
- Show an inline iframe preview of the Gatsby-rendered page inside Drupal by enabling the "Gatsby iframe preview" display component.
- Speed up large-site builds with Fastbuilds so Gatsby only pulls entities changed since its last sync.
- Restrict which entity types (Content, Media, Files, Paragraphs, etc.) are sent to Gatsby.
- Only trigger builds for published content to keep drafts off the production build.
- Preview draft/unpublished content on a development Gatsby server without triggering a production build.
- Map Drupal paths to different Gatsby paths (e.g. `/home` -> `/`) for the preview button and iframe.
- Point preview/build at multiple Gatsby servers by comma-separating the webhook URLs.
- Use Content Sync (Gatsby 4) URLs as an alternative preview mechanism.
- Authenticate the Fastbuilds sync endpoint with the Key Auth module for a dedicated build account.
- Optionally publish private files to the Gatsby build when the referencing content is published.
- Avoid huge Fastbuilds payloads by not storing self-referenced entities of the same type/bundle.
- Automatically expire and prune old Fastbuilds log entities on cron (configurable age and batch size).
- Purge the entire Fastbuilds log manually with `drush gatsby:logs:purge`.
- Send a custom Gatsby Cloud source-plugin header for non-default source plugins.
- Log the JSON payloads sent to the preview server for debugging (non-production only).
- Expose Drupal menus to JSON:API for Gatsby via the `gatsby_extras` submodule's Alias link enhancer.
- Run live preview against a local `gatsby develop` server reached over ngrok during development.
- Integrate with `gatsby-source-drupal` (JSON:API) or `gatsby-source-graphql` (GraphQL) front ends.
