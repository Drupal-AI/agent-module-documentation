<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth GitHub lets users register and log in with their GitHub account, built on the Social Auth and Social API framework using OAuth2.

---

Social Auth GitHub adds "Log in with GitHub" to a Drupal site. It is an implementation plugin for
the Social Auth framework (itself on Social API), which provides the shared OAuth2 login/registration
machinery; this module supplies the GitHub provider client (via the `league/oauth2-github` library)
and settings form for the GitHub OAuth app's client ID and secret. On login it authenticates the user
against GitHub and maps the GitHub identity to a Drupal account, creating one on first login according
to the Social Auth settings.

The OAuth2 authorization-code flow — including the `state` parameter used for CSRF protection and the
code/token exchange — is handled by the underlying Social Auth base module and the OAuth2 client
library, which is the right place for it; this module configures and delegates to that flow rather
than reimplementing it. When adopting, register a GitHub OAuth application, store its client ID and
secret via configuration/secrets, and set the authorization callback URL to the route Social Auth
exposes. Behaviour such as whether new accounts are auto-created and how existing accounts are matched
is governed by the Social Auth base configuration.

---

- Add 'Log in with GitHub' to Drupal.
- Register users via their GitHub account.
- Authenticate against GitHub with OAuth2.
- Map a GitHub identity to a Drupal account.
- Create an account on first GitHub login.
- Configure the GitHub OAuth client ID and secret.
- Delegate the OAuth2 flow to Social Auth base.
- Rely on Social Auth for the state/CSRF handling.
- Use the league/oauth2-github client library.
- Set the GitHub OAuth callback URL.
- Store the client secret via secrets/config.
- Provide a GitHub login button/block.
- Match existing users by GitHub email.
- Govern auto-create behaviour via Social Auth settings.
- Integrate with the Social API provider stack.
- Register a GitHub OAuth app for the site.
- Let developers sign in with GitHub SSO.
- Redirect to GitHub for authorization.
- Exchange the auth code for a token via the library.
- Depend on social_auth (and social_api).
