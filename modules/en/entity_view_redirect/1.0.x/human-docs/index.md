# Entity View Redirect — manual setup guide

**Entity View Redirect** (`entity_view_redirect`) redirects an entity's canonical
**view** page to its **edit form** — or to another internal path you choose. Some
entities exist to be edited, not looked at: a record you manage only through its
form, content used purely for storage, or a page whose real presentation is built
in a View elsewhere. For those, the default rendered "view" page is at best
useless and at worst confusing. This module sends visitors straight past it.

It works with Drupal's core entities — **Node**, **Taxonomy term**, and
**User** — letting you skip their view pages and route to the edit form or a
custom internal URL instead. A common pattern: you build the real listing or
detail page with Views, and use this module so the core entity's own view route
redirects there rather than showing a second, unstyled version.

The redirect target is chosen by an administrator, not derived from the incoming
request, so it is **not** an open-redirect risk. The main things to confirm are
that the redirect matches the workflow you intend and that users who legitimately
*should* see a view page are not unexpectedly caught by it. The module is
administered by trusted roles via its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choosing which entities redirect and
   where they redirect to.

## How to use it

In short: enable the module, grant its administration permission to a trusted
role, then configure which entity types (Node, Taxonomy, User) should have their
view page redirected and what the destination should be — the edit form, or a
custom internal path. See [Configuration](configuration/index.md) for the
details.
