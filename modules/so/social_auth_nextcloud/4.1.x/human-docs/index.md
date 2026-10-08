# Social Auth Nextcloud — manual setup guide

**Social Auth Nextcloud** (`social_auth_nextcloud`) lets people register and sign
in to your Drupal site with their **Nextcloud** account, turning a (self-hosted)
Nextcloud instance into an OAuth2 login provider. When a visitor authenticates,
the module matches them to an existing account (by Nextcloud user id or email
address) or creates a new one; an already-logged-in user can link their Nextcloud
identity to their account.

It is a **thin network plugin** in the Social Auth family. It supplies the
Nextcloud client, endpoints and user-info mapping, while the OAuth2 flow — the
`state` CSRF check and the token exchange — is handled by the shared **Social
Auth** framework it depends on (`social_auth`). There are no submodules.

A nice touch of this module is that the login link carries the Nextcloud server
address, in the form `/user/login/nextcloud:your_nextcloud_url` — which is how a
single Social Auth plugin can point at whichever Nextcloud instance you run. The
module does nothing until you register an OAuth client on your Nextcloud instance
and give Drupal the resulting **client ID** and **client secret** (store the secret
as a site secret and only talk to Nextcloud over HTTPS, pointed at an instance you
trust). One thing worth knowing from the module's own notes: **scoped access via
OAuth is not yet implemented in Nextcloud**, so treat a successful login as
"this is a valid Nextcloud user" rather than as fine-grained, scoped
authorization. How accounts are created, matched and linked is governed by Social
Auth's own settings.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.

## How to use it

Visitors log in by clicking the **Nextcloud** logo in the Social Auth login block,
or you can place and theme your own button/link anywhere on the site pointing to
`/user/login/nextcloud:your_nextcloud_url`. Enter the Nextcloud client ID and
secret through Social Auth's network settings, and review the Social Auth
account-linking and auto-registration settings before going live.
