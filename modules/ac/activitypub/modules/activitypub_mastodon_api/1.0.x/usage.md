ActivityPub Mastodon API exposes a Mastodon-compatible REST API so off-the-shelf Mastodon clients can post to and read from a Drupal ActivityPub server.

---

ActivityPub Mastodon API (`activitypub_mastodon_api`) implements a practical subset of the Mastodon client API as core REST resource plugins under `/api/v1` and `/api/v2`: app registration (`/api/v1/apps`), OAuth2 authorization (delegated to Simple OAuth), account verification and lookup, home/notifications/public/direct/bookmark timelines, single statuses and their context, posting/boosting/favouriting statuses, media uploads, search, instance metadata, preferences, favourites, bookmarks and conversations. Payloads are shaped into Mastodon JSON structures by `MastodonApiTrait`. Authentication is OAuth2 (Simple OAuth) through the ActivityPub API submodule; most endpoints require an authenticated user who owns an ActivityPub actor, while the app-registration endpoint is intentionally open so a client can bootstrap credentials. Drush commands assist setup.

---

- Let users connect standard Mastodon apps (mobile/desktop/web) to their Drupal actor.
- Register a client application and receive `client_id`/`client_secret` via `POST /api/v1/apps`.
- Authenticate users with OAuth2 authorization-code flow (Simple OAuth) and long-lived tokens.
- Verify the logged-in account with `GET /api/v1/accounts/verify_credentials`.
- Serve the home timeline, notifications, public timeline, direct messages and bookmarks.
- Return single statuses and their reply context in Mastodon format.
- Post new statuses, boosts (Announce) and favourites (Like) from a client.
- Upload media attachments (v1/v2) for use in statuses.
- Provide instance metadata (v1/v2) so clients can display server name/description/stats.
- Expose account relationships (following/followed) for given handles.
- Map ActivityPub visibility to Mastodon `public`/`unlisted`/`private`/`direct`.
- Cap client-requested timeline limits with a configurable maximum to avoid abuse.
- Cache remote media referenced in statuses through the parent module's media cache.
- Return favourites and bookmarks lists to the client.
- Offer a minimal conversations (DM) view for compatible clients.
- Log unimplemented endpoint calls (via the API submodule) to guide client compatibility work.
- Configure default and maximum timeline entry counts.
- Provide Drush helpers for Mastodon API setup/maintenance.
