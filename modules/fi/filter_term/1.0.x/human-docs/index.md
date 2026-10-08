# Filter Term — manual setup guide

**Filter Term** (`filter_term`) adds an admin content-finder page. It gives
editors a single screen to search the site's nodes by **vocabulary**, **taxonomy
term**, **content type**, **title**, and **author**, and shows the matches in a
paged, sortable table with quick **View** and **Edit** links. It is handy as a
lightweight "where is that content?" browser without building a custom View. It
depends on core's Node and Taxonomy modules.

You use a filter form to narrow things down: pick a vocabulary and the page
AJAX-loads its terms so you can choose one, optionally add a content type, a title
string, or an author, then submit to see the results. The table has a **Status**
column showing whether each node is published or unpublished, so you can also use
it to audit publishing state across a content type. Leaving the filters empty lists
all content.

There is no stored configuration — the page reflects whatever vocabularies,
content types, and nodes already exist on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it stores no configuration of its
own. How you use the finder page is described in "How to use it" below.

## Where it lives in the admin menu

Filter Term adds two routes:

- **The filter form** at `/admin/config/filter_term/vocab` — where you choose the
  vocabulary, term, content type, title, and author to search by.
- **The results table** at `/allcontent` — the finder page listing the matching
  nodes.

## How to use it

1. Go to `/admin/config/filter_term/vocab`.
2. Pick a **vocabulary**; its terms load automatically. Choose a **term** if you
   want to narrow to one.
3. Optionally add a **content type**, an exact **title**, and/or an **author**.
4. Submit the form. You land on `/allcontent` with a sortable, paged table of
   matching nodes — sort by title, type, author, or status, and use the **View**
   and **Edit** links to jump to each node. Use **Reset** to clear the filters and
   see everything.

## A note on visibility

The `/allcontent` results page is available to anyone with the core **Access
content** permission, and it lists both published *and* unpublished nodes (the
**Status** column shows which). Treat the finder as visible to any content-viewing
user, and if that is too broad for your site, tighten who can reach the page
accordingly.
