# Permissions by Term Redirect — manual setup guide

**Permissions by Term Redirect** (`permissions_by_term_redirect`) improves the
experience of the
[Permissions by Term](https://www.drupal.org/project/permissions_by_term) access
system. When an anonymous visitor lands on a node they are not allowed to see
because of a term restriction, Drupal would normally show a bare "Access Denied"
page. With this module, that visitor is sent to the login form instead — and
after they log in, they are taken straight back to the exact page they originally
wanted.

For membership sites and gated content, that small change matters. It turns a
dead-end 403 into a natural "log in to continue" flow, which is far friendlier for
anonymous users following a deep link to protected, taxonomy-tagged content, and
tends to reduce both drop-off and support requests about mysterious "access
denied" pages.

Under the hood it listens for Permissions by Term's access-denied event. When the
denied node is the one the anonymous user is actually trying to reach, it
remembers that node in a short-lived cookie and redirects to the login page; on
successful login it reads the cookie and returns the user to that node, where
Permissions by Term re-checks access as normal. It deliberately does **not**
redirect authenticated users who are denied (they simply get the standard Access
Denied, avoiding a redirect loop), and it skips the redirect during
password-reset flows. Importantly, this module changes only the redirect
behaviour — all the real access enforcement stays in Permissions by Term, and the
return target is always an internal node route, so there is no open-redirect
risk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its dependencies.

There is **no settings form and no permissions** to configure — the module works
automatically once enabled.

## How to use it

There is nothing to switch on beyond enabling the module (and its dependencies).
Once active, any anonymous visitor who hits a Permissions by Term–restricted node
is sent to the login form and returned to that node after logging in. Your
existing Permissions by Term term restrictions continue to define *what* is
protected; this module only changes what happens at the moment of denial.
