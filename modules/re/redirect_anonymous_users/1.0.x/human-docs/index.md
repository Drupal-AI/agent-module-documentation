# Redirect anonymous users — manual setup guide

**Redirect anonymous users** (`redirect_anonymous_users`) makes a whole site
private in the simplest way possible: every request from a not-logged-in visitor
is sent to the login page, except for an allow-list of routes you nominate. It is
a lightweight way to lock a site — a staging or pre-launch environment, an
internal tool, a members-only site — behind login without writing per-node access
rules.

Under the hood it is a single request subscriber. On every request, if the
current user is anonymous and the route is neither the login form nor one of your
excluded routes, the module issues a 302 redirect to the login page and stops.
The redirect target is hard-coded to Drupal's own login route, so there is no
open-redirect risk — a visitor can never be bounced to an attacker-supplied URL.

The one thing to understand before you enable it is the **allow-list**, because
the default is aggressive: out of the box only the login form is reachable, and
**everything else** — password reset, self-registration, REST/JSON:API
endpoints, cron, well-known files — redirects to login. You make those reachable
again by adding their route *names* to the exclusion list. The subscriber also
fires on POST requests and does not exempt system routes automatically, so an
incomplete list is the usual cause of a "broken" flow (for example, users unable
to reset a password). Get the allow-list right and the module is exactly the
blunt, reliable private-site gate it advertises.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build the exclusion allow-list so the
   routes anonymous users legitimately need still work.

## Where it lives in the admin menu

The settings form is at
`/admin/people/redirect_anonymous_users/settings` (route
`redirect_anonymous_users.settings`), reachable by a user with the **administer
redirect_anonymous_users configuration** permission. Because the module locks the
site the moment it is enabled, plan to visit this form immediately after
enabling — see [Configuration](configuration/index.md).
