# Islandora Access — manual setup guide

**Islandora Access** (`islandora_access`) is an access-control helper for
[Islandora](https://www.islandora.ca/) repositories. It lets you **assign an
administrator to a parent item** — typically a collection — and have that person
automatically gain **view, update, and delete** rights over that node *and all of
its children*. It is a deliberately lightweight alternative to the
[Group](https://www.drupal.org/project/group) module for the common case of "let
this person manage this collection."

Concretely, you attach an entity-reference field named **`field_administrator`** to
your Islandora nodes, pointing at user accounts. When a node references a user
through that field, that user can view, update, and delete the node — and any node
that references it as a parent through **`field_member_of`**. Those node
administrators can also **create, update, and delete media** for the nodes they
administer, and (optionally) media access can be controlled too by setting
`field_media_of` on media to point at the relevant nodes.

One behaviour to be aware of before you enable it: this module also makes **all
published nodes viewable by anonymous users**. That is by design for a public
repository, but it is a real access change, so make sure it matches your site's
intent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the required
   fields, and enable the module.

There is **no settings form** for this module. Its behaviour is driven entirely by
the fields you attach and the values editors set on them, described in "How it
gates access" below.

## Where it lives in the admin menu

Islandora Access adds no admin configuration page. You set it up through **Structure
→ Content types → *(your Islandora type)* → Manage fields** (adding the required
fields), and it takes effect automatically as editors populate
`field_administrator` on nodes.

## How it gates access

Once the fields are in place, the rules are:

- **A user referenced by `field_administrator` on a node** can **view, update, and
  delete** that node.
- That same user gets the same rights over **every child node** — any node that
  references the administered node through **`field_member_of`**.
- Node administrators can also **create, update, and delete media** for the nodes
  they administer.
- If a media entity has **`field_media_of`** pointing at a node, this module can
  control access to that media too.
- Separately, **all published nodes become viewable by anonymous users.**

Assigning an editor is then just a matter of editing a collection (or other parent)
node and referencing their user account in `field_administrator` — they inherit
management rights over the whole branch beneath it, with no roles or Group
memberships to maintain.
