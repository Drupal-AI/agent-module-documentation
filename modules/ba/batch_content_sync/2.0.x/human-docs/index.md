# Batch Content Sync — manual setup guide

**Batch Content Sync** (`batch_content_sync`) moves full Drupal content entities
— nodes, media and paragraphs, including nested structures and media encoded as
base64 — between environments. The typical use is content deployment or staging:
pushing content from a staging site to production, for example, rather than
re‑creating it by hand. It works in the content‑staging / migration space, and it
does the work in batches so large sets of content don't time out.

Because it transfers content over a channel *between two sites*, it has real
security implications you need to handle. That channel must be **authenticated**
so that only trusted environments can push or receive content — otherwise an
attacker who can reach the endpoint could inject content into your site. Run it
over **HTTPS**, and store any connection credentials or tokens as **secrets**
(in an environment variable, never in committed configuration). Also treat the
content you receive as coming from the source environment — you are trusting that
source, so only sync from environments you control.

The module has no access‑control role of its own; it is plumbing for moving
content, and the trust decisions are yours to make.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Content is pushed and received from the module's own screens/operations once it is
enabled. The essential setup is the connection between environments — see
[How to use it](#how-to-use-it).

## How to use it

1. Enable the module on **both** the source and the receiving environment.
2. Set up the connection between them, and **authenticate it** — only trusted
   environments should be able to push or receive. Serve it over **HTTPS**.
3. Store the connection credentials/tokens in an environment variable (or a Key
   entity), never in committed configuration.
4. Push the content entities you want from the source; they are received on the
   other side, nested structures and base64‑encoded media included.
5. Remember that received content is trusted as coming from the source
   environment — only sync from a source you control.
