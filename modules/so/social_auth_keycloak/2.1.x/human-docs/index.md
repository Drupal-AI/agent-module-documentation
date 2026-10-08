# Social Auth Keycloak — manual setup guide

**Social Auth Keycloak** (`social_auth_keycloak`) lets people register and sign in
to your Drupal site with a **Keycloak** account, so a self-hosted Keycloak realm
becomes a single sign-on (SSO) provider for your site. It adds a
`user/login/keycloak` path that hands the visitor off to Keycloak for
authentication; when Keycloak sends them back, the module matches them to an
existing account (by Keycloak user id or email address) or creates a fresh one,
and an already-logged-in user can link their Keycloak identity to their account.

It is a **thin network plugin** in the Social Auth family. It supplies the
Keycloak client, endpoints and user mapping, while the heavy lifting of the OAuth2
/ OpenID Connect flow — the `state` CSRF check and the token exchange — is done by
the shared **Social Auth** framework. Because of that, it depends on both **Social
API** (`social_api`) and **Social Auth** (`social_auth`), and Composer pulls them
in for you. There are no submodules.

The module does nothing on its own until you give it Keycloak credentials. You
create an OAuth client in your Keycloak realm, then enter its **client ID** and
**client secret** into Drupal (treat the secret like a password — store it as a
site secret and only ever talk to Keycloak over HTTPS, pointed at a realm you
trust). It has no access-control powers of its own beyond letting people
authenticate; how new accounts are created, matched and linked is governed by the
**Social Auth** module's own settings, so review those before going live.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Social Auth dependencies.

## How to use it

Once installed and given Keycloak credentials, visitors log in by clicking the
**Keycloak** button in the Social Auth login block, or you can place and theme a
link to `user/login/keycloak` anywhere on the site. Enter the Keycloak client ID
and secret through Social Auth's network settings (under **Configuration → Social
API → User authentication**), and check the Social Auth account-linking and
auto-registration settings so new sign-ins behave the way you expect.
