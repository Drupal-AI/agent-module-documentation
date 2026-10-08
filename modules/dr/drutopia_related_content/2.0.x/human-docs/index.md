# Drutopia Related Content — manual setup guide

**Drutopia Related Content** (`drutopia_related_content`) shows a "related
content" list on node pages — other articles, campaigns, actions and so on that
share taxonomy terms with the node being viewed. It turns a site's existing tags
and topics into automatic cross-links between related items, with no manual
curation.

Under the hood it wraps the contributed
[Similar By Terms](https://www.drupal.org/project/similarterms) (`similarterms`)
module in a Views configuration: it installs a `related_content` view that lists
nodes sharing taxonomy terms with the current one, and an optional block placed
through **Block Visibility Groups** so the related list appears only where you
want it.

Everything is configuration — there is no custom code, no routes and no
permissions. Related items respect core node access through the view. It depends
on the Similar By Terms and Block Visibility Groups projects plus
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md) and core Node
and Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Similar By Terms / Block Visibility Groups dependencies.

## Where it lives in the admin menu

There is no settings form. The related-content list is a **View** you edit at
**Structure → Views** (`/admin/structure/views`), and its block is placed and
scoped at **Structure → Block layout** (`/admin/structure/block`) together with
**Block Visibility Groups** (`/admin/structure/block/block-visibility-groups`).

## How to use it

After enabling the module, place (or adjust) the related-content block for the
content types and pages where you want it, using the shipped block visibility
group to control where it appears. Tune the `related_content` view to change how
many items show, restrict them to the same content type, or reorder them by
relevance (the number of shared terms). Because relatedness is computed from your
existing taxonomy, the lists stay fresh as content and tags change.
