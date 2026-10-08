<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google API PHP Client wraps the official `google/apiclient` library so Drupal modules can store Google account credentials, run the OAuth2 (or service-account) flow, and obtain ready-to-use Google service objects (Calendar, Drive, Gmail, etc.).

---

The module has no end-user feature of its own; it is an integration substrate other modules build on. It defines two account entity types: **Google API Client** (`google_api_client`, a *content* entity holding developer key, client id, client secret, selected services and scopes, plus the per-account OAuth2 access token) for the three-legged user-consent OAuth flow, and **Google API Service Client** (`google_api_service_client`, a *config* entity holding a service-account JSON `auth_config`, services and scopes) for server-to-server access with no interactive consent. Accounts are managed at `/admin/config/services/google_api_client` (and `.../google_api_service_client`); a settings page (`/admin/structure/google_api_client_settings`, the module's `configure` route) has a **Scan Library** button that reads the installed client library to discover available services/scopes and caches them into the `google_api_client.google_api_services` / `google_api_client.google_api_classes` config objects. Authentication happens via an OAuth callback route (`google_api_client/callback`); the access token is refreshed automatically. Code calls the `google_api_client.client` service: `setGoogleApiClient($account)` then `getServiceObjects()` returns instantiated `Google\Service\*` classes to make API requests. Four hooks let other modules alter scopes, alter the OAuth state, gate who may authenticate an account, and react to a Google response. A `d7_gauth` migration imports accounts from the Drupal 7 GAuth module. Everything requires the `administer google api settings` permission.

---

- Store Google OAuth2 client credentials (client id / secret / developer key) as a managed Drupal account entity.
- Authenticate a site to Google via the OAuth2 consent flow and keep the access token refreshed automatically.
- Configure a Google **service account** (JSON key) for server-to-server API calls with no user interaction.
- Obtain a ready `Google\Service\Calendar` object for an authenticated account and read/write calendar events.
- Access Google Drive files from Drupal using an authenticated Google API Client account.
- Send or read Gmail messages through the client library on behalf of an authenticated account.
- Select which Google services/scopes an account is authorized for from the account edit form.
- Discover the services and scopes available in the installed library with the **Scan Library** button.
- Build a custom Google integration module on top of the `google_api_client.client` service.
- Restrict which users/roles may authenticate a given account with `hook_google_api_client_authenticate_account_access()`.
- Add or remove OAuth scopes just before authentication via `hook_google_api_client_account_scopes_alter()`.
- Change the post-authentication redirect or request source via `hook_google_api_client_account_state_alter()`.
- React to arbitrary Google responses (beyond authentication) with `hook_google_api_client_google_response()`.
- Manage multiple distinct Google accounts (e.g. one per Google project) on one site.
- Revoke an account's Google access token from the account's Revoke form.
- Reference a Google API Client account from another entity via the provided EntityReferenceSelection.
- Migrate Drupal 7 GAuth accounts into this module using the `d7_gauth` migration source.
- Provide a shared authentication layer for contrib modules like Google Analytics reporting or Search Console.
- Cache the library's service/class map so allowed service/scope option lists populate the account forms.
- Programmatically create service-account config entities as part of a deployment/config-import.
- Implement "Login with Google" style flows by combining the OAuth account with a custom response handler.
- Keep per-account access tokens in State (not exported config) so credentials do not leak into config sync.
- Enable only the specific Google services a site needs to keep the scope/consent surface minimal.
- Centralize Google credential management for a multi-team site behind a single admin permission.
