# Infomaniak OpenID Connect — manual setup guide

**Infomaniak OpenID Connect** (`infomaniak_connect`) lets people sign in to your
Drupal site with their **Infomaniak** account. It is a thin client for the
popular [OpenID Connect](https://www.drupal.org/project/openid_connect) module:
once enabled, it registers a ready-made, preconfigured **Infomaniak OAuth 2.0**
client so Infomaniak can act as a single-sign-on (SSO) identity provider for your
site.

Because it builds on OpenID Connect, all the heavy lifting — the login button, the
authentication flow, mapping remote accounts to Drupal users — is handled by that
module. Infomaniak Connect's job is simply to supply the correct Infomaniak
endpoints and defaults, so all you have to provide is your own **Client ID** and
**Client secret** from the Infomaniak Manager, and to point Infomaniak at the
redirect URI Drupal gives you.

Those two credentials are secrets. As with any OAuth client secret, keep the
Client secret out of version control and out of plain configuration where you can
— store it in an environment variable and reference it, rather than pasting it
into a file you might commit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its OpenID
   Connect dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — create the Infomaniak application,
   enter the credentials on the OpenID Connect client, and enable the login
   button.

## Where it lives in the admin menu

This module has no settings page of its own. You configure the Infomaniak client
on the OpenID Connect settings page at **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`), where "Infomaniak OAuth 2.0" appears as a
preconfigured client once the module is enabled.
