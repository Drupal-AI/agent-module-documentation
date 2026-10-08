# Keycloak OpenID Connect — manual setup guide

**Keycloak OpenID Connect** (`keycloak`) lets a Drupal site authenticate its
users against a **Keycloak** identity server. It is not a standalone login
system — it is a plugin for the **OpenID Connect** module (`openid_connect`) that
adds a Keycloak‑specific client. Because the plugin understands Keycloak's URL
scheme, you only enter a **base URL** and a **realm**, and it works out the
authorization, token, userinfo, logout, and session endpoints for you instead of
making you fill in five separate URLs.

Each connection is stored as an OpenID Connect *client* — you can run several,
for example one per realm. Beyond basic login, the module can do a lot more: it
can replace the Drupal login form with an automatic redirect to Keycloak (SSO),
propagate logout in both directions so signing out of Drupal ends the Keycloak
session and a Keycloak‑side logout ends the Drupal session, forward the active
interface language to Keycloak's login screens, pass an identity‑provider hint to
pre‑select a broker, and — importantly — automatically grant and revoke Drupal
roles based on a user's Keycloak groups or roles using ordered mapping rules.

The module does nothing until you create and enable a Keycloak client under
**OpenID Connect**, and it needs a real, reachable Keycloak server to actually
authenticate anyone. This guide is written for a **human** setting it up through
the admin UI. If you want terse, token‑cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and OpenID
   Connect) with Composer and enable it.
2. [Configuration](configuration/index.md) — set up your Keycloak realm and
   client, create the Drupal client, and enable SSO, single sign‑out, i18n, and
   group‑to‑role mapping.

## Where it lives in the admin menu

Keycloak has no settings form of its own. You manage its clients through OpenID
Connect at **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`). Two routes, `keycloak/login` and
`keycloak/logout`, act as the SSO entry and exit points.

## How to use it

First set up a client in your Keycloak realm and note its client id and secret.
Then, in Drupal, add an OpenID Connect client, choose the **Keycloak** plugin,
and enter the client id, secret, server base URL, and realm. Turn on whichever
features you need — SSO redirect, single sign‑out, language forwarding, and
group‑to‑role mapping — and test a login. See
[Configuration](configuration/index.md) for the field‑by‑field walkthrough.
