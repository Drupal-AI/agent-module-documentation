# Anonymous Redirection — manual setup guide

**Anonymous Redirection** (`anonymous_redirection`) forces visitors to log in
before they can see the site. It watches incoming requests and, whenever the
request comes from an anonymous (logged‑out) user, redirects them to the login
page at `/user/login`. In effect it turns a normally public Drupal site into a
login‑required one.

It is deliberately a **coarse, blanket gate**. It redirects *all* anonymous traffic
to a *fixed* destination (`/user/login`) — the target is not taken from the
request, so there is no open‑redirect risk. It is not per‑content access control:
your content is still governed by Drupal's normal permissions; this module simply
funnels every logged‑out visitor to the login form before they get anywhere.

Two things to keep in mind when you enable it:

- The **login, password‑reset, and registration** routes must remain reachable by
  anonymous users — otherwise nobody can actually authenticate. Make sure those
  paths are excluded from the redirect.
- Because it affects every anonymous request, test it carefully before relying on
  it, especially alongside other access modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module works through an event subscriber rather than a prominent settings page,
so there is no dedicated menu item highlighted in its documentation. After
enabling, confirm the authentication paths (login, password reset, registration)
are excluded so anonymous visitors can still sign in.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Verify that anonymous users are redirected to `/user/login` when they try to
   view any page.
3. Confirm the login, password‑reset, and registration paths are excluded so
   people can authenticate.

Once enabled, the whole site is effectively login‑required for anonymous visitors.
