ActivityPub API is a helper submodule that supplies the OAuth2 + REST foundation other modules use to expose a client API for a Drupal ActivityPub server.

---

ActivityPub API (`activitypub_api`) does not expose end-user API endpoints itself; it provides reusable building blocks: a `ResourceBase` subclass (`ActivityPubApiRestBase`) with a custom access check requiring the current user to be authenticated *and* to own an ActivityPub actor, traits for raw multipart/JSON request handling and file uploads, OAuth2 consumer/token creation and deletion helpers (via Simple OAuth), an HTTP middleware that lets clients send the `/oauth/token` body as JSON, and an API response service. It adds a per-user API management screen, a settings form (upload directory, allowed extensions, instance metadata, logging), and grants authenticated users the permissions needed to register OAuth clients and manage their own tokens. The Mastodon API submodule depends on it.

---

- Provide the shared REST base class for ActivityPub client-API resources.
- Require API callers to be an authenticated user who owns an ActivityPub actor.
- Register OAuth2 consumers (client apps) and issue client credentials via Simple OAuth.
- Let users view and revoke their own OAuth tokens/consumers at `/user/{user}/activitypub/api`.
- Delete an OAuth token (and its orphaned consumer) through a confirm form.
- Accept OAuth `/oauth/token` requests sent as `application/json` (converted to form-encoded).
- Handle multipart/form-data and JSON request bodies on API routes (`_content_type_format: form|json`).
- Validate and store uploaded media (image-only, size/extension limits) into a configurable directory.
- Configure the API upload directory, max file size and allowed extensions.
- Set instance name/description/email returned by API instance endpoints.
- Optionally log incoming API payloads, responses and calls to unimplemented endpoints for debugging.
- Return standardized JSON responses (`ActivityPubApiResponse`) with correct status codes.
- Emit an `ApiEntityPreSaveEvent` so other code can alter entities created from API calls.
- Serve as the dependency layer for a Mastodon-compatible API or any custom ActivityPub client API.
- Grant authenticated users `grant simple_oauth codes` and `manage activitypub api connections` on install.
