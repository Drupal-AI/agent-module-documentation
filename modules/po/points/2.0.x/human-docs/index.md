# Points — manual setup guide

**Points** (`points`) defines a flexible **Point** content entity type so a site can
award and track numeric points, credits or balances on users or any other entity.
It is designed as a successor to the Drupal 7 Userpoints module, but with a key
difference: because points are their own content entity, they can be attached to
**any** entity type through a standard entity-reference field, not just users.

The module ships three related pieces. A **Point** content entity holds a numeric
value and has its own access-control handler. **Point types** are configuration
bundles that let you define different kinds of points. And every change to a
point's value is recorded as a **point movement** — a ledger transaction — so you
get a full history of how a balance changed over time, viewable through a bundled
View on a per-entity movements page.

This makes it a good foundation for loyalty programs, credit systems, gamification,
and other financial or transactional features where you need reliable numeric
balances attached to content or users. To prevent conflicting concurrent updates,
the module uses a state-tracking mechanism: when you update a point via the API or
web services, you must set the point's state to the exact value you retrieved, so
simultaneous updates by different clients cannot silently clobber each other.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — administer point entities and types,
   and attach points to other entities.

## Where it lives in the admin menu

Point entities and point types are administered at **`admin/structure/points`**,
behind the **Administer point entities** permission (which is flagged as
restricted). Granular permissions let you separately allow creating, viewing,
editing and deleting point entities.
