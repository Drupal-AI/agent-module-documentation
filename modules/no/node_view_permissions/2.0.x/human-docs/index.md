# Node view permissions — manual setup guide

**Node view permissions** (`node_view_permissions`) adds a **"View own content"** and
**"View any content"** permission for *every* content type on your site. It fills a
real gap in Drupal core: core gives you per‑content‑type control over who may
*create*, *edit*, and *delete* nodes, but for *viewing* it only offers one broad
"Access content" permission that applies to all published content at once. With this
module you can, for example, let authors see only their own articles, give a role
read access to "Page" nodes but not "Article" nodes, or lock a private content type
down to its owner.

The permissions appear automatically for each content type — as you add or remove
content types, the list of view permissions grows and shrinks to match. There is no
settings form to configure; you tick the permissions you want on Drupal's standard
**People → Permissions** page, just like any other permission.

Enforcement uses Drupal's built‑in node access *grant* system rather than a custom
access hook, which has an important benefit: the rules apply everywhere nodes are
listed — not just on individual node pages, but also in Views, in listings, and in
search results — so users never see links to content they aren't allowed to view.
"Own content" grants are scoped to the node's author, so a user with only "View own"
sees just the nodes they created. The module also understands unpublished content and
translations, cooperating with core's "view own/any unpublished content" permissions
for per‑type control over drafts.

To keep existing sites working exactly as before, installing the module grants "View
any content" for every current content type to the anonymous and authenticated roles —
so published content stays visible to everyone until you decide to tighten it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated settings page — everything is managed on the standard
Permissions page, as described in *How to use it* below.

## Where it lives in the admin menu

This module has **no settings form of its own**. You manage everything on the
standard **People → Permissions** page (`/admin/people/permissions`), where the new
per‑type "View own content" and "View any content" permissions appear grouped under
the *Node view permissions* section.

## How to use it

**1. Decide your per‑type view rules.** For each content type, the module offers two
permissions:

- **{Type}: View any content** — the holder can view *any* node of that type. This
  applies to everyone who has the permission.
- **{Type}: View own content** — the holder can view only nodes of that type that
  *they* authored. This requires a logged‑in account; anonymous users can never match
  an "own" rule.

Granting "View any" for a type supersedes "View own" for that type.

**2. Set the permissions.** Go to **People → Permissions**, find the permissions for
each content type, and tick them for the appropriate roles. For instance, give
contributors "View own Article content" while editors get "View any Article content".
Remember that when you first install the module it grants "View any content" for all
existing types to the anonymous and authenticated roles — untick those where you want
to restrict visibility.

**3. Unpublished content (optional).** To let a role view unpublished nodes of a
type, the account needs *both* this module's per‑type "View" permission *and* core's
matching **"View own/any unpublished content"** permission. The two work together.

**4. Rebuild node access if needed.** Because access is enforced through the node
access grant system, after changing which roles hold these permissions you may need to
rebuild the node access grants for the change to take full effect. You can do that from
the status/reports page, or run
`drush php:eval 'node_access_rebuild();'`.
