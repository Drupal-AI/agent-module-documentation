# Configuration

Open the settings form at **Configuration → Web services → JSON:API Frontend**
(`/admin/config/services/jsonapi-frontend`). The most important thing to set here
is the secret that protects the routes feed.

## Set the routes-feed secret

The **routes feed** (`/jsonapi/routes`) is protected by a secret. The module
compares the secret the caller presents against the one you configure, using a
constant-time comparison, and — importantly — it **fails closed when no secret is
set**. In other words, until you set a secret the routes feed is not exposed at
all.

So, to use the routes feed:

1. Set a strong, random secret in the settings form and save it.
2. Configure your front end to present that secret when it requests
   `/jsonapi/routes`.

Treat the secret like any other credential: keep it out of version control, rotate
it if it may have leaked, and give it enough entropy that it can't be guessed.

## The resolver endpoint

The resolver (`/jsonapi/resolve`) is reachable without a secret, but it is guarded
by Drupal's own access checks: it resolves aliases, redirects, Views pages, and
language, and it runs a view-access check on the target. Restricted or unpublished
content comes back as "not found", so the resolver never reveals content the caller
isn't permitted to see. There's nothing you must switch on for that protection — it
is built in.

## A reminder about data access

These endpoints handle routing and a guarded routes feed. The actual entity data
your front end then fetches is still served by core JSON:API, which enforces its
own entity and field access. Keep those permissions correct as well — this module
layers on top of them rather than replacing them.

## Add-ons

If you use companion modules such as **JSON:API Frontend Layout Builder**, they
plug into this same resolver and its access/negotiation logic — install and
configure them per their own guidance once the base module's secret is set.
