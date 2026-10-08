<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft Entra ID SSO Login adds a "Log in with Microsoft" option to Drupal, letting users sign in with their Microsoft Entra ID (formerly Azure AD) account — the common need for an intranet, employee portal, or any site backed by a Microsoft 365 tenant.

---

The module implements the OAuth 2.0 Authorization Code flow directly against Microsoft (it is self-contained and does not require the Social API framework — only core `user`). A visitor sent to `/user/login/entra-id` is redirected to Microsoft; the callback at `/user/login/entra-id/callback` exchanges the code for tokens and reads the user's email from the ID token claims. That email is matched to a Drupal account, which is either logged in or, when "Register and Login" is selected, created on the fly. Administrators configure the Azure client ID, client secret, and tenant ID at `/admin/config/services/entra-id/settings`, choose the account type (organization / both / personal), pick login behavior, restrict to an allowlist of email domains, and toggle blocks for user 1 and the administrator role. Credentials can be moved out of the database by overriding them in `settings.php`. A configurable "Entra ID Login Block" places a themeable "Log in with Microsoft" button anywhere, and the callback URL to register in Azure is shown on the settings form. Requirements: core `user` and Drupal `^9 || ^10 || ^11`.

---

- Let staff sign in with their Microsoft 365 account.
- Add single sign-on to a Drupal intranet.
- Remove separate Drupal passwords for employees.
- Meet a policy requiring corporate identity for login.
- Map Entra ID users to Drupal accounts by email.
- Auto-provision Drupal accounts on first sign-in.
- Restrict SSO to an existing-users-only ("Login Only") mode.
- Reduce password-reset support load.
- Enforce MFA and conditional access at Microsoft.
- Limit login to a single Azure tenant (organization mode).
- Allow both work/school and personal Microsoft accounts (common mode).
- Restrict logins to specific email domains.
- Provide a themeable "Log in with Microsoft" button block.
- Add a direct login link anywhere via `/user/login/entra-id`.
- Keep local Drupal accounts alongside SSO.
- Block user 1 and administrators from SSO login.
- Centralise account deprovisioning in Entra ID.
- Support an educational Microsoft 365 estate.
- Onboard new staff without creating Drupal passwords.
- Move client credentials into environment variables via settings.php.
- Show the Azure Redirect URI to paste into the app registration.
