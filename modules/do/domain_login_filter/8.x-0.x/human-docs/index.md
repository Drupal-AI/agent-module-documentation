# Domain Login Filter — manual setup guide

**Domain Login Filter** (`domain_login_filter`) prevents users from logging in on a
domain they are not assigned to, based on their
[Domain](https://www.drupal.org/project/domain) (Domain Access) assignments. On a
multi-domain site — one Drupal installation serving several hostnames — it lets you
scope *interactive login* so that a user can only sign in on the domains they
belong to.

The module adds a validation handler to the sign-in form (and to the password-reset
request form) that compares the **active domain** against the **user's Domain Access
values**. If the current domain is not among the user's assigned domains, the handler
sets a form error ("The username *name* has not been activated or is blocked on this
domain.") and that form submission does not complete. Because the check runs as
validation on those forms, treat it as one layer of a multi-domain setup rather than
your only access control (see scope below).

It is important to understand the exact scope. This module gates **who can log in on
which domain**; it is not a replacement for per-domain *content* access. Domain
Access's node grants (and related modules) still handle what content each domain
shows. Domain Login Filter complements those by controlling the authentication
step itself.

Because the behavior is driven entirely by each user's Domain Access assignments,
there is no settings form to fill in — the module works as soon as it is enabled.
The "configuration" you do is making sure users' domain assignments are correct,
since those assignments are exactly what decide who may log in where.

Note that this project is **not covered** by Drupal's security advisory policy, so
weigh that against your site's needs before relying on it as a security control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside the
   Domain module) and enable it.

There is **no settings form** for this module. It works on enable; the only setup
is ensuring users' domain assignments are correct, described in "How to use it"
below.

## Where it lives in the admin menu

Domain Login Filter adds no admin page of its own. The relevant configuration is
each user's **Domain Access assignments**, which you set on the user account (or in
bulk via Domain Access) — those assignments determine which domains each user may
log in on.

## How to use it

1. Make sure the **Domain** (Domain Access) module is configured with your domains
   created and users assigned to the domains they belong to.
2. Enable Domain Login Filter (see [Installation](installation/index.md)).
3. From then on, a user attempting to log in on a domain they are not assigned to
   is blocked with a form error, and authentication does not complete.
4. To change who can log in where, adjust the users' domain assignments — that is
   the sole lever this module acts on.
