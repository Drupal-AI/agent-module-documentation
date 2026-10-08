# Access Unpublished Linked Nodes — manual setup guide

**Access Unpublished Linked Nodes** (`access_unpublished_linked_nodes`) extends the
[Access Unpublished](https://www.drupal.org/project/access_unpublished) module so
that a draft-preview session can follow links *between* unpublished pages. It is a
text-format filter that rewrites in-body links pointing at unpublished nodes so
they carry the visitor's preview token — keeping the preview alive as the reviewer
clicks through.

The problem it solves: when you share an unpublished page with a reviewer via an
Access Unpublished token URL, that token only covers the one page. If the page
links to another draft, the reviewer hits an access-denied wall. This module walks
the rendered body, finds links to unpublished nodes (the ones authored with
[Linkit](https://www.drupal.org/project/linkit)'s `data-entity-uuid` markup), and
swaps their `href` for that node's own token URL — so draft-to-draft navigation
keeps working.

It only ever *propagates* a valid token; it never grants access on its own. The
rewriting runs only when the page is viewed with a valid `auHash` token (validated
against Access Unpublished's active token), and only for low-privilege roles
(`anonymous`, `authenticated`, `viewer`) — so editors' normal editing experience
is untouched. Minting a token link additionally requires the per-bundle
`access unpublished node <type>` permission. When the optional `embed_block` module
is present, it can also render the latest (possibly unpublished) revision of
embedded custom blocks during a preview.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Access Unpublished and Linkit.
2. [Configuration](configuration/index.md) — enable the text-format filter and
   choose which content types are processed.

## Where it lives in the admin menu

- Its settings form (choosing the processed content types) is at **Configuration →
  Content authoring → Access Unpublished Linked Nodes**
  (`/admin/config/content/access-unpublished-linked-nodes`), behind the *Administer
  site configuration* permission.
- The filter itself is switched on per text format at **Configuration → Content
  authoring → Text formats and editors** (`/admin/config/content/formats`).
