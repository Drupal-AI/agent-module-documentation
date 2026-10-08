# Unpublished Node Permissions — manual setup guide

**Unpublished Node Permissions** (`unpublished_node_permissions`) gives you
**per-content-type** control over who can see unpublished nodes. Out of the box
Drupal only offers an all-or-nothing "view any unpublished content" permission;
this module adds a separate "view *(type)* unpublished content" permission for
every content type, so you can let a role preview unpublished Articles without
also exposing unpublished Pages, Reports, or anything else.

It has **no configuration screen and no settings of its own** — it works entirely
through Drupal's permissions page and its node access grant system. On install it
defines a site-wide `view unpublished content` permission plus a dynamically
generated `view <type> unpublished content` permission for each content type
(the list grows and shrinks automatically as you add or remove content types).
You then grant those permissions to roles like any other permission.

Because access is enforced through node grants (which are cached), there is one
important step after enabling the module or changing who holds these permissions:
you must **rebuild node access permissions** for the grants to take effect. The
module also swaps in its own Views status filter so unpublished rows show up in
listings consistently with the same per-type rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the grant realms
and Views integration — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and rebuild node access.

## How to use it

There is nothing to configure; you use the module by granting its permissions:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the permissions this module adds:
   - **View any unpublished content** (`view unpublished content`) — lets a role
     see unpublished nodes of *every* type.
   - **View *(type)* unpublished content** — one per content type, e.g.
     `view article unpublished content`, `view page unpublished content` — lets a
     role see unpublished nodes of just that type.
3. Tick the boxes for the roles that should have each permission and **Save
   permissions**.
4. **Rebuild node access** so the grants apply (see below and
   [Installation](installation/index.md)). Do this again any time you change who
   holds these permissions.

You can also grant a permission from the command line:

```bash
drush role:perm:add content_editor 'view article unpublished content'
drush php:eval 'node_access_rebuild();'
```

The same per-type rules also apply in Views listings, so an unpublished node only
appears to a user who holds the matching permission.

## Where it lives in the admin menu

The module adds **no admin page** (`configure: null`). Everything happens on the
core **People → Permissions** screen (`/admin/people/permissions`), where its
static and per-type permissions appear under the *Node* section.
