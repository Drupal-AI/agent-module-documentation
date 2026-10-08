# OpenID Connect OSP Client (CILogon/Globus) — manual setup guide

**OpenID Connect OSP Client (CILogon/Globus)** (`cilogon_globus_auth`) adds
ready-made login buttons for two identity federations widely used in research and
higher education: **CILogon** and **Globus Auth** (branded here as "One Science
Place / OSP"). Rather than making you hand-configure a generic OpenID Connect
provider, it ships purpose-built client plugins with the correct endpoints, scopes,
and claims already filled in — you supply your client ID and secret and register a
redirect URI, and users can log in through CILogon or Globus.

It is built **on top of the [OpenID Connect](https://www.drupal.org/project/openid_connect)
contrib module**, which is a hard dependency. This is an important security point:
all the sensitive protocol mechanics — the OAuth `state` parameter / login-CSRF
protection, the token exchange, and mapping the remote identity to a Drupal user —
are handled by the trusted `openid_connect` module, not reimplemented here. This
module contributes the provider endpoints and claims, some custom session and
logout behavior (it can store Globus transfer tokens under a dedicated session key
and, by default, adjusts `/user/logout` to end only the local Drupal session), and
a small set of UI controls for the login buttons and help text. It also improves
the **Connected Accounts** screen so it shows *which* identity provider an account
is connected to.

Setup happens in two places: you configure the CILogon/Globus **clients** in the
OpenID Connect UI (**Configuration → People → OpenID Connect**), and you tune the
**login button/help text** in this module's own settings form
(`/admin/config/people/cilogon-globus-auth`). To show real cases you need active
apps/credentials registered with CILogon and/or Globus.

> **Security essentials.** Store the OAuth **client ID and secret as secrets** — use
> an environment variable and, ideally, the **Key** module to hold the client
> secret rather than pasting it into plain config. Always serve the site over
> **HTTPS**, and keep `openid_connect` updated, since its `state` handling is your
> login-CSRF defense. If you use the Globus transfer-token support, treat those
> tokens as sensitive credentials. Note this project is **not covered by Drupal's
> security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with
   openid_connect), optionally add the Key module, and enable it.
2. [Configuration](configuration/index.md) — set up the CILogon/Globus clients,
   register the redirect URI, and customize the login buttons.

## Where it lives in the admin menu

- The CILogon and Globus **clients** are configured at **Configuration → People →
  OpenID Connect** (`/admin/config/people/openid-connect`), provided by the
  openid_connect module.
- This module's own **login UI settings** (button text and help text) live at
  **Configuration → People → CILogon/Globus Auth**
  (`/admin/config/people/cilogon-globus-auth`).
