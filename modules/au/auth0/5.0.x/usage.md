<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auth0 turns Drupal's login into an Auth0-hosted Single Sign-On flow: it replaces `/user/login` with a redirect to Auth0's Universal Login, handles the OAuth/OIDC callback, and provisions/logs in a matching Drupal user via ExternalAuth, with optional role/claim mapping from Auth0.

---

The module wraps the official `auth0/auth0-php` v8 SDK. It overrides the core `/user/login`, `/user/logout` and adds `/auth0/callback` routes (all `_access: TRUE`, plus a `/user/login/legacy` fallback to Drupal's native login form). `AuthController` delegates to `AuthenticationService`, which uses `ClientService` (the SDK `Auth0` client): `login()` redirects to the Auth0 authorize URL; `callback()` calls `$client->exchange()` — the SDK verifies the `state` parameter (CSRF), exchanges the code, and validates the ID token signature/`iss`/`aud`/`nonce`/expiry — then the module additionally checks the token `sub` matches the userinfo before building an `Auth0User`. `UserProvisionService` (backed by `externalauth`) loads or registers a Drupal user for the Auth0 `sub`, optionally syncing roles and profile fields on each login. `ConfigurationService` centralizes settings (`auth0.settings`) and integrates the **Key** module: client secret and cookie secret are read from a Key entity when a `*_key` id is set, otherwise from a direct config value (which logs a "consider using Key module" warning). Config ships all-empty (no baked-in credentials). Two admin forms exist: Basic Settings (`auth0.settings`, domain/client id/secrets, `administer site configuration`) and Advanced (`auth0.advanced_settings`: verified-email requirement, username claim, claim→field mapping, role mapping, sync toggles, password-reset). A logged-in user can trigger an Auth0 password-reset email for their own address (`/auth0/password-reset`). Requires `key` + `externalauth`, PHP 8.3. This is a `5.0.0-alpha1` release.

---

- Add Auth0 Single Sign-On to a Drupal site (replace the core login with Universal Login).
- Enable social login (Google, GitHub, etc.) through Auth0's connections.
- Centralize authentication across multiple Drupal sites on one Auth0 tenant.
- Provision Drupal accounts automatically on first Auth0 login (via ExternalAuth).
- Map Auth0 roles to Drupal roles and keep them in sync on each login.
- Map Auth0 claims to Drupal user profile fields and sync them on login.
- Choose which Auth0 claim becomes the Drupal username (default `nickname`).
- Require a verified email at Auth0 before allowing login.
- Store the Auth0 client secret and cookie secret in Key entities (env/file) instead of config.
- Keep a legacy Drupal login form available at `/user/login/legacy` for break-glass access.
- Let users request a password-reset email from Auth0 for their own account.
- Configure the Auth0 database connection used for password resets.
- Log users out of both Drupal and Auth0 with a returnTo redirect.
- Use enterprise connections (SAML/AD) fronted by Auth0 for staff login.
- Enforce MFA/adaptive policies at Auth0 without changing Drupal.
- Fetch and snake_case Auth0 role names via the Management API for role mapping.
- Override client secret / domain per environment via settings.php + Key providers.
- Add SSO to a decoupled/back-office Drupal without building an OIDC client by hand.
- Delegate token/state/nonce validation to the maintained official Auth0 SDK.
- Restrict access to Auth0 settings to trusted admins (`administer site configuration`).
