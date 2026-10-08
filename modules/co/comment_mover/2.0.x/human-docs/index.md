# Comment Mover — manual setup guide

**Comment Mover** (`comment_mover`) lets administrators relocate comments — and
their whole reply threads — from one place to another using a familiar
**cut‑and‑paste clipboard** metaphor, and even convert between nodes and comments.
It's the tool you reach for when a discussion has ended up in the wrong place: an
off‑topic reply that belongs on another node, duplicate threads that should be
merged, or a comment that really deserves to be its own forum topic.

With it you can move comments below other comments on the same node, move comments
to a different node or comment, convert comments into a forum topic (or any other
node type), and convert nodes into comments while preserving data from matching
field instances. Child comments always travel with their parent, keeping thread
structure intact, and affected caches are invalidated automatically after a move.
The workflow runs through a **Clipboard** block you place on your site, plus "cut"
and "paste" links that appear under nodes and comments.

Everything is gated behind core's sensitive **`administer comments`** permission,
so only trusted users can use it. Version 2.0.x targets Drupal 10/11 and is under active
development (alpha), so test it before relying on it in production. It depends on
core's Node and Comment modules and has no other required dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, place
   the Clipboard block, and set permissions.

There is **no settings form** — setup is enabling the module and placing the
Clipboard block, described below and in [Installation](installation/index.md).

## Where it lives in the admin menu

Comment Mover has no configuration page of its own. You place its **Clipboard**
block from **Structure → Block layout** (`/admin/structure/block`), and the
cut/paste links then appear beneath nodes and comments for users who hold
`administer comments`.

## How to use it

1. **Cut** — click the **cut** link under a node or comment you want to move. It's
   added to the Clipboard block (you can remove items from the clipboard with the
   red cross icon).
2. **Paste** — go to the target and click **paste**:
   - Paste under a **node** and the clipboard items become first‑level comments on
     that node (nested comments keep their thread positions).
   - Paste under a **comment** and the items become child comments of that comment.
   - Moved entities are removed from their previous location.
3. **Convert** — to turn the clipboard's items into nodes, pick a node type in the
   select box under the Clipboard block; if cut comments share field instances with
   the destination node type, that field data moves along too.

Optional integrations enhance this: with the **Forum** module installed you get a
"paste" link on main forum pages to paste comments as new forum topics, and with
**Flatcomments** installed, paste links appear only on entities (not comments).
