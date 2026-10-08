# Node RSS — manual setup guide

**Node RSS** (`node_rss`) gives any node an RSS version of its page, reachable by
appending `/rss` to the node's path. Visiting `/node/123/rss` — or the aliased path
`/some/path/rss` — renders that node as an RSS feed instead of an HTML page, so
external systems can parse it easily just by switching to the `/rss` variant of a
URL. The node is displayed using its default format.

It is a small, focused content‑display / syndication helper: there is no feed
builder or list configuration to set up, and the feed follows normal node access
(only published, accessible content is shown). Its one real setup step is a
**permission** — only users with **node.view all rss feeds** can view the feeds, so
if you want the feeds to be publicly consumable you must grant that permission to
the *Anonymous user* role.

The module depends on core's **Node** and **Path Alias** modules and has **no
configuration options** of its own beyond that permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has no settings form; the only setup beyond enabling it is granting the
feed‑viewing permission, described in "How to use it" below.

## How to use it

1. Go to **People → Permissions** (`/admin/people/permissions`) and grant
   **node.view all rss feeds** to the roles that should be able to read the feeds.
   To make feeds available to the public, grant it to **Anonymous user**.
2. Append `/rss` to any node URL to get its feed — for example `/node/123/rss`, or
   `/blog/my-post/rss` if the node has a path alias.
