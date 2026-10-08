# Cache browser — manual setup guide

**Cache browser** (`cache_browser`) is an administrative debugging tool that lets you
inspect Drupal's cache from the UI. It lists all the cache **bins** on the site, lets you
**browse the entries** in a bin, **inspect a single entry by its CID**, and **clear a
bin** — invaluable when you are trying to understand why a page is or isn't cached, verify
what a cached entry actually contains, or confirm that a deployment cleared the right bin.

It understands several cache backends through a small plugin system (database, APCu,
memory, chained‑fast, and backend chain), so it can enumerate entries regardless of how a
bin is stored. Support for other backends can be added via the Drupal Plugin API.

The module works as soon as it is enabled — there is nothing to configure. Everything
happens on the reports screens described below, and access is controlled entirely by a
single permission.

**Please read the security guidance before using it.** The contents of Drupal caches are
very likely to contain sensitive and personally identifiable information, and details that
would help an attacker compromise a site. The maintainers therefore recommend you:

- **Avoid adding this module to a production site.** Install it as a *development*
  dependency instead — `composer require --dev drupal/cache_browser`.
- **Grant the *Access cache browser* permission only to fully trusted users.** Treat it as
  equivalent to granting access to user 1.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install (as a dev dependency), enable, and
   grant the permission.

There is **no configuration page** for this module — it has no settings form. The only
setup beyond enabling it is granting the *Access cache browser* permission to the right
people, which the installation guide covers.

## Where it lives in the admin menu

Cache browser lives under **Reports → Cache** (`/admin/reports/cache`). From the summary
you can drill in:

- **`/admin/reports/cache`** — a summary of all cache bins (and, for database‑backed bins,
  their size).
- **`/admin/reports/cache/{bin}`** — browse the entries in one bin.
- **`/admin/reports/cache/{bin}/cid/{cid}`** — view a single cache item by its CID.
- **`/admin/reports/cache/{bin}/clear`** — clear that bin.

Every one of these screens requires the **Access cache browser** permission.
