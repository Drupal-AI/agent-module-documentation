# Social Auth Twitter — manual setup guide

**Social Auth Twitter** (`social_auth_twitter`) adds "Sign in with Twitter/X" to a
Drupal site, letting people register and sign in with their **Twitter / X**
account. It adds a `user/login/twitter` path that redirects the visitor to X to
authenticate; when X returns them, the module matches them to an existing account
(by X user id or email) or creates a new one, and an already-logged-in user can
link their X account.

It is a provider plugin for the **Social Auth** framework and contributes almost no
flow logic of its own — all the routing (the redirect and the callback) comes from
the parent **Social Auth** module. This plugin adds a settings tab and a Twitter/X
button to the Social Auth login block, and wires in a third-party Twitter OAuth2
client. The 4.x line uses the modern **OAuth2 authorization-code flow with PKCE**;
it requests the scopes `tweet.read`, `users.read`, `users.email` and
`offline.access` by default (the last yields a refresh token), and you can request
more. It depends on `social_auth` and requires Drupal core `^10 || ^11`. There are
no submodules.

The module does nothing until you create an app in the **X Developer Portal**,
enable OAuth on it, register the callback URL, and paste the app's API key and
secret into Drupal as the Client ID and Client secret. To receive the user's email
you must enable "Request email from users" in the X app. Treat the client secret
like a password — keep it in an environment variable / site secret rather than in
exported configuration where practical. State/CSRF handling and the token exchange
are managed by the base Social Auth machinery over verified TLS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — create the X app and enter the Client
   ID, Client secret and scopes.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API → Social Auth → Twitter**
(`/admin/config/social-api/social-auth/twitter`, route
`social_auth_twitter.settings_form`), behind the **Administer social api
authentication** permission. Visitors sign in from the **Twitter/X** button in the
Social Auth login block, or from a link you place to `user/login/twitter`.
