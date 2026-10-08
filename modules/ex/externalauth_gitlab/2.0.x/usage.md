<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds GitLab OAuth 2.0 single sign-on to a Drupal site by mapping GitLab accounts to existing Drupal users via the External Authentication framework.

---

Externalauth Gitlab OAuth2 Connector is a login client that lets people sign in to Drupal with a GitLab account from a
self-hosted GitLab instance or gitlab.com. Enabling it adds a "Log in via Gitlab" local task on the user account area
(`/user`); following it redirects the visitor to the configured GitLab instance for OAuth authorization, and the same
route (`/user/login/gitlab`) handles the callback when GitLab redirects back. On return the module obtains an access
token, reads the GitLab account's profile, and resolves it through the External Authentication (`externalauth`) module:
if the GitLab identity is already linked it logs that user in, otherwise it maps the GitLab account to an existing Drupal
user by email address and links them. It does not create new Drupal accounts. An administrator supplies the GitLab
application's client ID, client secret and instance domain on a settings form under Configuration → People. The OAuth
exchange is implemented with the `omines/oauth2-gitlab` and `league/oauth2-client` libraries; Drupal roles and
permissions continue to come from the mapped local account.

---

- Let a team that already uses GitLab log in to Drupal with their GitLab credentials (single sign-on).
- Authenticate Drupal users against a self-hosted GitLab instance over OAuth 2.0.
- Authenticate Drupal users against gitlab.com accounts.
- Add a "Log in via Gitlab" link as a local task on the `/user` account page.
- Offer GitLab SSO alongside Drupal's normal username/password login rather than replacing it.
- Map an authenticated GitLab identity to an existing Drupal account by email address.
- Reuse the External Authentication (`externalauth`) framework's identity-linking for GitLab logins.
- Keep Drupal as the authority for roles and permissions while GitLab handles authentication.
- Avoid managing separate passwords for internal tools by delegating login to a corporate GitLab.
- Provide OAuth-based SSO for an intranet or developer portal built on Drupal.
- Link a returning GitLab user directly to their previously connected Drupal account.
- Restrict site login to people who already have both a GitLab account and a matching Drupal account.
- Pre-provision Drupal accounts (matched by email) and let staff activate them by logging in via GitLab.
- Configure the GitLab client ID, client secret and instance domain from a single admin settings form.
- Point the connector at any GitLab domain, so multiple environments (staging, production) can target different instances.
- Grant a dedicated administrator role the permission to manage the GitLab OAuth settings.
- Give developers a familiar GitLab-based login for a documentation or tooling site.
- Consolidate authentication for organizations that standardize on GitLab for identity.
- Use GitLab as the identity provider for a Drupal site without deploying a full SAML/OIDC stack.
- Serve a "Log in with GitLab" entry point that redirects out and returns via the OAuth authorization-code flow.
- Onboard new team members by creating their Drupal account with the same email as their GitLab account.
- Provide SSO for a Drupal-based support or knowledge base used by a GitLab-centric engineering team.
