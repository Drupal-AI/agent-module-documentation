# Moderation state permissions — manual setup guide

**Moderation state permissions** (`moderation_state_permissions`) adds a layer of
access control tied to **content moderation states**. On a site that uses core's
Content Moderation, it lets you say things like "only editors may edit content
that's still in *Draft*", "hide *Archived* content from most roles", or "only
senior editors may delete content in *Needs review*." It does this by generating a
**view / update / delete** permission for **every state of every workflow** on your
site, which you then grant per role on the permissions page.

The permissions it creates are dynamic: they're derived from your live workflow
configuration, so they appear and disappear on the permissions page as you add or
change workflows and states. Each one is named along the lines of *Workflow:
Editorial - update entities in the Draft state*. When a user tries to view, update,
or delete a moderated entity, the module checks the entity's **current** moderation
state and requires the matching permission.

One important design point: this module can only ever **restrict** access, never
grant it. Its check returns "forbidden" when the required permission is missing and
"neutral" otherwise — so it layers on top of Drupal's own access checks (and any
node access modules) as a pure additional deny. If you don't grant a role the
relevant per‑state permission, that operation becomes unavailable to them for
entities in that state. It depends only on core's **Workflows** module (with
Content Moderation providing the moderated entities) and runs on Drupal 8 through
11.

> **Scope note:** like all entity‑access hooks, this only applies on code paths
> that go through entity access. Contexts that bypass entity access — such as a
> View without an access filter, or some listing/render paths — are not covered.
> Gating is based on the entity's *current stored state*, not on the transition a
> user is attempting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — how the per‑state permissions work
   and how to grant them to roles.

## Where it lives in the admin menu

There is no settings form. Everything happens on the permissions page at **People
→ Permissions** (`/admin/people/permissions`), where the generated per‑state
permissions appear (grouped by this module).

## How to use it

Make sure you have a Content Moderation workflow set up, then go to the
permissions page and grant the appropriate *view / update / delete in [state]*
permissions to each role. The step‑by‑step is in
[Configuration](configuration/index.md).
