# Social Auth Facebook — manual setup guide

**Social Auth Facebook** (`social_auth_facebook`) lets visitors register and log in
to your Drupal site with their Facebook (Meta) account. It adds a "Log in with
Facebook" button to the Social Auth login block and a one-click
`/user/login/facebook` entry point; on first login it can create a Drupal account
from the person's Facebook profile, so users don't need a separate site password.

It is a **network plugin** for the [Social Auth](https://www.drupal.org/project/social_auth)
framework (built on Social API), which does the shared login plumbing. This module
supplies the Facebook-specific piece using the `league/oauth2-facebook` OAuth2
client. To make it work you create a Facebook app at Meta for Developers, register
your site's callback URL as a valid OAuth redirect URI, and paste the app's **App
ID** and **App secret** into the module's settings form. From then on, Social Auth
handles the OAuth handshake and maps the returned Facebook profile to a Drupal user.

The module stores its settings (App ID, App secret, Graph API version, scopes, and
endpoints) in a single configuration object. If the [Rules](https://www.drupal.org/project/rules)
module is installed, it also exposes events for "user logged in via Facebook" and
"user created via Facebook", so you can react with custom Rules actions. It works
alongside other Social Auth networks (Google, and so on) on the same login block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Social Auth
   dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — create the Facebook app, register the
   callback URL, and fill in the settings form, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API settings → Social Auth →
Facebook** (`/admin/config/social-api/social-auth/facebook`) — a Facebook tab under
Social Auth's integrations page. You need the **Administer social api
authentication** permission (provided by Social Auth) to open it.

Once configured, the login URL is `/user/login/facebook`, and the OAuth callback
you register in the Meta app is `/user/login/facebook/callback`.
