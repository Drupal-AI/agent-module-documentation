# History — manual setup guide

**History** (`history`) records which content each logged-in user has read, and
when. That read-tracking is what powers the familiar **"New"** and **"Updated"**
markers next to node titles, the **"x new comments"** link on teasers, the "new"
highlight on individual comments, and Views filters that let you build an "unread
content" listing. If you've used a Drupal forum or a content dashboard that knew
which items you'd already seen, this is the module behind it.

This is core's original `history` module, which was **removed from Drupal core**
and is now maintained as a contrib project for **Drupal newer than 11.3**. Install
it on such a site and your existing views, markers, and "new comments" indicators
keep working exactly as they did when the code lived in core. It depends on core's
**Node** module.

There is nothing to configure — **no settings form, no permissions, and no admin
UI.** The module works the moment you enable it: it stores one row per (user, node)
in a small `history` table, marks nodes as read via a little client-side
JavaScript when a user views them, and automatically prunes anything older than 30
days so the table never grows unbounded. Its real value to site builders is in
Views and tokens, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the read/write
functions, the `HistoryManager` service, and the JSON endpoints — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page. Once enabled, read-tracking is automatic for
every authenticated user (it's a no-op for anonymous visitors). You interact with
it indirectly, through Views and tokens.

## How to use it

### The "New" / "Updated" markers

On any content listing, these markers appear automatically once the module is on.
For your own custom listings, add the tracking through Views (below).

### In Views

History adds a field and a filter to the **Content** group in Views. When you add a
field or filter to a view, search for:

- **Has new content** — a field that shows the "New"/"Updated" marker for content
  the current user hasn't read (or that changed since they last read it).
- **Show only content that is new or updated** — a filter that limits the view to
  unread/updated content, so you can build an "Unread content" or personalized
  dashboard listing.
- **New comments** — a field showing the number of new comments on each node
  (available when core's Comment module is enabled).

Every one of these is automatically scoped to the **current user** — there's no way
to report on another person's read state through them. That's what makes an
"unread for me" dashboard just work.

### Tokens

For each content entity type that has a comment field, History registers a
**`comment-count-new`** token — the number of comments posted since the current
user last viewed the item. For example:

```
[node:comment-count-new]
[term:comment-count-new]
```

These are handy in email templates or custom text. They resolve per current user
and render empty for anonymous visitors.

### Housekeeping

The module keeps itself tidy automatically: history rows are removed when a node or
user is deleted (or an account is cancelled), and cron deletes any read record
older than 30 days. You don't need to maintain the table by hand.
