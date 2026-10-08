# Content moderation permissions — manual setup guide

**Content moderation permissions** (`content_moderation_permissions`) adds
per-content-type granularity to Drupal core's Content Moderation. Out of the box,
core grants a workflow transition — say *Draft → Published* — with a single
permission that applies to **every** content type using that workflow. If a role
can publish, it can publish everything on that workflow. This module fixes that:
it generates a separate permission for each combination of workflow, transition,
and content type, so you can let a role publish Articles but not Pages, or move
only Blog posts to review.

Behind the scenes it does two things. First, it dynamically creates permissions
named like `use editorial transition publish for article`, which appear right
alongside core's moderation permissions on the standard **People → Permissions**
page. Second, it decorates core's transition validator so that a user is allowed
to run a transition if **either** core's global permission **or** the new
per-content-type permission is held. The behaviour is strictly *additive* — it
only ever grants extra access by explicit permission, and never removes access
core would already allow. Users who are given none of the new permissions keep
exactly the core behaviour they had before.

One thing worth knowing: because access is additive, granting a per-type
permission alone will not *restrict* a role that still holds core's global
transition permission. To get true per-type restriction, remove the core global
permission from the role and grant only the specific `… for <content type>`
permissions you want (see "How to use it" below). The per-type logic applies to
**node** content only; other entity types fall through to core behaviour
unchanged. The module depends only on core's Content Moderation and has no
settings form of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. All setup happens on the
standard permissions page, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Everything is managed on **People →
Permissions** (`/admin/people/permissions`), which requires the **Administer
permissions** right. There you will find the new, more granular moderation
permissions listed alongside core's.

## How to use it

1. Make sure you already have a **Content Moderation** workflow set up (under
   **Configuration → Workflow → Workflows**) and applied to one or more content
   types.
2. Go to **People → Permissions**. For each role, scroll to the Content
   Moderation permissions. You'll now see entries like *"Use the Publish
   transition of the Editorial workflow for Article"* — one per
   workflow/transition/content-type combination.
3. To grant a transition on specific content types only, tick just those
   per-type permissions for the role.
4. **Important:** if you want to *limit* a role to certain content types, first
   **uncheck** core's global transition permission for that role (the one that
   isn't scoped to a content type), then grant only the per-type permissions you
   want. Leaving the global permission checked keeps the role able to run the
   transition everywhere, because access is additive.
5. Save permissions. The moderation state dropdown on node edit forms will now
   offer each role only the transitions it is permitted to run for that content
   type.
