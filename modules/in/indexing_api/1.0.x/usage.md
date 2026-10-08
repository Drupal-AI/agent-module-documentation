<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Indexing API integrates a Drupal site with Google's Indexing API: whenever a configured content entity is inserted, updated, or deleted, it sends a `URL_UPDATED`/`URL_DELETED` urlNotification so Google re-crawls that URL.

Configuration lives at `/admin/config/services/indexing-api` (`administer google index api`). The settings form stores, in Drupal State, the site hostname, the API endpoint (default `https://indexing.googleapis.com/v3/urlNotifications:publish`), the OAuth scope (`https://www.googleapis.com/auth/indexing`), and a **managed JSON service-account key file uploaded to `private://indexing-api/`**. A per-entity-type "assign" modal (`/admin/config/services/indexing-api/entity-assign/{entity_type_id}`) chooses which bundles are indexable; only content entity types with a canonical URL that are not internal/unsupported are offered. On entity CRUD, `IndexService::performRequest()` builds the Google API `Client` from the uploaded key, authorizes, and POSTs the notification for `hostname + alias`; non-200 responses are logged.

Security posture: both routes are permission-gated and there is **no** anonymous, public, or index-serving endpoint — the module only reaches out to Google's API. The service-account key is stored in the private filesystem. Note the declared permission in `indexing_api.permissions.yml` is `configure indexing api`, but the routes require `administer google index api` (an undeclared permission) — this is fail-closed (only user 1 can reach the forms until a permission of that machine name is granted) rather than an exposure. The Google endpoint/scope are admin-configured (not request-derived) and TLS is left at library defaults, so there is no SSRF or disabled-TLS surface for anonymous users.
---
Sends Google Indexing API url-notifications when configured content entities change, so Google re-crawls their URLs.
---
- Notify Google when a node is published
- Notify Google when content is updated
- Notify Google to drop a URL when content is deleted
- Choose which entity types are indexable
- Choose which bundles per entity type are indexable
- Upload a Google service-account JSON key securely (private://)
- Set the site hostname used to build notified URLs
- Override the Google Indexing API endpoint
- Set the OAuth scope for the Indexing API
- Restrict indexing config to privileged users
- Use path aliases in the notified URLs
- Skip unsupported entity types (comment, block_content, etc.)
- Only notify for entities that have a canonical URL
- Log success/failure of each API request
- Speed up Google discovery of new/changed pages
- Automate index refresh without manual Search Console submits
