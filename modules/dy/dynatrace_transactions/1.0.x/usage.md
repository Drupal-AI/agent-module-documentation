<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynatrace Transactions renames each Drupal request's Dynatrace transaction/trace using the route path template, the entity bundle, and the current user's highest-weight role.

---

Dynatrace Transactions is a small, dependency-free port of the New Relic Transactions module for sites monitored with Dynatrace. On every master request an event subscriber (priority 28, before Dynamic Page Cache) computes a human-friendly transaction name: it takes the matched route's path template (e.g. `/node/{node}`), replaces any entity-type route parameter with that entity's bundle (`/node/{article}`), strips the leading slash, and appends the visiting user's highest-weight enabled role in parentheses (`node/{article} (editor)`). Users with no enabled role are tagged `(other)`. Because Dynatrace has no PHP extension, the module does not call an APM function or make any HTTP call; it simply passes the computed name to the argument of `TransactionNamer::setTransactionName()`. You then configure Dynatrace's OneAgent to capture that method argument as a request attribute and use it to name the trace. A settings form lets you restrict which roles are considered for the role suffix; leaving it empty means all roles are considered. There are no permissions of its own, no Drush commands, no plugins, and no external libraries — configuration is a single config object, `dynatrace_transactions.config`, holding the enabled-role list.

---

- Give Dynatrace traces meaningful names for a Drupal site instead of generic `index.php` entries.
- Group traces by logical route (e.g. all article views under `node/{article}`) rather than by raw URL with entity IDs.
- Collapse per-entity URLs (`/node/123`, `/node/456`) into a single bundle-based name so dashboards aggregate correctly.
- Segment Dynatrace performance data by the visiting user's role (anonymous vs. authenticated vs. editor).
- Compare page-load / server timing for the same route across different user roles.
- Migrate an existing New Relic Transactions naming convention to Dynatrace with the same route/bundle/role scheme.
- Identify slow admin routes by their route template in Dynatrace service analysis.
- Distinguish AJAX/sub-route traffic from the main page route (sub-requests are skipped, so only the master request is named).
- Feed a Dynatrace request attribute that powers management zones, service splitting, or SLO scopes based on route.
- Limit the role suffix to only meaningful roles (e.g. just `editor` and `administrator`) via the settings form.
- Tag anonymous traffic distinctly (users with no enabled role become `other`) for cache/anonymous performance analysis.
- Build Dynatrace charts that break down response time by bundle for content-heavy sites.
- Detect which content types generate the most/slowest requests without parsing URLs.
- Provide consistent trace names across multiple Drupal environments monitored by the same Dynatrace tenant.
- Let other custom modules set their own transaction name by calling the shared `dynatrace_transactions.transaction_namer` service.
- Name background/cron or route-less requests gracefully (they fall through the master-request check).
- Support Drupal 8.8 through 11 with no contrib dependencies and no external PHP libraries.
- Keep monitoring naming logic in code/config rather than in Dynatrace's URL-rewriting rules.
- Reduce trace cardinality in Dynatrace by removing entity IDs from names.
- Audit which routes are actually hit in production by reviewing the distinct transaction names Dynatrace records.
