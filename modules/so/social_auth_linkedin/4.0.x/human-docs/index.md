# Social Auth LinkedIn — manual setup guide

**Social Auth LinkedIn** (`social_auth_linkedin`) lets people register and log in
to your Drupal site with their LinkedIn account. It adds a `/user/login/linkedin`
route, a LinkedIn button to the Social Auth login block, and a small settings form
where you enter your LinkedIn app's OAuth2 client ID and secret. It's a thin
"network plugin" that plugs LinkedIn into the shared
[Social Auth](https://www.drupal.org/project/social_auth) / Social API framework.

Because it builds on Social Auth, all the heavy lifting — the redirect and
callback handling, CSRF/state validation, matching returning users, creating new
accounts, and the login block — lives in those shared modules. This module just
supplies the LinkedIn specifics: it wires in the `league/oauth2-linkedin` OAuth2
provider, requests the LinkedIn profile and email scopes, exchanges the
authorization code for a token, and builds a Drupal user from the LinkedIn
profile (name, id, email, avatar). Returning users are matched by their LinkedIn
id or email and logged straight in.

One compatibility note to keep in mind: the module requests LinkedIn's **legacy**
"Sign In with LinkedIn" scopes (`r_liteprofile`, `r_emailaddress`). LinkedIn now
steers new apps toward "Sign In with LinkedIn using OpenID Connect" instead, so
depending on which product your LinkedIn app has, you may need to adjust the setup
— see the [Configuration](configuration/index.md) page for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (including its Social Auth and OAuth2 library dependencies).
2. [Configuration](configuration/index.md) — create a LinkedIn app, register the
   callback URL, and enter the client ID/secret.

## Where it lives in the admin menu

The settings form is at **Configuration → User authentication → LinkedIn**
(`/admin/config/social-api/social-auth/linkedin`) — this is Social Auth's generic
network settings form for the LinkedIn network. It's gated by the Social Auth
administration permission.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Open the LinkedIn settings form and copy the **Authorized redirect URL** it
   shows you.
3. Create a LinkedIn app, add the "Sign In with LinkedIn" product, and register
   that redirect URL.
4. Paste the app's **Client ID** and **Client Secret** into the form and save.
5. Place the **Social Auth Login** block (or link to `/user/login/linkedin`
   directly) so the LinkedIn button appears.

Each step is covered in [Configuration](configuration/index.md).
