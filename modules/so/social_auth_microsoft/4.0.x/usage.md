<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Microsoft lets users sign in with a personal Microsoft account, as a provider plugin for the Social Auth framework.

---

Social Auth is the family that standardises "sign in with X" across providers: it owns the OAuth2 redirect/callback flow, the account matching and the user-mapping settings, while each provider supplies only the network specifics. This module contributes the Microsoft one — a single `@Network` plugin (`social_auth_microsoft`, short name `microsoft`) plus a `MicrosoftAuthManager` that drives the `stevenmaguire/oauth2-microsoft ^2.0` library against the consumer Microsoft Account / Live Connect endpoints (`login.live.com`, `apis.live.net/v5.0/me`). It requires `social_auth ^4.1` (which pulls in Social API), PHP 8.1+, and core `^9.5 || ^10 || ^11`. Configuration is a client ID and client secret from a Microsoft app registration, entered at `/admin/config/social-api/social-auth/microsoft`, with the callback URL `/user/login/microsoft/callback` registered on the Microsoft side. Because it targets personal Microsoft accounts rather than an Azure AD tenant, it is the counterpart to `social_auth_entra_id`: pick this one when the site already runs Social Auth for other providers and wants generic Microsoft sign-in, and Entra ID when the requirement is a specific organisational tenant. Once configured, a "Microsoft" button appears in the Social Auth Login block, or you can link to `/user/login/microsoft` from anywhere and theme it freely.

---

- Let users sign in with a personal Microsoft account.
- Add Microsoft to an existing Social Auth setup.
- Reduce password management for users.
- Offer several social login options side by side.
- Map Microsoft identities to Drupal accounts by account id.
- Link a Microsoft login to an existing account by email on first sign-in.
- Provision new accounts automatically on first sign-in.
- Let a logged-in user associate a Microsoft account with their profile.
- Reuse Social Auth's account matching and user-mapping settings.
- Reduce registration friction for a consumer audience.
- Place a themed "Microsoft" button via the Social Auth Login block.
- Add a Microsoft login link anywhere by pointing at `/user/login/microsoft`.
- Request extra OAuth scopes for the Microsoft sign-in.
- Pull extra Microsoft Graph data into the user record via configured endpoints.
- Redirect new users to the Drupal user form after registration.
- Restrict social login for user 1 or specific roles.
- Authenticate users without a Drupal password.
- Complement other Social Auth providers on a mixed-login site.
- Standardise social login handling across providers.
- Reduce password-reset support requests.
- Send users to a chosen path after a successful login.
