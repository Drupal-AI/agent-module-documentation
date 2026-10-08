# group_purl — manual setup guide

**Group PURL** (`group_purl`) is a Persistent URL (PURL) provider for the
[Group](https://www.drupal.org/project/group) module. It lets the *active group*
be derived from the URL — typically a path prefix or a domain — so that browsing,
adding content, and Views all pick up the right group context automatically from
the address a visitor is on.

Once a group is matched from the URL, group_purl sets it as the current group
context and can rewrite links on the page to keep that context as the visitor
moves around. This is what makes a group‑based site feel like a coherent
"section": visit a group's prefix and the pages, content forms, and Views under
it all operate within that group.

It's important to understand its role. group_purl only *resolves* which group is
active from the URL — it does not grant or deny access itself. Actual access still
comes from the Group module's membership and permissions. Think of it as the piece
that answers "which group am I in?" and leaves "what may I do here?" to Group.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group and PURL.

There is **no dedicated settings page** for this module. You configure it by
wiring up the PURL modifier for groups, described below.

## How to use it

group_purl supplies several plugins to the PURL system:

- A **Group provider**, which registers the Group entity type with PURL so groups
  can act as PURL "entities".
- A **Group prefix method**, which applies group context to any path that begins
  with a matched group prefix (but isn't exactly that prefix) — giving content
  reached through the group path its group context, and rewriting page URLs to
  keep the prefix.
- A **Group context** provider that becomes active whenever PURL matches a group.
- A Views **default argument** plugin that automatically filters a view by the
  active group when a group context is in play.

Setup happens in the PURL module's configuration: you create a PURL modifier for
groups (choosing the prefix or domain method) so that URLs resolve to a group.
After that, browsing under a group's URL keeps you "in" that group. Because it
depends on both Group and PURL, make sure Group is set up with group types and
groups, and PURL is installed, before configuring the modifier.
