# REST & JSON API Authentication — manual setup guide

**REST & JSON API Authentication** (`rest_api_authentication`), by miniOrange,
locks down your site's **REST** and **JSON:API** endpoints so they can only be
reached by callers who present valid credentials. Out of the box, a fresh Drupal
site can serve JSON:API data to anyone who knows the URL; this module puts an
authentication check in front of that traffic, requiring an **API key**, **Basic
Auth**, **OAuth**, or **JWT** before an API request is served.

It works by registering a Drupal **authentication provider** that runs ahead of
core's own providers. When you flip its master switch on, the provider claims any
request whose URL contains `/jsonapi/` or a `?_format=` query — that is, the API
data endpoints — while leaving ordinary HTML page requests completely untouched.
The JSON:API admin configuration page is deliberately excluded, and `/user/login`
is always let through so clients can still obtain a session. Every authentication
attempt, success or failure, is written to an audit-log table you can review in the
admin UI, and a public revoke endpoint lets you invalidate tokens.

The module has **no Composer dependencies** and adds no permissions of its own —
its admin forms are gated by the core *Administer site configuration* permission.
All of its state lives in a single configuration object,
`rest_api_authentication.settings`. The free version covers the API-key and Basic
Auth methods plus audit logging; **OAuth, JWT, headless SSO, and multiple
applications are premium miniOrange features**. Because the API key and Basic Auth
credentials are secrets, keep them in environment variables rather than in
committed configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn protection on, choose an
   authentication method, set the token, and review the audit logs.

## Where it lives in the admin menu

The settings live under **Configuration → People → REST & JSON API
Authentication** (`/admin/config/people/rest_api_authentication/auth_settings`).
From there you reach the main auth settings, advanced settings, headless SSO
(premium), the audit logs, and the upgrade-plans page.

## How to use it

Enabling the module does not protect anything by itself — nothing changes until you
turn on the master switch in [Configuration](configuration/index.md). Once
protection is on, configure the authentication method and its credential (for
example, an API token for the API-key method), then have your API clients send that
credential on every request to `/jsonapi/…` or `?_format=…` endpoints. Requests
without valid credentials are rejected with a JSON error, and each attempt is
logged.
