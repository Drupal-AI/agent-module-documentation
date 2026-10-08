Access Unpublished generates time-limited access tokens so anyone holding a special URL — even an anonymous visitor — can preview a single piece of unpublished content, without needing an account.

---

Access Unpublished defines an `access_token` content entity: each token records the host entity type/id, a secret `value`, an optional label, and an `expire` timestamp. On an unpublished entity's edit form the module injects a **"Temporary unpublished access"** section with a Lifetime select, a token label, and a **Generate token** button (AJAX) that creates a token and shows a shareable URL. That URL carries the token in a query parameter — by default `?auHash=<value>` (the parameter name is the configurable `hash_key`). On each request a `TokenGetter` event subscriber reads that parameter, and `hook_entity_access()` grants `view` on the matching unpublished entity when the token exists, is not expired, and the current user holds the per-entity-type/bundle permission (`access_unpublished node article`, etc.) — so an anonymous role can be allowed to view via token, view-only, never edit. Tokens have a default lifetime (`duration`, default 172800 seconds / 2 days; `-1` = unlimited) set at the settings form (`/admin/config/content/access_unpublished`), which also controls the hash key, a default label, optional cron cleanup of expired tokens, cleanup of tokens when content is published, and extra HTTP headers to add on token-accessed pages. All tokens are listed at **Admin → Content → Access Tokens** (`/admin/content/access_token`), where they can be renewed or deleted. A programmatic `AccessTokenManager` service looks up tokens per entity and builds token URLs, and `hook_access_unpublished_duration_options_alter()` lets modules adjust the lifetime choices. It is aimed at proofreaders and content checkers who need a Google-Docs-style private preview link.

---

- Share a private preview URL of an unpublished article with an external proofreader who has no account.
- Let an editor generate a time-limited "view this draft" link straight from the node edit form.
- Give a client a temporary link to review unpublished content before it goes live.
- Set a token to expire in 1 day, 2 days, 4 days, 1 week, or 2 weeks from the Lifetime select.
- Create an unlimited (never-expiring) token by choosing the Unlimited lifetime (`-1`).
- Change the default token lifetime site-wide via the `duration` setting.
- Rename the URL query parameter from `auHash` to a custom `hash_key` for obscurity.
- Allow the anonymous role to view unpublished nodes only when they hold a valid token, via the `access_unpublished node` permission.
- Grant token-based preview per content type/bundle (e.g. only `article`, not `page`).
- Review every issued token, its host content, owner, and expiry at Admin → Content → Access Tokens.
- Renew an expired token from the token overview or the entity form to re-share the same link.
- Delete a token to instantly revoke a shared preview URL.
- Automatically delete tokens for a piece of content the moment it is published (`cleanup_tokens_on_publish`).
- Have cron purge expired tokens older than a configured period (`cleanup_expired_tokens`).
- Add custom HTTP headers (e.g. `X-Robots-Tag: noindex`) on pages viewed through a token to keep drafts out of search engines.
- Preview the latest forward/pending revision of moderated content through a token (Content Moderation integration).
- Look up the active token for an entity in code with `AccessTokenManager::getActiveAccessToken()`.
- Build a shareable token URL programmatically with `AccessTokenManager::getAccessTokenUrl()`.
- Create an access token in custom code by saving an `access_token` entity with entity_type/entity_id/expire.
- Add or remove lifetime options (e.g. a "4 weeks" choice) via `hook_access_unpublished_duration_options_alter()`.
- Restrict who can renew or delete tokens with the `renew token` and `delete token` permissions.
- Gate the token overview page behind the `access tokens overview` permission.
- Let content checkers proofread drafts without you creating user accounts for them.
- Deploy access-unpublished settings (hash key, lifetime, cleanup) as configuration across environments.
- Avoid Workspaces conflicts — the widget disables itself and warns when editing inside an active workspace.
- Expose access tokens through GraphQL to build a decoupled preview flow (test-only GraphQL data producers).
