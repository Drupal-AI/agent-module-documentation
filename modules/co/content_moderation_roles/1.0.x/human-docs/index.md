# Content Moderation Roles — manual setup guide

**Content Moderation Roles** (`content_moderation_roles`) gives you fine-grained
control over which moderation *states* each user role can see and set — on node
add/edit forms and in admin content listing views — all through an admin UI, with
no custom code. By default, Drupal's Content Moderation shows every workflow
state to everyone who can edit content. This module lets you trim that down: a
"Contributor" can be limited to *Draft* and *Needs Review*, while an "Editor" sees
every state including *Published* and *Archived*.

It's important to understand how this relates to core. Core Content Moderation
controls which *transitions* a role may perform; this module layers a
**visibility** filter on top, hiding states a role shouldn't even see for a given
content type. The two work together — this module simplifies editors' choices and
tidies the UI, and should be paired with proper transition permissions rather
than treated as the only access control.

Rules are managed entirely through the admin UI and stored in standard Drupal
configuration, so they export with `drush cex` and deploy across environments
like any other config — no database schema is created. Features include role-based
state filtering on node forms, per-content-type overrides (an "Editor" might
publish Articles but only draft Events), union of permitted states for users with
multiple roles, "full access" roles that skip all restrictions, a global fallback
state list for unconfigured roles, and optional Views query alterations that
restrict content-listing views and correct sort order for Layout Builder pending
revisions. It depends only on core's **Content Moderation**, **Node**, **Views**,
and **Workflows** modules, and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This release is a beta (1.0.0-beta3) and the project is not covered by
> Drupal's security advisory policy. Because state *visibility* is not the same as
> a transition *permission*, treat this module as a UI aid on top of core's access
> controls rather than a substitute for them.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Content Moderation Roles
   settings page, field by field.

## Where it lives in the admin menu

After enabling, the settings page sits at **Configuration → Workflow → Content
Moderation Roles** (`/admin/config/workflow/content-moderation-roles`). Reaching
it requires the core **Administer workflows** permission (`administer workflows`).
