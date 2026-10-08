# Content View Bundle Permissions — manual setup guide

**Content View Bundle Permissions** (`content_view_bundle_permissions`) tidies up
the admin **Content** listing (`/admin/content`) so a role only sees the content
**bundles it is allowed to**. It adds **per‑node‑type permissions** — a *view
any* and a *view own* variant for each content type — and uses them to filter the
rows shown in the content admin View. If a role has no permission for a bundle,
rows of that bundle simply do not appear in its listing.

The scope is deliberately honest, and it is important to understand it. The
permissions are explicitly named and described **"in content view"**: they filter
the **Views listing only**. Enforcement happens by altering the View's query and
adjusting its exposed filter form — so this is **not** a general entity‑access
control. It does **not** implement `hook_node_access` or node access grants, which
means canonical node pages, JSON:API, and REST are completely unaffected. Use it
to give each editorial role a cleaner, role‑appropriate content list — not to
hide content from the site as a whole.

The module depends on core **Views** and **Node**, requires **PHP 8.1**, and runs
on Drupal 10 and 11. It is minimally maintained (maintenance fixes only) but has
security advisory coverage. It works as soon as you enable it and assign the
permissions — there is no settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration screen** — the behaviour is driven entirely by
permissions, described below.

## How the permission model works

After enabling the module, go to **People → Permissions**
(`/admin/people/permissions`). For each content type you will find new
permissions along the lines of *view any [type] in content view* and *view own
[type] in content view*. Assign them per role:

- Grant a role the **view any** permission for a bundle to let it see all nodes of
  that bundle in the admin content listing.
- Grant the **view own** permission to let a role see only its own nodes of that
  bundle in the listing.
- Grant nothing for a bundle and that role will not see rows of that bundle in the
  content View at all.

Because enforcement is limited to the Views listing:

- **Canonical node pages** (`/node/{id}`) are **not** affected — a user who can
  reach a node's URL still can.
- **JSON:API and REST** are **not** affected.
- This is a UX / admin‑listing convenience, so **do not rely on it as a security
  boundary.** For actual access control, use a module that provides real node
  access.
