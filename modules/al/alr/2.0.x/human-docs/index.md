# After Login Redirect (alr) — manual setup guide

**After Login Redirect** (`alr`) lets you decide where a user lands **after they
log in** and **after they log out**. Instead of Drupal's default behaviour, you
set a destination path — for example send everyone to a dashboard when they sign
in, or to the front page (or a "you have been logged out" landing page) when they
sign out.

It is a small convenience/UX module. It changes only the redirect *destination* —
it does **not** change who is allowed to log in, and it does not touch password
checks or account access in any way.

One thing to keep in mind is a security best practice: keep your redirect targets
**internal** to your site. If a destination can ever be influenced by a value in
the URL, restrict it to internal, allow-listed paths so the login flow can't be
turned into an "open redirect" that bounces users off to an external site.
Configuring a fixed internal path, as this guide describes, avoids that entirely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the post-login and post-logout
   redirect paths.

## Where it lives in the admin menu

Once enabled, the module adds a settings form where you enter the login and logout
redirect paths. See [Configuration](configuration/index.md) for how to reach it
and what to fill in.
