# Content Moderation Owner Permissions — manual setup guide

**Content Moderation Owner Permissions** (`content_moderation_owner_permissions`)
adds a missing dimension to core's moderation permissions: the ability to let users
moderate **their own** content without giving them that power over everyone else's.

Core Content Moderation's transition permissions are global. "May move Draft to
Published" applies to *all* content a user can edit — so the moment you let a content
editor publish, they can publish anything they're able to edit, not just their own
work. Core provides *any*/*own* distinctions for node editing, but not for workflow
transitions. This module fills that gap by providing **owner-scoped** transition
permissions: a user granted one can transition only content they created.

The classic use case is exactly this: you want editors to be able to create drafts
of any content, but to publish only their **own** work. With this module you remove
the global "publish any" transition permission and instead grant the owner-scoped
"publish own" permission, so authors self-moderate their content while everyone
else's stays out of their reach.

Because this is access control — who may transition what — the module **complements**
core's global permissions rather than replacing them: grant the owner-scoped
permission to enable self-moderation while keeping the corresponding global
permission restricted. And don't forget the node-level permissions too: users still
need permission to *edit* the content they'll be moderating. Its only dependency is
core **Content Moderation**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and assign the owner-scoped permissions.

There is **no settings form** for this module. Its entire effect is the new set of
owner-scoped moderation permissions you assign at **People → Permissions**.

## How to use it

The recommended setup, for letting editors draft anything but publish only their own:

1. At **People → Permissions** (`/admin/people/permissions`), keep the **global**
   Content Moderation transition permissions (such as "publish any") restricted for
   the editor role.
2. Grant the editor role the matching **owner-scoped** transition permission this
   module adds (transition *own* content) so they can move their own content through
   the workflow.
3. Grant the appropriate **node edit** permissions so users can actually edit the
   content they'll moderate.

The result: authors can create drafts of any content and publish their own, without
gaining the ability to publish content created by others.
