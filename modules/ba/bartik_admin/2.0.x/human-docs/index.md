# Bartik Admin — manual setup guide

**Bartik Admin** (`bartik_admin`) lets the classic **Bartik** look serve as an
administration theme. If you preferred Bartik's styling to Claro or Seven for
back-end work, this module brings it to the admin screens — and it does so
**per user**, so individual accounts can opt into using it rather than it being
forced on everyone.

Each user's preference is set on a small form at `/user/{user}/bartik-admin`. A
theme negotiator then applies the Bartik-style admin theme for the users who
opted in, while everyone else keeps the site's normal admin theme. The front-end
theme is never touched. It requires no external libraries and runs on Drupal 8, 9
and 10.

The per-user form is access-controlled: the route is restricted to the
`administrator` role plus a custom access check on top, so it is not exposed to
anonymous users. In practice this means administrators control who can turn the
Bartik admin theme on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives / how to use it

There is no central settings page. The preference is set per account at
**`/user/{user}/bartik-admin`** — visit that path for the user you want to switch
(the route is limited to the `administrator` role plus a custom access check).
Opt the account in, and from then on that user sees Bartik's styling on
administration pages. Other users are unaffected, and the site's front-end theme
stays exactly as it was.
