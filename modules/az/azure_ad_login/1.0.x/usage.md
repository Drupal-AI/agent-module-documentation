<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Azure AD Login adds a "Login with your Azure AD account" link to the Drupal login form and authenticates visitors against Microsoft Entra ID (Azure AD).

Use it when your organization manages identities in Azure AD/Entra ID and you want staff to reach Drupal with their corporate credentials instead of a separate Drupal password.

---

Install with `composer require drupal/azure_ad_login` and enable it (`drush en azure_ad_login`). It depends only on core `user`.

Register an application in the Azure portal, then configure client ID, client secret, tenant, authorize/token/graph endpoints and a role-to-group map at `/admin/config/services/azure-ad-login` (permission: `administer azure_ad_login configuration`). Set the app's redirect URI to `https://YOURSITE/callback_azure_ad`.

The OAuth callback route `callback_azure_ad` is gated only by `access content` (must be reachable by anonymous visitors mid-login). On callback the module exchanges the code for a token, reads the Graph `/me` profile, matches or creates a Drupal user by `userPrincipalName`, and finalizes login.

---

- Add an Azure AD login link to the standard user login form.
- Authenticate Drupal users against Microsoft Entra ID / Azure AD.
- Use the OAuth 2.0 authorization-code grant with client ID and secret.
- Redirect users to Azure's `authorize` endpoint and back to `callback_azure_ad`.
- Exchange the returned `code` for an access token at the token endpoint.
- Read the signed-in user's profile from Microsoft Graph `/v1.0/me`.
- Match an existing Drupal account by email against the Azure `userPrincipalName`.
- Auto-provision a new Drupal account when none exists for the UPN.
- Generate a random 25-character password for auto-created accounts.
- Map Azure AD security-group display names to Drupal roles.
- Assign mapped roles to newly created users based on their Graph `memberOf` groups.
- Restrict who can configure the module with the `administer azure_ad_login configuration` permission.
- Only show the login link when at least one role/group mapping is configured.
- Support single-tenant or (via a `common` tenant) multi-tenant Azure apps through configuration.
- Provide a settings form for client ID, secret, tenant and endpoint hosts.
- Log authentication errors to the `Azure login` logger channel.
- Work on Drupal 9.1+ and Drupal 10.
- Complement, rather than replace, Drupal's local login (the local form stays available).