# Access Arguments List — manual setup guide

**Access Arguments List** (`access_arguments_list`) is a small developer
convenience. It adds the exact **machine name** of every permission directly under
its description on the core permissions page at **People → Permissions**.

Out of the box, Drupal's permissions table shows only the human-readable titles of
each permission. But site builders and developers frequently need the precise
machine-name string — to reference a permission in a route's `_permission`
requirement, to grant it in a role's exported YAML, to use it in a
`hasPermission()` call, or to set a Views "Permission" access filter. Normally
that means digging through module `*.permissions.yml` files. This module removes
that friction by printing `Machine name: <permission>` right there in the UI.

That is the whole of it. There is no configuration, no route of its own, no new
permission, no database change, and no data collection — it simply alters the
display of the existing core permissions form. Its security posture is exactly
that of the core permissions page, which is already reachable only with the
**Administer permissions** permission. Many teams enable it only on a dev or
staging environment as a reference aid.

This guide is written for a **human** setting the module up. If you want the
terse, token-cheap reference written for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. Once enabled, the effect is visible directly on the
core permissions table at **People → Permissions**
(`/admin/people/permissions`) — each permission row gains a small
`Machine name: …` line under its description.
