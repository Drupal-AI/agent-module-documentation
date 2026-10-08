# Social Auth Vipps — manual setup guide

**Social Auth Vipps** (`social_auth_vipps`) lets people register and sign in to
your Drupal site with their **Vipps** account — the Norwegian mobile-pay and
identity service — so all a visitor needs to sign in is their phone number and the
Vipps app. It adds a `user/login/vipps` path that redirects the visitor to Vipps to
authenticate; when Vipps returns them, the module fetches their profile and hands
it to Social Auth to log them in, create an account, or (for a logged-in user) link
their Vipps identity. It is built on the **Social API** / **Social Auth**
framework, depends on `social_auth`, and has no submodules.

The login uses the standard OAuth2 authorization-code flow and requests the OpenID
scopes `openid`, `address`, `email`, `name` and `phoneNumber`. Two nice security
properties come out of the box: it verifies the OAuth2 `state` parameter to prevent
login-CSRF (inherited from Social Auth's base controller), and it **hardens** that
check further by also storing the generated state in Drupal's state store with a
timestamp and re-validating it within a short (~2-minute) window, so a valid state
cannot be replayed and the Vipps app's automatic-return flow still verifies
correctly. It also rejects Vipps profiles whose email is not verified.

The module does nothing until you obtain a Vipps login/merchant application and
enter its client ID and secret into Drupal. Note the sign-up lead time: you apply
for "Vipps på Nett", and after a day or two you receive Developer Portal login
details where the API credentials live. There is a sibling module, **Vipps Login**,
for hosts that cannot run Composer — but Social Auth Vipps is the official module
and the one to use when Composer is available.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — register a Vipps app and enter the
   client id and secret.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API → Social Auth → Vipps**
(`/admin/config/social-api/social-auth/vipps`, route
`social_auth_vipps.settings_form`), behind the **Administer social api
authentication** permission. Visitors sign in from the **Vipps** button in the
Social Auth login block, or from a link you place to `user/login/vipps`.
