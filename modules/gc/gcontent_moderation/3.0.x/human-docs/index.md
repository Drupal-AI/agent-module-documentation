# Group Content Moderation — manual setup guide

**Group Content Moderation** (`gcontent_moderation`) connects core's **Content
Moderation** workflows to the **Group** module, so that a member's **group role**
decides which moderation transitions they may perform on their group's content — and
whether they can see pending (draft) revisions of it.

Out of the box, Content Moderation checks a user's *global* permissions to decide
things like "can this person publish?". That's awkward on a multi‑tenant or
departmental site where each Group should manage its own content. This module makes
those checks **group‑aware**: it looks at the member's permissions within the
relevant group instead of site‑wide. A group editor can then publish their own
group's content without being handed a site‑wide "publish everything" permission.

It works quietly in the background by wrapping (decorating) two core services — the
one that decides which transitions are valid, and the one that guards the
"latest version" route — so there is nothing to switch on beyond configuring your
workflow and granting the right group permissions. The module also generates a
group permission for **every** transition of **every** content‑moderation workflow
automatically, adds a *view latest version* group permission, and ships an optional
per‑group moderation queue.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the Content
   Moderation and Group dependencies, and enabling the module.
2. [Configuration](configuration/index.md) — setting up a workflow, granting the
   group permissions, and the optional moderation‑queue view.

## Where it lives in the admin menu

The module has **no settings form of its own**. You work with it through pages you
already know:

- The **content‑moderation workflow** at
  `/admin/config/workflow/workflows`.
- Each **Group type's permissions** page, where you grant its transition and
  *view latest version* group permissions.
- The optional per‑group moderation queue at `group/{group}/moderated`.
