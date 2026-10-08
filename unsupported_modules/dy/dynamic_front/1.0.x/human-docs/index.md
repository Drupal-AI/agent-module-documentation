# Dynamic front — manual setup guide

**Dynamic front** (`dynamic_front`) makes your site's front page redirect each
visitor to the **first URL, from an ordered list you configure, that they are allowed
to access**. It's built for sites where users have multiple roles and the "home page"
should differ depending on who's looking — for example, you might configure several
Views with different access rules, and this module sends each user to the first one
available to them.

You give the module an ordered list of internal paths (say `/dashboard`, `/welcome`).
When someone lands on the front page, the module walks that list top to bottom,
checks access on each candidate, and redirects to the first one the current user may
view. If none qualify, access is denied. Every candidate is access‑checked *before*
the redirect, so a visitor is only ever sent somewhere they're actually permitted to
see — there's no open‑redirect or access bypass here.

> **Important — this module is deprecated / obsolete.** Its maintainers mark it
> **unsupported** and point users to its successor, **[Dynamic
> Links](https://www.drupal.org/project/dynamic_links)** (`dynamic_links`), for new
> sites. Prefer that project going forward; use this guide mainly to understand or
> maintain an existing installation.

A couple of practical notes: the module **requires PHP 8.0+**, it provides its own
**View dynamic front** permission (which you grant to the roles that should be
redirected), and it **disables the core "front page" field** on the Basic site
settings form, pointing you to its own settings instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permission.
2. [Configuration](configuration/index.md) — list the candidate front‑page paths in
   priority order.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Dynamic front**
(`/admin/config/system/dynamic-front`), where you enter the ordered list of candidate
paths. Because the module takes over the front page, the core front‑page field on the
Basic site settings form is disabled while it's enabled.
