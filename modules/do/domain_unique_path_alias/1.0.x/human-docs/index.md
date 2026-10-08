# Domain Unique Path Alias — manual setup guide

**Domain Unique Path Alias** (`domain_unique_path_alias`) lets the *same* URL
alias exist independently on each domain of a [Domain](https://www.drupal.org/project/domain)
(Domain Access) multi‑domain site. By default Drupal treats path aliases as
globally unique: there can be only one `/contact`, pointing at one piece of
content. On a single site that is correct — but on one installation running
several brands, each brand quite reasonably wants its own `/contact`,
`/about`, or `/products`, each resolving to different content. Core refuses the
second alias. This module changes that.

It does so by changing the *constraint* rather than working around it. It adds a
`domain_id` property to core's `path_alias` entity, then makes alias uniqueness
evaluate `alias + domain` instead of `alias` alone. So
`domain1.example.com/contact` and `domain2.example.com/contact` can both exist and
point at different nodes — while a duplicate alias *within the same domain* is
still rejected, exactly as core would. It also replaces Pathauto's "uniquifier"
so that a name already used on another domain no longer gets an ugly `-0` / `-1`
suffix when Pathauto generates it for a second brand.

This is a narrow, targeted fix for one specific incompatibility between Domain and
core aliases — not a general‑purpose alias module. Because it extends core's own
constraint class directly, it is coupled to core's implementation of that class:
after any core minor upgrade, re‑test your aliases to confirm everything still
behaves. It is not covered by Drupal's security advisory policy, and is currently
distributed as a beta seeking a co‑maintainer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Domain, Domain Source, and Pathauto.

There is **no configuration page** for this module. It has no routes, permissions,
or settings form — it changes how alias uniqueness is evaluated the moment it is
enabled. What you "configure" is your aliases themselves, per domain, through the
normal alias and Pathauto UIs.

## How to use it

Enable the module on a Domain site and its per‑domain uniqueness takes effect
immediately. From then on you (or Pathauto) can assign the same alias — `/contact`,
`/about`, and so on — to different content on different domains, and each domain
resolves its own. Pair it with **Domain Source** (a dependency) so each node has a
canonical domain, and let Pathauto generate aliases per domain as usual.

> **Before enabling on an existing site,** audit your current aliases. This module
> changes uniqueness semantics, so it is worth understanding your existing alias
> set first, and re‑testing aliases after any core minor upgrade.
