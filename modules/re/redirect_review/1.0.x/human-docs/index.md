# Redirect Review — manual setup guide

**Redirect Review** (`redirect_review`) gives you an overview of redirects that
have gone bad. On a site that has accumulated hundreds of redirects over the
years, it's easy to lose track of which ones still do what they were meant to do.
This module provides a Views‑based report listing redirects with problems —
those that now resolve to a **403**, a **404**, or that form a **redirect loop**
— so you can spot the broken ones and fix them by hand (edit the redirect to
point somewhere sensible, or delete it altogether).

> **Please note:** this project is marked **Unsupported / Obsolete** by its
> maintainer, and it is **not covered by Drupal's security advisory policy**. The
> maintainer recommends using the
> [Redirect Audit](https://www.drupal.org/project/redirect_audit) module instead.
> Choose Redirect Audit for new sites; this guide is here for completeness and for
> teams maintaining an existing install.

Because it is built on Views, the report is just a Drupal view — you can adjust
its columns, filters, and access like any other view once the module is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect and Views.

There is **no configuration page** for this module. Once enabled it provides its
report through Views; there are no settings to fill in.

## How to use it

After enabling the module, open the redirect problem report it provides (a Views
listing of redirects that resolve to 403, 404, or a loop). Review each entry and
act manually — edit the redirect to point at the correct destination, or delete
it if it is no longer needed. Because the report is a view, you can refine its
filters and displayed fields through **Structure → Views** if you want to tailor
what it shows.
