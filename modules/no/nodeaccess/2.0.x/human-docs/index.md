# Nodeaccess — manual setup guide

**Nodeaccess** (`nodeaccess`) gives you fine-grained **view / edit / delete**
control over individual nodes. Where Drupal core's permissions are all-or-nothing
per content type ("can this role edit *any* Article?"), Nodeaccess lets you say
"this role can view all Blog posts," "authors can edit only their own pages," or
"grant *this one* editor edit access to *this one* node" — and mix those rules
freely.

It works on two layers. First, **per-content-type defaults**: for each content
type you decide which roles (and the node's author) get view, edit, or delete, and
those grants apply to every node of that type. Second, **per-node overrides**: a
**Grants** tab appears on individual nodes where a privileged user can grant access
to specific roles or search for and add specific users — just for that one node.
When a node has per-node grants, they take over from the content-type defaults for
that node.

Nodeaccess is built on Drupal's node grant system, so once grants are set they are
enforced everywhere access is checked. It works on Drupal 8.8 through 11 and
depends only on core's **Node** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form, the
   per-node Grants tab, and the permissions that unlock them.

## Where it lives in the admin menu

- The global settings form is at **Configuration → People → Nodeaccess**
  (`/admin/config/people/nodeaccess`), gated by the *Administer Nodeaccess*
  permission.
- The per-node **Grants** tab appears on a node at `/node/{id}/grants` for content
  types where you have enabled it, gated by the grant permissions described in
  [Configuration](configuration/index.md).

## A note on rebuilds

Grants are enforced through Drupal's precomputed node-access table. After you change
grant settings, Drupal flags node access for rebuild; if access does not look right,
run a permissions rebuild (**Reports → Status report**, or
`drush php:eval 'node_access_rebuild();'`).
