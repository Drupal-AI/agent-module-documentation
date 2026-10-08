# Cache Pilot — manual setup guide

**Cache Pilot** (`cache_pilot`) gives you simple tools to inspect and clear PHP's
**APCu** cache from inside the Drupal admin. APCu is the PHP user/opcode cache that
lives on the server, separate from Drupal's own database caches — normally you can
only touch it by restarting PHP or shelling in. Cache Pilot puts a view-and-clear
control in the admin so operators can manage it without server access.

This is a performance and operations tool. It defines its own permission so you can
decide who is allowed to view and clear APCu, and it has no other role in content or
access control.

One thing to understand before you use it: **APCu is a server-level resource.** On a
host where several sites share the same PHP process, clearing APCu affects *every*
request and *every* tenant on that process, not just this Drupal site. Treat the
clear action as a whole-server operation and grant the permission only to trusted
administrators.

The module works on Drupal 10.3 and 11.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Cache Pilot adds an APCu management area to the Drupal admin, reachable by users who
hold its permission. From there you can inspect the current APCu cache and clear it.

## How to use it

After enabling the module, grant the Cache Pilot permission to the trusted roles
that should manage APCu (**People → Permissions**). Those users can then open the
APCu tools to view the cache and clear it when needed — for example after a deploy
that changed cached PHP values. Remember that a clear affects the whole PHP process,
so use it deliberately, especially on shared hosting.
