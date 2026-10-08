# CAS Server — manual setup guide

**Central Authentication System (CAS) Server** (`cas_server`) makes your Drupal site
act as a **CAS identity provider** — a single sign‑on (SSO) login server. Other
applications ("services") send their users to your Drupal site to log in, and Drupal
issues and validates CAS tickets that tell each application who the user is (plus,
optionally, some of their profile fields as "attributes"). It implements the CAS 1.0,
2.0, and 3.0 protocols on top of Drupal's normal user accounts.

In practice you register one or more **service definitions**. Each one has a URL
pattern that incoming requests must match, so only applications you've listed can use
your login server. A user who visits `/cas/login?service=<app‑url>` logs in with
their Drupal credentials and is bounced back to the application with a short‑lived,
single‑use **service ticket**; the application then calls one of Drupal's `…Validate`
endpoints to exchange that ticket for the username (and any released attributes) as
XML or JSON. Optional single sign‑on keeps a returning user logged in across several
services without re‑prompting, and per‑service role restrictions let you say which
Drupal roles may log in to which application.

This is a **security‑sensitive** module: it is the login authority for every
connected application. Because of that:

- It **must run over HTTPS**.
- Do **not** enable it on the same site as the CAS *client* module (they do opposite
  jobs).
- Treat the "log in to any service" permission and broad URL patterns (like
  `https://*`) as powerful — keep service patterns tight.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   (and the optional attributes submodule), and the HTTPS/CAS‑client cautions.
2. [Configuration](configuration/index.md) — the global settings, registering
   service definitions, and the permissions.

## Where it lives in the admin menu

The settings live under **Configuration → People → CAS Server**
(`/admin/config/people/cas_server`), with global settings at
`/admin/config/people/cas_server/settings` and the list of service definitions at
`/admin/config/people/cas_server/services`. All of it requires the **Administer site
configuration** permission. The protocol endpoints themselves live under `/cas/*`.

## How to use it

1. Make sure the site is served over **HTTPS** and that the CAS *client* module is
   **not** installed.
2. Enter the global settings (ticket lifetimes, which attribute is used as the
   username, messages, and so on) at
   **Configuration → People → CAS Server → Settings**.
3. Register at least one **service definition** for each application that will
   delegate login to Drupal, giving it a URL pattern and choosing which user fields
   (if any) to release and which roles may use it.
4. Point the external application's CAS client at your `/cas` endpoints.

See [Configuration](configuration/index.md) for the full field‑by‑field details.
