# Blog — manual setup guide

**Blog** (`blog`) brings back the classic multi-user blogging feature that used to
ship with Drupal core, packaged as a contrib module. Enable it and you immediately
get everything you need to run blogs on your site: a ready-made **Blog post**
content type, a set of blog listing and feed pages built with Views, and a personal
blog for every registered user — all without modelling any content or building a
single View yourself.

Out of the box it creates a `blog_post` content type with a Body field, threaded
comments, and a free-tagging "Blog tags" field. It also installs a View called
`blog` with five ready-to-use displays: an aggregated **All blog posts** page at
`/blog`, a per-user page at `/blog/{user id}`, a **Recent blog posts** block, and
two RSS feeds (`/blog/feed` for everyone and `/blog/{user id}/feed` per author). A
"My blog" link is added to the account menu so each signed-in user can jump straight
to their own posts.

Blog has **no settings form**. There is nothing to configure — access is governed
entirely by the standard node permissions Drupal generates for the `blog_post`
content type (for example, `create blog_post content`). You customize the
experience the same way you would any content type and View: by editing permissions,
the content type's fields, and the shipped `blog` View's displays.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Blog has no configuration page of its own. Everything it adds surfaces through the
usual Drupal admin areas:

- The **Blog post** content type: **Structure → Content types**
  (`/admin/structure/types`).
- The shipped **blog** View: **Structure → Views** (`/admin/structure/views`).
- Who can create and edit posts: **People → Permissions**
  (`/admin/people/permissions`), under the `blog_post` content type permissions.

## How to use it

After enabling the module, decide which roles may write posts by granting
`create blog_post content` (and `edit own blog_post content`) on the permissions
page. Authors then create posts through the normal **Content → Add content → Blog
post** flow, and their posts appear both in the site-wide `/blog` listing and on
their own `/blog/{user id}` page.

A couple of pieces are available but not switched on automatically:

- **Recent blog posts block** — it is not placed for you. Add it from **Structure →
  Block layout** (`/admin/structure/block`) by placing the "Recent blog posts"
  (`views_block:blog-blog_block`) block in whichever region you want.
- **Personal blog link on profiles** — a "View recent blog entries" link can appear
  on user profiles. Turn it on at **Configuration → People → Account settings →
  Manage display** (`/admin/config/people/accounts/display`) by enabling the
  "Personal blog link" component.

The two RSS feeds are ready for syndication as soon as posts exist, and blog post
pages get an automatic **Home › Blogs › {author}'s blog** breadcrumb trail. Note
that the module will not let you uninstall it while any blog posts still exist, to
protect you from accidental data loss — delete the posts first.
