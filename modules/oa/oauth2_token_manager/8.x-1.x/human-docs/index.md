# OAuth2 Token Manager — manual setup guide

**OAuth2 Token Manager** (`oauth2_token_manager`) is a small API module that
handles the OAuth2 "dance" for you — obtaining, storing, and refreshing OAuth2
access and refresh tokens so that Drupal can make authenticated calls to a
third‑party OAuth2 provider. It is aimed at connecting **system accounts** (the
site itself, not individual visitors) to external services, so other modules can
talk to those APIs without each re‑implementing the token exchange.

The project ships a base module plus ready‑made implementations for three popular
services — **Box**, **Slack**, and **Quip**. Each implementation reads its client
credentials from environment variables rather than from a settings form, which
keeps secrets out of the database and out of version control.

On the security side, the authorization‑callback controller **validates the OAuth
`state` parameter** against the value it stored when the flow began, which is the
standard CSRF protection for an OAuth exchange — an attacker cannot trick the site
into completing someone else's authorization. The client secret is read from an
environment variable, so it is never persisted in configuration. Beyond that, this
guide sticks to what the module actually does; it does not add features the code
doesn't provide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set the environment variables each provider needs.

There is **no settings form** for this module. It does not add an admin
configuration page; instead you supply each provider's credentials through
environment variables, described in "How to use it" below.

## How to use it

The module does its work programmatically — another module (yours or one of the
bundled Box/Slack/Quip implementations) asks it to fetch or refresh a token, and
the token is stored for reuse. Your job as an administrator is to make sure the
right **environment variables** are present so the module can complete the OAuth2
exchange for each provider you use.

Each provider expects a client id, a client secret, and a redirect URI:

| Provider | Environment variables |
|----------|-----------------------|
| **Box** | `BOXCOM_OAUTH_CLIENT_ID`, `BOXCOM_OAUTH_CLIENT_SECRET`, `BOXCOM_OAUTH_REDIRECT_URI` |
| **Slack** | `SLACK_OAUTH_CLIENT_ID`, `SLACK_OAUTH_CLIENT_SECRET`, `SLACK_OAUTH_REDIRECT_URI` |
| **Quip** | `QUIP_OAUTH_CLIENT_ID`, `QUIP_OAUTH_CLIENT_SECRET`, `QUIP_OAUTH_REDIRECT_URI` |

You obtain the client id, client secret, and allowed redirect URI when you
register your app in the provider's developer console (Box, Slack, or Quip). The
redirect URI you register there must match the one you set in the environment
variable and must point back at your Drupal site.

Because the client **secret** is a credential, never hard‑code it or commit it.
Store it as an environment variable — with DDEV, use its built‑in dotenv command
so the value lives in `.ddev/.env` (which you keep out of version control):

```bash
ddev dotenv set .ddev/.env --boxcom-oauth-client-secret=<value>
ddev restart
```

The flag `--boxcom-oauth-client-secret` becomes the variable
`BOXCOM_OAUTH_CLIENT_SECRET` inside the web container. Do the same for the client
id and redirect URI (and for the Slack/Quip equivalents). If you manage secrets
through the [Key](https://www.drupal.org/project/key) module elsewhere on your
site, you can keep the same discipline here — the important rule is that the
secret only ever lives in an environment variable, not in code or configuration.

Once the variables are in place and the module is enabled, the token flow works
without further clicks: the module completes the authorization, validates the
returned `state`, and stores the access/refresh tokens for the calling code to use.
