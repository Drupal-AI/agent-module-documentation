# Social Auth Vkontakte — manual setup guide

**Social Auth Vkontakte** (`social_auth_vk`) adds "Log in with VK" to a Drupal
site, letting people register and sign in with their **VKontakte (VK)** account. It
adds a `/user/login/vk` path that redirects the visitor to VK to authenticate; when
VK returns them, the module matches them to an existing account (by VK identity or
email) or creates a new one, and an already-logged-in user can link their VK
account.

It is a provider plugin for the **Social Auth** framework (built on Social API),
which handles the shared OAuth2 login and registration machinery; this module
supplies the VK client and the settings for the VK application's **client ID** and
**secret**. The OAuth2 authorization-code flow — including the random `state`
parameter for CSRF protection and the code/token exchange — is handled by the
underlying Social Auth base and OAuth2 client, which is the correct place for it. It
depends on `social_auth` and requires Drupal core `^9||^10||^11`. There are no
submodules.

The module does nothing until you register a VK application and enter its client ID
and secret into Drupal, then set VK's redirect URL to match the callback shown on
the settings form (store the secret as a site secret). How accounts are created,
matched and linked is governed by Social Auth's own settings. If you are upgrading
from an earlier release, note that moving to 4.x calls for a clean re-install of
the module (uninstall, require `^4.0`, clear cache, re-enable) and then
re-confirming the client ID/secret and the VK redirect URL.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — register a VK app and enter the
   client ID, secret and redirect URL.

## Where it lives in the admin menu

VK is configured through Social Auth's network settings form (route
`social_auth.network.settings_form`), reached under **Configuration → Social API →
Social Auth**. Visitors sign in from the **VKontakte** logo in the Social Auth login
block, or from a link you place to `/user/login/vk`.
