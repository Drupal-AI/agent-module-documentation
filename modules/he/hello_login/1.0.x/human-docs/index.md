# Hello Login (Hellō IdP) — manual setup guide

**Hello Login** (`hello_login`) lets your users register and log in through the
**Hellō** identity provider ([hello.dev](https://hello.dev) / hello.coop) instead of
managing yet another username and password on your site. Hellō is a privacy‑first
"identity wallet" that gives each user their choice of popular social logins, email,
or phone — and it verifies their email address for you, without tracking them.

Under the hood this is a standard **OpenID Connect (OIDC)** login client built on
Drupal's **External Authentication** (`externalauth`) framework. When a user chooses
to log in with Hellō, they are redirected to Hellō to authenticate, and Hellō
returns a verified identity that Drupal maps to a local user account. The users
themselves manage how they log in (and recover their account) at
`wallet.hello.coop`, so that is no longer your site's job.

The trust model is the important part to understand: your Drupal site becomes a
**relying party** that trusts identities asserted by Hellō. That trust is
established with a **client id** and a **client secret** issued to your site when you
register it with Hellō. The client secret is a genuine credential — anyone who has
it can impersonate your site to the identity provider — so it must be stored securely
and never committed to version control (see [Configuration](configuration/index.md)).

Hellō provides a **Quickstart** flow designed to get a site registered and connected
in just a few clicks, which is the easiest way to obtain your client credentials.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pull in its dependencies.
2. [Configuration](configuration/index.md) — register your site with Hellō, store
   the client secret securely, and grant login permissions.

## How it works at a glance

1. A visitor clicks the Hellō login option on your site.
2. Drupal (via `externalauth`) redirects them to Hellō to authenticate with their
   chosen method (social, email, or phone).
3. Hellō authenticates the user and returns a verified identity to your site.
4. Drupal matches or creates a local account for that identity and logs the user in.
