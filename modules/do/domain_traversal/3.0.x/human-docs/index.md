# Domain Traversal — manual setup guide

**Domain Traversal** (`domain_traversal`) adds per‑domain menu items so that
logged‑in editors and administrators can hop between the domains of a
multi‑domain site without hand‑editing URLs. It is built for sites running the
[Domain](https://www.drupal.org/project/domain) (Domain Access) module: click the
menu link for another domain and — if you have the right permission — you land on
that domain already logged in.

The name can be misleading, so it is worth stating plainly: "traversal" here
means *navigating between domains*, not path traversal. The module is purely a
navigation convenience. It adds menu items and provides its own permissions, but
it has no access‑control role of its own — Domain's own access controls still
decide what each domain shows and who may see it.

It depends only on the Domain module and works on Drupal 9, 10, and 11. This is a
minimally maintained module with no further development planned, but it remains
security‑advisory covered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Domain.

There is no dedicated settings form for this module, so there is no separate
Configuration page in this guide. What you configure is *which domains appear* as
menu items, handled through the standard Domain and menu tooling once the module
is enabled and its permissions are granted.

## How to use it

Once enabled, Domain Traversal contributes per‑domain menu items. Grant the
module's permissions to the roles that manage the site (editors, administrators),
then those users will see links for each configured domain and can click through
to the same context on another domain — arriving logged in, subject to Domain's
access rules. It is aimed squarely at speeding up multi‑domain administration and
review, where you would otherwise be retyping hostnames by hand.
