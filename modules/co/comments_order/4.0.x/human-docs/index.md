# Comments Order — manual setup guide

**Comments Order** (`comments_order`) lets you choose, **per comment field**, whether
comments display oldest-first (ascending) or newest-first (descending) — and, for
threaded discussions, how the child replies sort within that order. Drupal core only
offers oldest-first; this module adds the "newest first" option that a blog, news
site, or high-traffic discussion often wants, so the most recent feedback shows at
the top.

It works entirely through settings added to each comment field, with no admin page of
its own. Because the setting is per field, you can give different content types — or
different comment fields on the same entity — different orderings. It supports both
flat and threaded comment displays.

There's one subtlety worth understanding for threaded comments. When you display
newest-first, you can additionally choose whether child replies keep their natural
(chronological) order under each reversed parent, or whether the whole tree is
inverted:

- **Natural order for children (on):** only the top-level comments are reversed;
  within each thread the replies stay in their normal reading order.
- **Natural order for children (off):** both parents and their children are shown in
  reverse order — a "most recent everywhere" experience.

For flat (non-threaded) comment lists, comments are simply sorted by date ascending or
descending. The module also keeps the pager and comment numbering consistent with the
chosen direction, and (when newest-first is active) redirects a commenter back to the
first page after they post, so they immediately see their new comment.

The module works as soon as you configure a comment field — there is nothing to set up
globally. It depends only on core's **Comment** module, has no permissions or Drush
commands, and requires Drupal core `^11.2` (Drupal 9 and 10 are no longer supported in
the 4.0 line).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no global settings form.
You set the order per comment field, described in "How to set the order" below.

## Where it lives in the admin menu

Comments Order adds no admin settings page. You configure it on each comment field's
edit form, reached from **Structure → Content types → *(type)* → Manage fields**
(`/admin/structure/types`).

## How to set the order

1. Go to **Structure → Content types**, pick the content type whose comments you want
   to reorder, and open its **Manage fields** tab.
2. **Edit** the comment field (the field whose type is *Comment*).
3. Set **Comments order**:
   - **Oldest first (ascending)** — the classic order, good for forum-style reading.
   - **Newest first (descending)** — most recent comments at the top.
4. Optionally set **Order by "Authored on" field** to sort by the authored date
   instead of insertion order — useful when comments were imported or backdated out
   of insertion order.
5. When using descending order on a **threaded** display, optionally enable **Natural
   order for children** to reverse only the top-level comments while keeping each
   reply chain in natural order (see the explanation above).
6. Save the field.

Repeat for any other comment field or content type — each is configured
independently. The ordering is stored on the field's configuration
(`third_party_settings.comments_order` on the `field.field.*` config entity), so it
travels with your exported configuration and can be overridden per environment.
