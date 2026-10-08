# Social Auth Telegram — manual setup guide

**Social Auth Telegram** (`social_auth_telegram`) lets people register and sign in
to your Drupal site with their **Telegram** account, using Telegram's official
login widget. When someone authenticates, the module provisions a new account or
links Telegram to their existing one. It is built on the **Social Auth** framework
and depends on the `social_auth` module. There are no submodules.

Under the hood it uses a modern **OpenID Connect (OIDC) flow with PKCE**, plus
nonce and OAuth-`state` (CSRF) validation — all constant-time compared — so the
login flow is well protected against the usual OAuth pitfalls. Because it relies on
Telegram's login widget and bot platform, setup revolves around creating a Telegram
**bot** and telling it which domain your site runs on.

The module does nothing until you register a Telegram bot with **@BotFather**,
authorise your domain, and enter the bot's **access token** into Drupal. Treat that
token as a secret — the recommended approach is to keep it in an environment
variable rather than in exported configuration. A couple of practical quirks are
worth knowing up front: a Telegram bot treats `www.` and non-`www` as **different
sites**, so pick one canonical domain and redirect the other; and in this version,
authentication errors are not shown to the user (a failed login just returns to the
login form), so check your logs when debugging.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — create the Telegram bot, authorise
   your domain, and enter the bot token.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API settings → User
authentication → Telegram**
(`/admin/config/social-api/social-auth/telegram`). To show the login control you
render the module's `social_auth_telegram_link` theme wherever you want the button
to appear.
