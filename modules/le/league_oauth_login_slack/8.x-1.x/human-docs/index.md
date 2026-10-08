# League OAuth Login Slack — manual setup guide

**League OAuth Login Slack** (`league_oauth_login_slack`) adds **Slack** as a
sign‑in source for the
[League OAuth Login](../../league_oauth_login/2.0.x/human-docs/index.md) module,
so users can log in to your Drupal site with their Slack account. It is a provider
*plugin*: on its own it does nothing, but paired with the base module it lights up
"log in with Slack".

The plugin supplies the Slack OAuth2 provider configuration — the endpoints and
identity mapping specific to Slack. Everything else, the entire login flow (the
redirect out to Slack, the callback, the token exchange, and account
provisioning), lives in the **base** `league_oauth_login` module. You enable this
plugin, register a Slack OAuth app, and enter its client ID, client secret, and
redirect URI in the League OAuth Login configuration.

Store the Slack **client secret** as a secret and always serve the site over
**HTTPS**. This plugin adds no access‑control logic of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   plugin alongside League OAuth Login.
2. [Configuration](configuration/index.md) — register a Slack OAuth app and enter
   its client ID, secret, and redirect URI.

## Where it lives in the admin menu

This submodule adds no page of its own; you configure the Slack provider from the
League OAuth Login configuration, entering the client ID, client secret, and
redirect URI for Slack there.
