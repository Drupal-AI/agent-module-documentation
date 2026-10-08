# Redirect metrics — manual setup guide

**Redirect metrics** (`redirect_metrics`) adds usage tracking to the redirects
managed by the contrib **Redirect** module. Out of the box, a Drupal redirect is
"fire and forget" — you create a rule that sends `/old-path` to `/new-path`, but
you have no idea whether anyone still uses it. Redirect metrics fills that gap by
recording **how many times each redirect has been used** and **when it was last
hit**, then surfacing two ready-made reports on top of that data.

It's genuinely zero-configuration. The module adds two fields directly to each
redirect — a hit counter and a last-accessed timestamp — and quietly increments
them whenever a redirect actually fires. Because those are real entity fields (not
a separate log table), the numbers are stored right on the redirect, survive
deployments, and can be read, sorted, or filtered anywhere redirects appear.

On top of the data it ships two report pages, added as tabs on the standard
redirect admin screen: **Popular redirects** (sorted by hit count, so you can see
which legacy URLs still attract traffic) and **Stale redirects** (redirects that
haven't been used in over six months, which are usually safe to clean up). It's a
lightweight way to keep your redirect list tidy and to make SEO decisions based on
real usage — without turning on full site statistics or an external analytics tool.

The counting is also cache-friendly: it invalidates the redirect's cache before the
page cache is written, so anonymous visitors keep getting cached responses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Redirect and Views.

## Where it lives in the admin menu

There is no settings page. The reports appear as tabs on the standard redirect
screen at **Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`):

- **All redirects** — the normal redirect list.
- **Popular redirects** — `/admin/config/search/redirect/popular`.
- **Stale redirects** — `/admin/config/search/redirect/stale`.

Access to all of these is governed by the Redirect module's own **Administer
redirects** permission; this module adds no permission of its own.

## How to use it

There is nothing to switch on — once the module is enabled, counting starts
automatically:

1. **Let the data accumulate.** Every time one of your redirects fires, its hit
   count goes up and its last-access time is stamped. You don't need to do anything.

2. **Review the Popular redirects report.** Go to **Configuration → Search and
   metadata → URL redirects → Popular redirects**
   (`/admin/config/search/redirect/popular`). Redirects are listed with their source
   path, target, status code, last-access time, and hit count, sorted by the most
   used first. This tells you which old URLs still matter and which 301s might be
   worth turning into a proper content move.

3. **Review the Stale redirects report.** The **Stale redirects** tab
   (`/admin/config/search/redirect/stale`) lists redirects that haven't been hit in
   more than six months — good candidates for deletion after a migration. Both
   reports include exposed filters (by source, target, and status code) and the
   redirect bulk-operations form, so you can, for example, select all stale
   redirects and delete them in one action.

### Adjusting the reports

The reports are ordinary Views, so you tune them the way you tune any View. To
change the "stale" threshold, the sort order, or the columns, edit the shipped
**redirect_metrics** view under **Structure → Views**
(`/admin/structure/views`) — for instance, change the *Stale redirects* display's
`last_access` filter from "6 months" to a different period. You can also add the hit
count and last-access fields to any other redirect-based View of your own to reuse
the metrics elsewhere.
