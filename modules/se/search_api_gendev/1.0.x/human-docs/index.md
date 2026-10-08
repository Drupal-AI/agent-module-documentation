# Search API generic devel — manual setup guide

**Search API generic devel** (`search_api_gendev`) is a developer tool that adds
a new tab to the entity **Devel** tab group, showing you exactly what Search API
has indexed for a given entity. It's meant for people building and tuning Search
API indexes who want to see inside what can otherwise feel like a black box —
especially the Database server backend, which was the maintainer's original
motivation for writing it.

Open the Devel tab on an indexed entity and you get a look at:

- **The indexed data** — the fields that are indexed, plus any extra,
  server-dependent data, and the query time.
- **Locally generated data** — the data that *would* be indexed on the next
  reindex, so you can compare what's currently stored against what a fresh index
  pass would produce.

It also gives you a couple of hands-on actions right there in the tab: **reindex
(or index) an entity manually**, and **delete an entity's index item**. That makes
it easy to poke at a single item while you're diagnosing why something does or
doesn't show up in search.

This is purely a debugging aid — it has no content model or access role of its own,
and it's the sort of module you enable on development and staging environments
rather than production. It depends on **Search API** (`search_api`) and the
**Devel** module (`devel`), and supports Drupal 9, 10, and 11. There's no settings
page; its value shows up as the Devel tab on your entities. Note the project is
**not covered** by Drupal's security advisory policy — another reason to keep it to
non-production environments, alongside Devel itself.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled (with Devel), visit an entity that is tracked by a Search API index —
for example a node's canonical page — and open its **Devel** tab group. You'll find
a new Search API tab there that shows the indexed data and fields, the locally
generated (pending) data, and buttons to manually reindex the entity or delete its
index item.
