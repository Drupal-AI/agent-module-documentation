# View Unpublished — manual setup guide

**View Unpublished** (`view_unpublished`) lets you grant specific user roles
permission to view unpublished nodes — either all content types or just selected
ones — without giving them full content‑administration rights. Out of the box,
Drupal only lets a user see an unpublished node if they can administer nodes or if
they own it; there is no built‑in way to say "editors may *read* (but not edit) any
draft page." This module fills that gap.

It works by plugging into Drupal's node access grant system, so unpublished nodes
become viewable to the roles you choose. Access is strictly **read‑only** — it never
grants edit or delete — and it does not change your URLs, so draft links stay
stable. It also swaps in a Views filter so that listings such as the core Content
overview (`/admin/content`) respect these custom permissions automatically. The only
dependency is core's **Node** module.

There is no settings form to fill in. All of the behavior is driven by two kinds of
**permission**: a global "view any unpublished content", and one per content type
(e.g. "view any unpublished article content"), generated automatically for each node
type. You assign these on the standard permissions page. Because the module uses the
grants system, after enabling it or changing these permissions you may need to
rebuild node access at **Reports → Status**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no dedicated settings page — everything happens on the permissions screen
and (optionally) in your Views.

1. **Grant the permissions.** Go to **People → Permissions**
   (`/admin/people/permissions`) and find the *View Unpublished* section. Tick the
   box for the role and scope you want:
   - **View any unpublished content** — lets the role read every unpublished node of
     every content type.
   - **View any unpublished *[type]* content** — a separate checkbox is generated for
     each content type (Article, Page, and so on) so you can grant draft visibility
     one type at a time.

   Core's own "View own unpublished content" still lets users see only their own
   drafts; this module adds the broader "any" grants on top. Save permissions.

   You can also grant a permission from the command line, using the role machine
   name:

   ```bash
   drush role:perm:add reviewer 'view any unpublished content'
   drush role:perm:add editor 'view any unpublished article content'
   ```

2. **Rebuild node access if listings look wrong.** After enabling the module or
   changing who may view drafts, go to **Reports → Status** and use **Rebuild
   permissions** (or run `drush php:eval 'node_access_rebuild();'`).

3. **In your own Views, use the right filter.** When you build a View that should
   respect these permissions, add the **"Published status or admin user"** filter —
   *not* "Published = Yes". Only the former is taken over by this module, so only it
   will honor the custom permissions. The core Content overview already uses that
   filter, so its "not published" listing reflects who may see which drafts with no
   extra work.
