# Content Moderation Node Grants — manual setup guide

**Content Moderation Node Grants** (`content_moderation_node_grants`) closes a
long-standing gap in how Drupal core controls access to unpublished, moderated
content. Content Moderation manages draft/review/published states, but once node
**access grants** are involved, core has a documented weakness (issue
[#3161658](https://www.drupal.org/project/drupal/issues/3161658)) around who may
view or edit pending/unpublished revisions. This module fills that gap with a proper
node-access-grants implementation.

Concretely, it emits node access records that tie **view, update, and delete** of
unpublished content to the relevant permissions — *view any unpublished*, *view own
unpublished*, and edit-any/edit-own by content type — so moderated content is
access-controlled at the node-grant layer, which is the correct, deep place for it.
With the module enabled, an unpublished node is not exposed to anonymous visitors:
it becomes viewable only through the permission-gated `view_any_unpublished_content`
/ `view_own_unpublished_content` realms, and there is deliberately **no** grant in
the generic view realm, so drafts are not leaked.

One important characteristic of node access to keep in mind: it is **additive across
modules**. Any node-access module's grant can *allow* access, and the site-wide
outcome is the *union* of all of them. This module governs its own realms correctly,
but if another node-access module also grants view on the same content, that grant
applies too — so the whole-site result depends on every node-access module you run.

Getting node access wrong either leaks unpublished content or locks out legitimate
users, so this is squarely an access-control module: enable it deliberately, and
verify the outcome on your site. Its only dependency is core **Content Moderation**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   rebuild node access permissions, and verify drafts are protected.

There is **no settings form** for this module. It works through node access grants
that map to the standard unpublished-content permissions; you control who sees
drafts through those permissions at **People → Permissions**.

## How to use it

After enabling the module and rebuilding node access (see Installation), set the
relevant permissions at **People → Permissions** — for example, grant *view own
unpublished content* to authors and *view any unpublished content* to editors/
reviewers. Access to drafts then follows those permissions through the node-grant
layer. Because node access is additive, review any other node-access modules you run
to understand the combined result.
