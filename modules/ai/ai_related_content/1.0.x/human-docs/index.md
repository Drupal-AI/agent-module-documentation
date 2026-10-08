# AI Related Content — manual setup guide

**AI Related Content** (`ai_related_content`) provides a **Views block that shows
related content using AI Search**. Rather than matching on shared tags or
categories, it ranks other content by *semantic similarity* — meaning — using the
AI module's vector search. So a page can display "related articles" that are
genuinely about the same topic, even when they don't share any taxonomy terms.

It builds on core **Views** and **Block**, **Search API**, and the **AI Search**
module (which does the embedding and similarity work). You place the block on the
pages where you want related content to appear, and it queries the AI Search
index to find the closest matches.

Two things are worth knowing. Because it relies on AI Search embeddings, your
content is embedded and queried through the configured AI provider — if that
provider is cloud‑based, this is external data egress you should confirm is
acceptable (credentials are handled as secrets by the AI module). And results
follow the **Search API index's access rules**: make sure the index respects
content access so the related‑content block never surfaces restricted or
unpublished content to people who shouldn't see it. The module has no
access‑control role of its own beyond the permission it provides.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. **Install and enable** the module (see [Installation](installation/index.md)).
2. **Set up AI Search** — configure an AI provider with its key stored as a Key,
   and build a Search API index (with the vector/embeddings backend) over the
   content you want to relate. Verify the index respects content access.
3. **Place the block.** Go to **Structure → Block layout**, add the AI Related
   Content block to a region (typically on node pages), and configure it there —
   which index to use and how many related items to show.
4. **Check the result** on a content page: the block should list conceptually
   related items, and should not surface anything the visitor is not allowed to
   see.
