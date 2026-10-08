# Prevent Unsafe Login — manual setup guide

**Prevent Unsafe Login** (`prevent_unsafe_login`) disables the Drupal user login
form whenever the current request is *not* served over HTTPS, so a username and
password can never be POSTed over a plaintext connection.

The scenario it guards against is common and easy to fall into: you copy a live
site to a development environment, work on it over plain `http://`, and log in with
your real admin credentials out of habit. Those credentials just travelled in the
clear — and if they're the same ones your production site uses, production is now
potentially compromised. This module stops that mistake at the form.

When the request scheme isn't `https`, the module disables all the login form's
fields and prepends a short message explaining that login over a non‑HTTPS
connection is forbidden, pointing you toward a one‑time login link or `drush uli`
instead. It runs its check *last* among form alterations so it reliably overrides
other modules' changes to the login form, and it caches the HTTPS and non‑HTTPS
versions of the form separately so the right variant is always served.

> **Scope: this protects the login form specifically.** It is defense‑in‑depth,
> not a site‑wide HTTPS policy. It does **not** force HTTPS everywhere, redirect
> `http://` to `https://`, or affect already‑authenticated sessions. Pair it with
> server‑ or Drupal‑level HTTPS redirection (and HSTS) for full coverage. On a dev
> box without HTTPS you can still get in with `drush uli`.

There are no routes, no permissions, and **no configuration** — enabling the
module is all it takes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. See "How to use
it" below.

## How to use it

Enable the module; the protection is immediate and needs no setup. From then on, if
anyone reaches the login form over plain `http://`, the form's fields are disabled
and a message explains that plaintext login is blocked.

If you genuinely need to log in on an environment that has no HTTPS (a local dev
site, say), use `drush uli` to generate a one‑time login link — that path still
works. For production, make sure real HTTPS enforcement (a redirect and HSTS) sits
in front of this module so users never land on the `http://` login page in the
first place.
