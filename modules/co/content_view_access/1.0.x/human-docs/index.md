# Content View Access — manual setup guide

**Content View Access** (`content_view_access`, shown in the module list as
**Bundle Access**) lets an administrator decide, **per bundle and per role**,
what happens when someone visits a piece of content's canonical page. For every
node **content type** and taxonomy **vocabulary**, and for each user role, you
choose an action: **Access Denied (403)**, **Not Found (404)**, **redirect to the
front page**, or a **blank page** — or leave it as *None* for normal behaviour.
It is the "role X should not see content type Y" gate, configured in a simple
grid without writing code.

The most important thing to understand before you rely on it is **what it does
and does not protect**. Enforcement is a request subscriber that fires only on
the node and taxonomy‑term **canonical (HTML) page routes**. It reads the current
user's roles, looks up your grid for the entity's bundle, and blocks or redirects
that page. It does **not** implement Drupal's node‑access system —
there is no `hook_node_access`, no node access grants, and no entity access
handler. So content "denied" here is still reachable through **every other
channel**: JSON:API, REST (`?_format=json`), Views listings, search, RSS feeds,
and the edit / revision routes. Treat this module as **page‑level presentation
and redirect control, not as protection for sensitive data.** For real
protection, combine it with a module that provides genuine node access (the
project itself points to Entity Bundle Permissions, Node View Permissions, and
Rabbit Hole as alternatives).

There is also a **known configuration caveat** to be aware of. The settings
route requires a permission named `administer content view access`, but the
module actually declares the permission as `administer bundle access` — the two
machine names do not match, which means the settings form is only reachable by
**user 1** until that mismatch is corrected in the module's code. This is
documented so you are not surprised when the form appears inaccessible to a role
you thought you had granted.

The module depends on core **Node**, **Taxonomy**, and **User**, runs on Drupal
10.4 / 11.1, and is actively maintained with security advisory coverage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the admin permission.
2. [Configuration](configuration/index.md) — the bundle × role grid, the four
   actions, and the important limits of what it protects.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → People → Content View
Access** (route `content_view_access.settings`), reachable at
`/admin/config/people/content-view-access`. See
[Configuration](configuration/index.md) for how to fill it in — and read the
caveat above about which permission actually opens it.
