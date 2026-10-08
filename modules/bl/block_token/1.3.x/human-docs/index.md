# Block Token — manual setup guide

**Block Token** (`block_token`) lets you drop a configured block right into the body of a node
(or any other formatted‑text field) using a simple token like
`[block_token:system:navigation]`. Flag a block, and its rendered output becomes available as a
token; combine that with the Token Filter module's "Replace tokens" text‑format filter and
editors can embed a block inline in WYSIWYG content — no Layout Builder, no block regions
required.

It's a handy way to reuse existing content: drop a call‑to‑action or promo block into an
article, insert a newsletter signup mid‑page, or pull a view‑backed block into an otherwise
static page. Because the token references the block by a stable `<module>:<block_id>` name,
you edit the block once and every place the token appears updates automatically. Only blocks
you explicitly flag are exposed (a per‑block opt‑in checkbox), and the block renders through
Drupal's normal, escaped render pipeline with its usual access and visibility rules.

**One thing to know before you enable it.** Block Token affects who can reach the block
configuration screens. With the module enabled, the block edit form and the block layout listing
are reachable by users who have **Administer block token** or **Administer taxonomy** (via the
module's `block_token_route_access()` check). Keep that in mind when you decide which roles get
**Administer block token**. This is covered in [Configuration](configuration/index.md#permissions).

The module depends on core's **Block** module plus the contrib **Token** and **Token Filter**
modules, and ships no submodules. Release `8.x-1.3` is a maintenance/compatibility release with
the same behavior as 1.2.x.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Token / Token Filter
   dependencies) with Composer and enable them.
2. [Configuration](configuration/index.md) — enable the filter, flag a block, use the token in
   content, and the permission detail.

## Where it lives in the admin menu

There is no dedicated settings page. You enable the "Replace tokens" filter under
**Configuration → Content authoring → Text formats and editors**, flag blocks on the normal
block edit forms under **Structure → Block layout**, and grant the permission under **People →
Permissions**.

## How to use it

At a glance: enable Token Filter's **Replace tokens** filter on a text format, edit a block and
tick **Create the token for this block**, copy the token it shows you, and paste it into a field
that uses the token‑enabled format. The full walkthrough is in
[Configuration](configuration/index.md).
