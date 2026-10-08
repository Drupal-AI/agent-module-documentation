# Feide Login — manual setup guide

**Feide Login** (`feide_login`) lets people sign in to your Drupal site with
**Feide** — the Norwegian national identity provider used across education and
research. Instead of maintaining a separate Drupal username and password, a user
clicks "Log in with Feide", authenticates on Feide's own login screen, and is
returned to your site already logged in.

Under the hood the module runs a standard **OAuth 2.0 authorization‑code flow**.
When the user returns from Feide, the module reads their Feide profile and maps
them to a Drupal account **by email address** using the
[External Authentication](https://www.drupal.org/project/externalauth)
(`externalauth`) module. If no matching account exists yet, it can optionally
**auto‑register** one. Your Feide application's client credentials are held with
the [Key](https://www.drupal.org/project/key) module, so the client secret lives
in an environment variable rather than in configuration or code.

The trust model is the usual one for federated single sign‑on: you register an
application with Feide, Feide gives you a client ID and client secret, and your
site trusts the identity Feide asserts on the callback. That makes the callback
the sensitive part of the flow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its ExternalAuth and Key dependencies.
2. [Configuration](configuration/index.md) — register your Feide application,
   store the client secret safely with Key, and wire up user mapping.

## How to use it

Once installed and configured, Feide Login adds a "Log in with Feide" entry point
to your site. A visitor who chooses it is redirected to Feide, authenticates
there, and is sent back to the module's `/feide_redirect` callback, which finalises
the Drupal login through ExternalAuth (creating the account first if
auto‑registration is enabled). Day‑to‑day there is nothing more for an editor to
do — the work is all in the one‑time setup covered in
[Configuration](configuration/index.md).
