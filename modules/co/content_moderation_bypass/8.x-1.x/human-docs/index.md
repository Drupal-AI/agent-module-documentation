# Content Moderation Bypass — manual setup guide

**Content Moderation Bypass** (`content_moderation_bypass`) adds a single, powerful
capability: a permission — generated **per workflow** — that lets its holder move
content to **any** moderation state, ignoring the transitions the workflow defines.

Core Content Moderation enforces a state machine: from *Draft* you may go to
*Review*, from *Review* to *Published*, and each allowed move is a permission. That
rigidity is the point — it's what makes a workflow mean something. But it also gets
in the way of exactly the people who should be trusted around it: an administrator
fixing a stuck item, a migration that needs to land content directly in *Published*,
a maintenance script correcting a bad state. Without an escape hatch, the only way
to grant those actions is to hand out every individual transition permission, which
is broader and clumsier than the need. This module provides the escape hatch as a
first-class, separable permission.

For each workflow on your site it generates a permission named **`bypass {workflow}
transition restrictions`**. A user who holds it can set content in that workflow to
any state directly, skipping the transition graph entirely.

**Treat this permission as high-privilege.** It does **not** bypass *access* — a
user still needs permission to edit the content — but it does bypass the workflow's
*integrity*, which is usually the whole reason the workflow exists. Grant it only to
a narrow administrative role, and grant it **per workflow** rather than globally
wherever your design allows, so you hand out exactly the override that's needed and
nothing more. Do not give it to general editors. Its virtue is precisely that it is
separable: you can let someone override transitions without also handing them
unrelated administrative power, and you should audit who holds it. Its only
dependency is core **Content Moderation**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the bypass permission carefully.

There is **no settings form** for this module. Its entire effect is the per-workflow
permission, granted at **People → Permissions**.

## How to use it

After enabling the module, go to **People → Permissions**
(`/admin/people/permissions`) and look for a **`bypass {workflow} transition
restrictions`** permission for each of your workflows. Assign it only to the
administrative role that genuinely needs to override transitions, and only for the
workflows where that override is appropriate. A holder of the permission will then
be able to set content in that workflow to any state on the edit form, regardless of
the current state — useful for correcting a stuck item, landing a migration directly
in *Published*, or fixing a bad state.
