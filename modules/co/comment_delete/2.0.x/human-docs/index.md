# Comment Delete — manual setup guide

**Comment Delete** (`comment_delete`) replaces Drupal core's blunt, all-or-nothing
comment deletion with configurable rules — most importantly, control over what happens
to the **replies** underneath a comment you delete. It adds fine-grained permissions
and an optional time limit on top.

Core gives you one behaviour: delete a comment and all of its replies vanish with it.
Comment Delete lets you offer up to three deletion operations instead: **hard** (delete
the comment and its replies), **partial hard** (delete the comment but move its replies
up one level so the thread stays readable), and **soft** (delete the comment but keep
the replies). Soft delete can either blank out the comment's content or simply
unpublish it, and can optionally anonymise the author — so a user can remove their own
contribution without breaking the discussion around it.

Rather than a global settings page, the module hangs its configuration off **each
comment field**: on a comment field's edit form you get a "Comment Delete" section
where you choose which operations are allowed, how they're labelled, what confirmation
message each shows, the soft-delete mode, a default operation, and an optional time
limit. That means a blog's comment field can behave differently from a forum's. On top
of this it adds a rich permission scheme — static permissions like "delete own comment"
and "delete any comment" (each with an "anytime" variant that ignores the time limit),
plus permissions generated automatically for every comment field on the site. It
depends on core's **Comment** module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-comment-field settings and the
   permission scheme.

## Where it lives in the admin menu

There is **no central settings page**. You configure the module per comment field, in
the **"Comment Delete"** section of that field's edit form (reached from a content
type's **Manage fields**, or from **Structure → Comment types**). Its permissions are
set at **People → Permissions**.
