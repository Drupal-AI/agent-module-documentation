# Reserved Paths — manual setup guide

**Reserved Paths** (`reserved_paths`) stops editors and users from creating URL
aliases that collide with paths you want to keep protected. You define a list of
reserved paths, and the module rejects any content alias that matches one of them —
so a URL alias can never shadow an important route (such as `admin`, `user/login`,
or `api`) or squat on a name you are keeping free for future use. It also
integrates with the **Pathauto** module, so automatically generated aliases respect
the reserved list too.

This is a focused hardening and anti-abuse feature. It does exactly one thing, and
its coverage is precisely the list you configure — nothing more is protected
automatically, so it is worth thinking through which paths matter on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build your list of reserved paths.

## Where it lives in the admin menu

The settings form is at **Configuration → Reserved Paths**
(`/admin/config/reserved-paths`). Access is controlled by the module's own
permission.
