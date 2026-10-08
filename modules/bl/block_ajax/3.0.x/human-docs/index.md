# Block Ajax — manual setup guide

**Block Ajax** (`block_ajax`) loads blocks over AJAX after the page has already
rendered. The point is caching: on a cached site, a single block that varies per
user — a basket total, a personalized greeting, a live count — normally drags the
whole page out of the page cache. Rendering that one block separately, after load,
lets the page stay cacheable and moves the small cost to a lightweight request.

The module provides routes at `/block/ajax/{block_id}`, plus variants that render a
block in the context of a node, taxonomy term, or user. They return the rendered
block markup as JSON, and are marked not to cache, which is correct for per-request
block rendering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page and no admin form. The module works entirely through its
AJAX routes (`/block/ajax/{block_id}` and the node/term/user context variants),
which use the **Access content** permission.
