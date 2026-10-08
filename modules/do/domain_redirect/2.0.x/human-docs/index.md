# Domain Redirect — manual setup guide

**Domain Redirect** (`domain_redirect`) makes the **Redirect** module
domain-aware, so the same source path can redirect to different destinations
depending on the active domain. It belongs to the **Domain** ecosystem and depends
on both the `domain` module (3.x) and the **Redirect** module (1.x).

Rather than add its own admin section, this module quietly extends the redirect
you already know. It adds a **Domain** field to each redirect, so you can scope a
redirect to a specific domain or leave it global (all domains). When the same
source path has both a domain-specific and a global redirect, the
**domain-specific one wins**. The redirect admin listing gains a *Domain* column
and an exposed filter so you can see and narrow redirects by domain, and its
duplicate-detection is relaxed so the same source path can legitimately have
different redirects on different domains.

It works essentially on enable — **no configuration is needed** to switch it on.
Redirects are admin-configured trusted input (as in the Redirect module), so this
is not an open-redirect surface, and the module has no access-control role of its
own; it simply makes redirect *routing* domain-sensitive. Note that version 2.x is
a complete rewrite with no upgrade path from the old 7.x/8.x versions, which used
custom `/domain-redirect/…` paths; 2.x integrates with the Redirect module
instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain and Redirect.
2. [Configuration](configuration/index.md) — scope redirects to a domain from the
   Redirect module's own form.

## Where it lives in the admin menu

There is no separate settings page. You work entirely within the Redirect module's
listing at **Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`), where a new *Domain* field and filter now
appear.
