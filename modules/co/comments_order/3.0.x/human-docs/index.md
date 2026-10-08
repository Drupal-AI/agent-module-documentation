# Comments Order — manual setup guide

**Comments Order** (`comments_order`) lets you decide, for each comment field,
whether comments show **oldest-first** (ascending) or **newest-first**
(descending) — and, for threaded discussions, how the replies underneath each
comment sort. It is the no-code answer to "can we show the most recent comment at
the top?" without writing a custom Views or query alter.

The choice is made **per comment field**, not globally. Every content type (or any
entity) that has a comment field gets its own setting, so your blog's articles can
show newest-first while a forum-style discussion stays in classic reading order.
The module adds three small options to the comment field's edit form on a bundle's
*Manage fields* page and stores them alongside that field's configuration, which
means the ordering travels with your config exports.

Under the hood it never re-saves your comments — it simply rewrites how they are
queried and paged at display time, and it keeps the comment pager and "which page
is this comment on" counting consistent with the direction you picked. When
newest-first is active, it also bounces a commenter back to the first page after
they post so they immediately see their new comment.

There is no separate settings page, no permissions, and no Drush commands — the
whole module is those three field options and the display logic behind them. It
depends only on core's **Comment** module.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the three per-field ordering options,
   explained one by one, and where to find them.

## Where it lives in the admin menu

Comments Order has **no admin page of its own**. You configure it on the comment
field itself: go to a content type's fields (for example **Structure → Content
types → Article → Manage fields**, `/admin/structure/types/manage/article/fields`),
edit the **Comments** field, and you'll find the ordering options on that form. See
[Configuration](configuration/index.md) for the details.
