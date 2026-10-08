<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenID Connect Microsoft Azure Active Directory client adds a `windows_aad` OpenID Connect client plugin that lets Drupal users sign in with Microsoft Entra ID (formerly Azure AD), including Azure AD B2C, and optionally maps their Entra groups onto Drupal roles.

---

The module ships a single `windows_aad` plugin for the [OpenID Connect](https://www.drupal.org/project/openid_connect) client framework; it does not add its own menus, permissions, or Drush commands. You configure it by creating an `openid_connect_client` config entity (via `/admin/config/services/openid-connect`) whose `plugin` is `windows_aad`, supplying the Entra app registration's Client ID, a Key-module-backed Client secret, and the tenant-specific authorization/token endpoints. It supports the modern Microsoft Graph API (v1.0), the deprecated Azure AD Graph API (v1.6), or an alternate/no userinfo endpoint, and auto-detects Azure AD B2C from the `.b2clogin.com` endpoint host to decode claims straight from the access token. When "Map AD groups to Drupal roles" is enabled it reads the user's group membership from Graph and grants matching Drupal roles either automatically (name/id match) or by explicit `role|group` mappings, with an optional strict mode that strips unmapped roles. Extra options cover subject-key selection (`sub` vs `oid`), email handling (update on login, use Graph `otherMails`, hide the missing-email warning), a front-channel single-logout endpoint, and Entra-specific `prompt` values (login, consent, select_account, create). The Client secret is always resolved through a [Key](https://www.drupal.org/project/key) entity rather than stored in plain config.

---

- Let staff sign in to Drupal with their Microsoft 365 / Entra ID work accounts (SSO).
- Add a "Log in with Microsoft" button to the Drupal login form via OpenID Connect.
- Authenticate against a specific Entra tenant using tenant-scoped authorization and token endpoints.
- Integrate an Azure AD B2C customer-identity tenant for external/consumer logins.
- Auto-provision Drupal accounts for Entra users on first login.
- Map Entra security groups to Drupal roles automatically by matching group name or object id.
- Define explicit `role|group-id` mappings when Entra group names differ from Drupal role names.
- Enforce strict role mapping so users only keep Drupal roles backed by a current Entra group.
- Grant admin access based on membership of a specific Entra group id.
- Pull user profile data (name, email) from the Microsoft Graph v1.0 endpoint.
- Support legacy setups still on the deprecated Azure AD Graph API v1.6.
- Skip a userinfo call entirely and read claims from the ID/access token for lean flows.
- Use the Graph `otherMails` property to resolve an email when the primary `mail` is absent.
- Keep Drupal email addresses in sync with Entra by updating them on each login.
- Suppress the "email address not found" warning for end users when mail claims are missing.
- Choose `oid` instead of `sub` as the immutable identifier to keep user mapping stable across app registrations and environments.
- Store the Entra client secret securely in a Key entity (env var, file, or config) instead of plaintext.
- Provide a front-channel logout URL so Entra can sign the user out of Drupal on IdP logout.
- Force re-authentication, consent, or an account picker with Entra `prompt` values.
- Trigger an Entra sign-up experience with the `prompt=create` option.
- Restrict which domains may initiate SSO through the ISS (issuer) parameter.
- Migrate an older Azure AD Graph integration to Microsoft Graph without changing the login flow.
- Federate multiple Drupal environments (dev/stage/prod) against different Entra app registrations while keeping stable user identity via `oid`.
