<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Vkontakte lets users register and log in with their VKontakte (VK) account, built on the Social Auth / Social API OAuth2 framework.

---

Social Auth Vkontakte adds "Log in with VK" (VKontakte) to a Drupal site. It is a provider plugin
for the Social Auth framework (on Social API), which handles the shared OAuth2 login/registration
machinery; this module supplies the VK provider client and settings for the VK application's client ID
and secret. On login it authenticates against VK and maps the VK identity to a Drupal account. It
depends on the Social Auth module.

The OAuth2 authorization-code flow — including the random `state` parameter for CSRF protection and the
code/token exchange — is handled by the underlying Social Auth base and OAuth2 client (this module
generates a random state via the client), which is the correct place for it. When adopting, register a
VK application, store its client ID/secret as configuration/secrets, and set the callback URL to the
route Social Auth exposes. Account creation/matching behaviour is governed by Social Auth's settings.

---

- Add 'Log in with VK' to Drupal.
- Register users via VKontakte.
- Authenticate against VK with OAuth2.
- Map a VK identity to a Drupal account.
- Configure the VK client ID/secret.
- Delegate the OAuth2 flow to Social Auth.
- Rely on Social Auth for state/CSRF.
- Generate a random OAuth state.
- Depend on the social_auth module.
- Set the VK callback URL.
- Store the client secret as a secret.
- Provide a VK login option.
- Register a VK application.
- Govern account creation via Social Auth.
- Integrate the Social API stack.
- Sign in with VK SSO.
- Redirect to VK for authorization.
- Exchange the auth code for a token.
- Match users by VK identity.
- Enable VK social login.
