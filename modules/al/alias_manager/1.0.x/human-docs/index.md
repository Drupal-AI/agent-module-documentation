# Alias Manager — manual setup guide

**Alias Manager** (`alias_manager`) shows, for a given entity, the full list of
URL aliases that point at it. A single node or term can end up with several
pretty URLs over its life; this module surfaces all of them on the entity itself
so editors and administrators can see and manage which addresses resolve to that
piece of content.

It is a small site-structure and administration helper. The aliases it lists are
already public URLs, so it does not change what visitors can reach — its only
access control is its own permission, which governs who is allowed to see the
alias list.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Alias Manager adds no central settings page; it works on the entities themselves,
displaying each entity's list of URL aliases. Access to the list is controlled by
the permission the module provides — grant it to the roles that manage URLs.

## How to use it

Enable the module and grant its permission to the roles that should see alias
lists. From then on, when you view an entity, you can see all the URL aliases
that resolve to it — handy for spotting stale or duplicate paths and keeping an
entity's URLs tidy.
