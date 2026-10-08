# Blocache — manual setup guide

**Blocache** (`blocache`) gives you per-block control over caching. It adds a
**Cache Settings** section to every block's configuration form, so an administrator
can override that individual block's cacheability — its max-age, cache contexts,
and cache tags — instead of being stuck with whatever defaults the block's code
provides.

This is a practical tool for fixing real caching problems without touching module
code. Is a block showing stale content? Shorten its max-age or add the right cache
tag so it refreshes when the underlying data changes. Is a block showing one user's
personalized content to everyone? Add the missing cache context (like user role or
language) so it varies correctly. Do you have an expensive custom block? Cache it
for a fixed number of seconds to reduce server load. You can even make a block
non-cacheable, which also forces the pages it appears on to skip the page cache.

The three things you can override map directly to Drupal's cacheability model:

- **Max-age** — how long the block may be cached: a number of seconds, `0` for not
  cacheable, or `-1` to cache "forever" (until invalidated by a cache tag).
- **Contexts** — the conditions a block varies by (per URL, per role, per language,
  and so on).
- **Tags** — the cache tags that invalidate the block when related data changes.

Your overrides are stored on the block itself (as third-party settings), so they
export cleanly with the rest of your site configuration. Access to the UI is gated
by a dedicated permission, and if the Token module is installed you can even use
tokens inside cache tags.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-block Cache Settings section,
   field by field, and the permission that controls it.

## Where it lives in the admin menu

Blocache has no settings page of its own. Its controls appear as a **Cache
Settings** section on each block's configuration form, reached from **Structure →
Block layout** (`/admin/structure/block`) by configuring a block. The section is
only visible to users with the **Administer block cache** permission.

## How to use it

Edit any placed block, expand **Cache Settings**, tick **Override cacheability
metadata**, and set the max-age, contexts, and tags you want. Save the block and
its caching behavior changes immediately. See
[Configuration](configuration/index.md) for what each field does.
