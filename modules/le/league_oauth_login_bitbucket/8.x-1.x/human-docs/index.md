# League OAuth Login Bitbucket — manual setup guide

**League OAuth Login Bitbucket** (`league_oauth_login_bitbucket`) adds
**Bitbucket** as a sign‑in source for the
[League OAuth Login](../../league_oauth_login/2.0.x/human-docs/index.md) module,
so users can log in to your Drupal site with their Bitbucket account. It is a
provider *plugin*: on its own it does nothing, but paired with the base module it
lights up "log in with Bitbucket".

Under the hood it supplies a single provider plugin that wraps the
`stevenmaguire/oauth2-bitbucket` League library. It configures the client ID,
secret, and redirect URI from its own settings, requests the `email` and
`repository` OAuth scopes, resolves the username from the Bitbucket resource
owner, and fetches the user's primary email from the Bitbucket API
(`/2.0/user/emails`) so it can match or create the right Drupal account. All the
actual OAuth mechanics — the authorize redirect, the callback, the state/CSRF
handling, and account provisioning — live in the **base** module; this plugin
only provides Bitbucket‑specific endpoints and field mapping.

This plugin itself does not weaken TLS — token exchange and API calls use the
League library's default (secure) HTTP client.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   plugin alongside League OAuth Login.
2. [Configuration](configuration/index.md) — register a Bitbucket OAuth consumer
   and enter its client ID, secret, and redirect URI.

## Where it lives in the admin menu

This submodule adds no page of its own; you configure the Bitbucket provider from
the League OAuth Login configuration, entering the client ID, client secret, and
redirect URI for Bitbucket there.
