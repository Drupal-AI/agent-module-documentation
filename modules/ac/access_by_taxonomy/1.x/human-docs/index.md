# Access by Taxonomy — manual setup guide

**Access by Taxonomy** (`access_by_taxonomy`) controls who can view a node based on
the **taxonomy terms** applied to it. Tag a node with an access term, and only the
users or roles you have allowed on that term may view the content — a common and
intuitive editorial access model.

What sets this module apart is that it uses the **correct mechanism**: Drupal's
node-grants system (`hook_node_grants` + `hook_node_access_records`). That matters
because node grants are enforced at the *query* level. A restricted node does not
just hide its own page — it is filtered out of listings, Views, and search
results for users who are not allowed to see it. This is exactly the property you
want from content access, and it is what many simpler "hide the page" approaches
get wrong.

You define the audience using two fields on the access taxonomy — **Allowed
users** and **Allowed roles** — and the module also supports realms for public
content, content owners, and a user's own unpublished content. The default
behaviour is sensible and has been verified: a node with **no** access restriction
receives a public grant, so unrestricted content stays public.

Two things to remember about any node-grants module. First, whenever you enable it
or change access configuration, you must run **`node_access_rebuild`** so the
grants table is regenerated. Second, node access is **additive** across modules —
the site-wide result is the *union* of every node-access module's grants — so if
you run more than one, be deliberate about how they combine.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and rebuild node access.

## How to use it

There is no central settings form — you configure access through fields on your
access taxonomy:

1. On the taxonomy (or the content that references it), configure the **Allowed
   users** and **Allowed roles** fields to match your access policy.
2. Tag a node with the appropriate access term to restrict who may view it.
3. Run **`node_access_rebuild`** after enabling the module and after any change to
   the access configuration, so the grants table reflects your settings.
4. Verify the result — confirm that a restricted node disappears from listings,
   Views, and search for a user who should not see it, and that unrestricted
   content remains public. Test as both an anonymous and an authenticated user.
