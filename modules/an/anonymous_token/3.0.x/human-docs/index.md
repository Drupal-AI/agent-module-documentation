# Anonymous Token — manual setup guide

**Anonymous Token** (`anonymous_token`) extends Drupal core's CSRF (anti–cross‑site
request forgery) token system so tokens also work for **anonymous, not‑logged‑in
users** — something core does not do out of the box, because an anonymous session
normally isn't persisted.

If you have a route that anonymous visitors reach and that changes state — a
one‑click confirm/unsubscribe link, an AJAX callback, a decoupled endpoint — core's
CSRF token isn't usable there. This module fills that gap: it forces a persistent
anonymous session so a CSRF seed can be stored, then reuses core's own crypto
(an HMAC over the site private key plus the session seed) to generate and validate
tokens for anonymous users. It is a **hardening / defensive** module — it does not
grant access to anything; it only adds protection you can opt into.

Nothing is wired up automatically in this version. You opt in **per route** by adding
a requirement to the route and generating a matching token where you build the link
or form. An optional single‑use setting makes each token valid only once, so a
replayed token fails. The module adds one permission and one small settings form.

This guide is written for a **human** setting it up. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, the single‑use
   option, the permission, and how to wire a route.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Anonymous CSRF Token**
(`/admin/config/system/anonymous-csrf-token`), gated by the **Administer anonymous
csrf token** permission. Note that the settings form only exposes one toggle — the
real work of protecting a route is done in code (see
[Configuration](configuration/index.md)).
