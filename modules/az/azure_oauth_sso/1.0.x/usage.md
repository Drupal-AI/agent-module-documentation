<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Azure OAuth Client SSO lets people sign in to Drupal with a Microsoft Entra ID (Azure AD) account, mapping directory fields and groups onto the Drupal user.

---

Any organisation on Microsoft 365 already runs an identity provider, and the usual requirement is for Drupal to join it rather than keep separate passwords. This module implements the OAuth 2.0 authorization-code flow directly against `login.microsoftonline.com` for a single Azure application: an administrator enters the tenant ID, client ID and client secret on the settings form (`/admin/config/people/azure_oauth_sso/basic-config`), and the module handles the redirect to Microsoft, the code-for-token exchange at the `/oauth2/v2.0/token` endpoint, and a call to Microsoft Graph (`/v1.0/me`) to read the person's profile. A Drupal account is matched by email and logged in, or a new one is provisioned. Two further screens map Graph properties onto Drupal user fields (Fields Mapping) and map Entra groups or the directory `department` value onto Drupal roles (Roles Mapping). The login route can either redirect visitors to Microsoft immediately or render a Microsoft login button on chosen forms, the profile photo can be synced from Graph, and the stored access/refresh tokens are retrievable through the `azure_oauth_sso.token_service` service (`getToken()` / `refreshToken()`). Version **1.0.9** on `^9 || ^10 || ^11`; configuration lives at `/admin/config/people/azure_oauth_sso`.

---

- Let staff sign in to Drupal with their Microsoft 365 / Entra ID account.
- Add Azure AD single sign-on to an existing site.
- Remove separate Drupal passwords for an internal team.
- Redirect the standard `/user/login` page straight to Microsoft.
- Render a "Sign in with Microsoft" button on the core login form.
- Show the SSO login link on additional custom forms by their form ID.
- Auto-provision a Drupal account on a person's first Microsoft login.
- Map Microsoft Graph `mail`, `displayName`, `givenName`, `surname` onto user fields.
- Map arbitrary Graph properties (job title, department, city, phone) onto profile fields.
- Assign a Drupal role from an Entra directory group's object ID.
- Assign a Drupal role from the directory `department` field value.
- Fall back to a configured default role when no group/department mapping matches.
- Sync the user's Microsoft profile photo into the Drupal `user_picture` field.
- Keep mapped profile fields refreshed on each subsequent login.
- Support a corporate intranet or members' area with Microsoft-backed login.
- Support a university or agency running on a Microsoft tenancy.
- Authenticate contractors and editors through Entra ID.
- Retrieve a Microsoft Graph access token in custom code via the token service.
- Automatically refresh an expired Graph token from the stored refresh token.
- Optionally sign the user out of Microsoft when they log out of Drupal.
- Reduce password-reset support load for a Microsoft-centred organisation.
- Test the configured Azure credentials from the settings form's "Test Configuration" link.
