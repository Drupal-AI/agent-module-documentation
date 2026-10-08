# Simple OAuth Refresh Token Buffer — manual setup guide

**Simple OAuth Refresh Token Buffer** (`simple_oauth_refresh_token_buffer`) solves
a specific, annoying race condition in OAuth token refresh. The
[Simple OAuth](https://www.drupal.org/project/simple_oauth) module rotates refresh
tokens by default: the first request that uses a refresh token gets a new pair of
tokens, and the old refresh token is immediately invalidated. That is good
security — but in a modern web app, several independent requests can fire at
almost the same moment and all try to refresh the *same* expired token. Only the
first succeeds; the rest fail because the token they are holding was just rotated
away, and the user sees errors.

This module adds a short, configurable **grace period** (a "buffer") per OAuth2
client. During that window, a repeated refresh with the same refresh token
returns the **same response** as the first successful refresh, instead of
failing. The race resolves cleanly and the user never notices. It is the same
approach used by enterprise identity providers such as Auth0 and Okta.

There is no standalone settings form. The grace period is set **per client** on
the Simple OAuth consumer, so you can tune it (or leave it off) for each
application. The module depends on **Simple OAuth** and has no submodules.

This is a reliability feature with a security dimension, so keep the buffer window
**short**. It is meant to be a brief tolerance window for concurrent requests, not
a way to make refresh tokens reusable for a long time — a short window resolves
races while preserving the single-use spirit of refresh-token rotation. The
module's default of 30 seconds is a sensible balance; the allowed range is 1 to 60
seconds.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no central admin page for this module. The grace period is configured on
each OAuth2 client:

1. Go to **Configuration → Web services → Consumers**
   (`/admin/config/services/consumer`) and edit the consumer (client) you want to
   protect.
2. Set its **grace period** — a value between **1 and 60 seconds** (default
   **30**). This is how long after a successful refresh a repeated refresh with
   the same token will return the same buffered response.
3. Save the consumer.

From then on, when that client fires several simultaneous refresh requests, the
first one succeeds normally and the others — within the grace period — receive the
same tokens instead of an error. Keep the value low; a longer window weakens the
single-use nature of refresh tokens for little extra benefit.
