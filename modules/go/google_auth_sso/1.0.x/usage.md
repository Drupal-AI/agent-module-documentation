<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Auth SSO builds on the Social Auth Google module to (a) optionally restrict who can start the Google login by client IP and (b) automatically assign Drupal roles based on custom schema data in the user's Google Workspace directory profile.

---

It does not implement the OAuth flow itself — the redirect, state handling, token exchange, and account matching are all provided by the social_auth_google / social_auth dependency. This module adds a settings field (Restricted IPs) by extending Social Auth Google's settings form, a route/access check that forbids the redirect_to_google route and the login block when the client IP is not in the allowlist, and an event subscriber (SyncGoogleRoles) that, on each Social Auth login/creation, queries the Google Admin Directory API for the user's customSchemas.Drupal.Roles and sets the Drupal user's roles accordingly. Because roles come straight from Google Workspace, your Workspace admin effectively controls Drupal role assignment for SSO users. Requires Google Workspace with domain-wide delegation and the appropriate directory scope. Use it for organizations that manage Drupal access centrally in Google Workspace.

---

- Let staff sign in to Drupal with their Google Workspace account.
- Assign Drupal roles from Google Workspace directory data.
- Centralize access management in Google Workspace.
- Auto-activate approved new users based on Google roles.
- Restrict Google login to office IP ranges.
- Keep Drupal roles in sync with Workspace on every login.
- Provision editor/admin roles via a Google custom schema.
- Onboard employees without manual Drupal role setup.
- Hide the Google login block outside allowed IPs.
- Enforce SSO for an internal/intranet Drupal site.
- Map organizational units to Drupal roles through Google.
- Remove Drupal access by changing a user's Google roles.
- Reduce manual account administration for large teams.
- Combine Google SSO with IP-based login restriction.
- Reflect Workspace group membership as Drupal roles.
- Support a single-sign-on policy across company tools.
