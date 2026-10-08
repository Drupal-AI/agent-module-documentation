# Redirect 403 to User Login — manual setup guide

**Redirect 403 to User Login** (`r4032login`) fixes a small but common annoyance:
when an anonymous visitor hits a page they are not allowed to see, Drupal shows a
bare "Access denied" (HTTP 403) page. This module catches that response and sends
the visitor to the login form instead — and, if you like, returns them to the page
they originally wanted once they have logged in.

It works by registering a kernel exception subscriber that watches for 403
responses on normal HTML page requests. For an anonymous user it redirects to a
configurable login path (default `/user/login`) and can append the original path
as a `destination` query parameter so the user lands back where they started after
login. It can also show a friendly access‑denied message on the login page, with a
selectable message style (error, warning, or status).

Authenticated users are handled separately, so you can tune their experience
independently: redirect a logged‑in user who lacks access to a chosen page
(including the front page), or throw a 404 instead of a 403 to hide that the
resource even exists, and show them their own message. Finer controls let you set
the redirect HTTP status code (307 by default, or 302/301), add an
`X-Robots-Tag: noindex` header, and keep a path allow/deny list so specific paths
(like `/admin/*`) skip the redirect. Everything is stored in the
`r4032login.settings` config object, so it deploys cleanly across environments,
and a `RedirectEvent` lets other modules alter the target — handy for integrating
with external login systems such as CAS, Shibboleth, or OAuth. It needs nothing
beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the three settings tabs (general,
   anonymous, authenticated), field by field.

## Where it lives in the admin menu

The settings live at **Configuration → System → Redirect 403 to User Login**
(`/admin/config/system/r4032login/settings`), split across three tabs. You need
the **Administer r4032login** permission to reach them.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → System → Redirect 403 to User Login** and confirm the
   login path and destination behavior suit your site — see
   [Configuration](configuration/index.md).
3. Test it: log out, visit a page anonymous users cannot see, and confirm you are
   sent to the login form and returned afterwards.
