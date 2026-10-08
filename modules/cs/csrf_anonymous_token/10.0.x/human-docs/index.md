# Anonymous CSRF token — manual setup guide

**Anonymous CSRF token** (`csrf_anonymous_token`) is a very small module that
tries to bring CSRF‑style token protection to forms submitted by **anonymous**
users. Drupal core adds its form build token (`#token`) only for authenticated
users; this module targets the gap by adding a hidden token element to forms that
don't already carry one. It ships as just an `.info.yml` and a `.module` file,
has no settings, and works globally on every tokenless form once enabled.

Concretely, it uses `hook_form_alter` so that any form without a core `#token`
gets an extra `anon_token` element (and it stashes the current session id in the
session). The intent is to add a per‑session token to anonymous forms such as
login, register, contact, and search.

Be aware that the added validator's internal check can raise a validation error
on otherwise‑valid submissions, so it can **break legitimate anonymous form
submissions**. The project is also **not covered** by Drupal's security advisory
policy.

Most sites are better served by Drupal core's built‑in protections and by
dedicated, well‑maintained anti‑spam modules. If you do install this, **test
thoroughly** — especially with the internal page cache active for anonymous
users — before using it in production. Uninstalling it removes all of its altered
behavior immediately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page**, no permissions, and no routes. The module's
behavior is global the moment it is enabled — you cannot scope it to specific
forms through the UI. To limit or undo its effect on a given form you would have
to alter or unset the added element in a custom module.

## Where it lives in the admin menu

Anonymous CSRF token adds no admin page. It works invisibly by altering form
builds site‑wide.
