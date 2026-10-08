# Health Checker — manual setup guide

**Health Checker** (`healthchecker`) gives your site a lightweight **health-check
endpoint** — a single page that responds with a small JSON status string so
external monitoring services, load balancers, and orchestrators can probe whether
the site is up. Instead of hitting your homepage (which is heavy and can pass even
when parts of the site are broken), a monitor pings this dedicated endpoint and
gets a quick, minimal answer.

The endpoint's path is configurable — it defaults to `/health-check`, but you can
set it to whatever you like, such as `/site-up`. It responds with a JSON status
that can optionally include a **timestamp**. That's the whole feature: a clean,
predictable liveness probe you point your uptime monitor at.

On the security side, the endpoint returns only a minimal status — no version
numbers, no sensor detail — so exposing it publicly reveals nothing beyond "the
site responds," which is exactly what a monitor needs. If you'd still rather not
expose it openly, you can gate it behind the module's permission or simply use a
non-obvious path. It has no access-control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — setting the endpoint path and the
   timestamp option, then pointing your monitor at it.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → Development → Health
Checker Settings** (`/admin/config/development/healthchecker`). See
[Configuration](configuration/index.md).
