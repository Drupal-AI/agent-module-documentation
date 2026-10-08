# OAuth2 Client — manual setup guide

**OAuth2 Client** (`oauth2_client`) lets your Drupal site act as an OAuth2
*client* — that is, the side that logs in to *someone else's* OAuth2 service to
get an access token and call their API. It handles the fiddly parts of the OAuth2
dance for you: fetching an access token, refreshing it when it expires, storing
it, and clearing it, all built on the well‑known `league/oauth2-client` PHP
library.

It is primarily a **developer toolkit**, with two moving parts. First, a
developer describes each remote provider (its authorization and token URLs, which
grant type to use, scopes, and so on) as a small **client plugin** in code. Four
standard grant types ship ready to use: **authorization code** (the interactive
"log in with…" flow), **client credentials** (machine‑to‑machine), **resource
owner** (username/password), and **refresh token**. Second — and this is the part
you do in the admin UI — you create an **OAuth2 client** configuration entity that
pairs one of those plugins with the actual credentials (client id and secret) for
your account on that provider. At runtime, code calls the module's service to get
a token and make authenticated requests.

The important security detail is where the credentials live. The client id and
secret are deliberately **not** stored in the configuration entity itself, so they
never end up in exported configuration. Instead the entity points at either
Drupal's **State** store or — the recommended option — a **Key** entity from the
Key module, which can read the secret from an environment variable. Keep secrets
in environment variables and reference them through a Key; never paste them into
plain configuration.

OAuth2 Client requires a recent stack — **PHP 8.3+** and **Drupal 11.4 or 12** —
and the `league/oauth2-client` library, which Composer installs for you. An
optional `oauth2_client_example_plugins` submodule ships four working example
plugins you can read and copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including how to write
client and grant‑type plugins and call the runtime service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the OAuth2
   library with Composer, and enable it (plus optional Key and example modules).
2. [Configuration](configuration/index.md) — creating and managing an OAuth2
   client, and where to keep its credentials safely.

## Where it lives in the admin menu

Once enabled, the client list sits at **Configuration → System → OAuth2 Client**
(`/admin/config/system/oauth2-client`), gated by the **Administer oauth2 clients**
permission. This is where you add, edit, enable, and disable OAuth2 clients.

## How to use it

A developer first writes a client plugin describing the provider (see the
`agent/` docs and the example‑plugins submodule for how). Then, in the admin UI,
you add an OAuth2 client that references that plugin and points at the stored
credentials — ideally a Key entity backed by an environment variable. Finally,
application code calls the `oauth2_client.service` service to get, refresh, or
clear the access token. See [Configuration](configuration/index.md) for the
admin‑UI steps.
