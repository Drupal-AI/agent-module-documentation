# Manage Comment Own Content — manual setup guide

**Manage Comment Own Content** (`manage_comment_own_content`) lets your users
moderate the comments posted on content **they** created — approve them, edit
them, delete them, and see the unpublished ones — without giving them any power
over comments on anyone else's content. It's the missing middle ground between
"can't touch comments at all" and core's site-wide *Administer comments*, which
would let a user manage every comment on the site.

It works by adding a set of **per-comment-type permissions**. Grant them to a
role, and members of that role gain those abilities only on comments attached to
entities where they are the author. This is genuinely ownership-scoped: the
module's access logic grants an operation only when the commented entity's owner
is the current user **and** the user holds the matching permission — otherwise it
stays neutral and never overrides other modules' rules or core's own checks. In
other words, it can only *add* narrowly scoped access; it can never widen a user's
reach to other people's content.

It depends on core's **Comment** and **Node** modules and lives in the Access
control category. There is no settings form — you configure everything on the
standard **People → Permissions** page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. All
setup is done by assigning permissions, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You grant its permissions at
**People → Permissions** (`/admin/people/permissions`). It also ships an optional
**view** — disabled by default — that lists the comments on a user's own content
at `user/{uid}/comments`; enable it from **Structure → Views** if you want to
offer that overview.

## How to use it

For each comment type on your site, the module provides these permissions:

- **`<comment type>` update comments on own content** — edit comments on content
  the user authored (this is what enables author-side approval/moderation of
  those comments).
- **`<comment type>` delete comments on own content** — delete comments on the
  user's own content.
- **`<comment type>` view unpublished comments on own content** — see comments
  awaiting approval on the user's own content. A bundled comment **formatter**
  honours this permission so those unpublished comments actually render for the
  owner.
- **View overview of comments on own content** — reach the optional
  `user/{uid}/comments` overview view.

To let a role self-moderate its own content's comments, go to **People →
Permissions**, find these entries (grouped by comment type), tick them for the
role, and save. Because the grants are ownership-scoped, you can hand them to
fairly ordinary roles — authenticated authors, editors of a section — without
risking their reach spreading to content they don't own.
